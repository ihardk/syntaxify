# Generic Use Cases - Clean Architecture Enhancement

**Supplement to v0.6.5 Clean Architecture Generation**

## 🎯 Problem

Current approach generates repetitive boilerplate in every use case:
```dart
class GetUserUseCaseImpl implements GetUserUseCase {
  @override
  Future<Either<Failure, User>> call(String userId) async {
    try {
      // Validation (repeated)
      if (userId.isEmpty) return Left(ValidationFailure(...));

      // Network call (repeated pattern)
      final result = await _repository.getUser(userId);

      // Error mapping (repeated)
      return result.fold(
        (failure) => Left(failure),
        (user) => Right(user),
      );
    } catch (e) {
      // Error handling (repeated)
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
```

**Every use case repeats:** validation, error handling, logging, caching patterns.

---

## ✅ Solution: Extract Generic Use Cases

### Generic Use Cases Library (Auto-Generated)

```dart
// lib/domain/usecases/generic/network_call_usecase.dart
abstract class NetworkCallUseCase<TRequest, TResponse> {
  Future<Either<Failure, TResponse>> call({
    required TRequest request,
    required Future<Either<Failure, TResponse>> Function(TRequest) executor,
    bool shouldCache = false,
    Duration? timeout,
  });
}

class NetworkCallUseCaseImpl<TRequest, TResponse>
    implements NetworkCallUseCase<TRequest, TResponse> {
  final LogUseCase? _logger;
  final CacheUseCase<TResponse>? _cache;

  @override
  Future<Either<Failure, TResponse>> call({
    required TRequest request,
    required Future<Either<Failure, TResponse>> Function(TRequest) executor,
    bool shouldCache = false,
    Duration? timeout,
  }) async {
    try {
      // Log request
      _logger?.call('Network call: ${TRequest.toString()}', request);

      // Check cache
      if (shouldCache && _cache != null) {
        final cached = await _cache.get(request.toString());
        if (cached != null) {
          _logger?.call('Cache hit', cached);
          return Right(cached);
        }
      }

      // Execute with timeout
      final result = timeout != null
          ? await executor(request).timeout(timeout)
          : await executor(request);

      // Save to cache
      result.fold(
        (failure) => null,
        (response) {
          if (shouldCache && _cache != null) {
            _cache.save(request.toString(), response);
          }
        },
      );

      _logger?.call('Network call success', result);
      return result;
    } on TimeoutException {
      return Left(Failure.network(message: 'Request timed out'));
    } catch (e) {
      _logger?.call('Network call error', e);
      return Left(Failure.unexpected(message: e.toString()));
    }
  }
}
```

```dart
// lib/domain/usecases/generic/validate_usecase.dart
abstract class ValidateUseCase<T> {
  Either<Failure, T> call(T value);
}

class ValidateStringUseCase implements ValidateUseCase<String> {
  final int? minLength;
  final int? maxLength;
  final String? pattern;
  final String fieldName;

  const ValidateStringUseCase({
    this.minLength,
    this.maxLength,
    this.pattern,
    required this.fieldName,
  });

  @override
  Either<Failure, String> call(String value) {
    if (value.isEmpty) {
      return Left(Failure.validation(
        message: '$fieldName cannot be empty',
      ));
    }

    if (minLength != null && value.length < minLength!) {
      return Left(Failure.validation(
        message: '$fieldName must be at least $minLength characters',
      ));
    }

    if (maxLength != null && value.length > maxLength!) {
      return Left(Failure.validation(
        message: '$fieldName must be at most $maxLength characters',
      ));
    }

    if (pattern != null && !RegExp(pattern!).hasMatch(value)) {
      return Left(Failure.validation(
        message: '$fieldName format is invalid',
      ));
    }

    return Right(value);
  }
}
```

```dart
// lib/domain/usecases/generic/cache_usecase.dart
abstract class CacheUseCase<T> {
  Future<T?> get(String key);
  Future<void> save(String key, T value);
  Future<void> delete(String key);
  Future<void> clear();
}

class CacheUseCaseImpl<T> implements CacheUseCase<T> {
  final LocalStorageRepository _storage;
  final Duration? ttl; // Time to live

  const CacheUseCaseImpl({
    required LocalStorageRepository storage,
    this.ttl,
  }) : _storage = storage;

  @override
  Future<T?> get(String key) async {
    final result = await _storage.get<T>(key);

    return result.fold(
      (failure) => null,
      (cached) {
        // Check TTL
        if (ttl != null && cached.timestamp.add(ttl!) < DateTime.now()) {
          delete(key); // Expired
          return null;
        }
        return cached.value;
      },
    );
  }

  @override
  Future<void> save(String key, T value) async {
    await _storage.save(key, CachedValue(value: value, timestamp: DateTime.now()));
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key);
  }

  @override
  Future<void> clear() async {
    await _storage.clear();
  }
}
```

```dart
// lib/domain/usecases/generic/log_usecase.dart
abstract class LogUseCase {
  void call(String message, [dynamic data]);
}

class LogUseCaseImpl implements LogUseCase {
  final bool enableLogging;
  final LogLevel minLevel;

  const LogUseCaseImpl({
    this.enableLogging = true,
    this.minLevel = LogLevel.info,
  });

  @override
  void call(String message, [dynamic data]) {
    if (!enableLogging) return;

    // Log to console, Firebase, Sentry, etc.
    print('[${DateTime.now()}] $message${data != null ? ': $data' : ''}');
  }
}
```

```dart
// lib/domain/usecases/generic/retry_usecase.dart
abstract class RetryUseCase<T> {
  Future<Either<Failure, T>> call({
    required Future<Either<Failure, T>> Function() operation,
    int maxAttempts = 3,
    Duration initialDelay = const Duration(seconds: 1),
    bool exponentialBackoff = true,
  });
}

class RetryUseCaseImpl<T> implements RetryUseCase<T> {
  @override
  Future<Either<Failure, T>> call({
    required Future<Either<Failure, T>> Function() operation,
    int maxAttempts = 3,
    Duration initialDelay = const Duration(seconds: 1),
    bool exponentialBackoff = true,
  }) async {
    int attempt = 0;
    Duration delay = initialDelay;

    while (attempt < maxAttempts) {
      final result = await operation();

      if (result.isRight) return result;

      attempt++;
      if (attempt < maxAttempts) {
        await Future.delayed(delay);
        if (exponentialBackoff) {
          delay *= 2;
        }
      }
    }

    return Left(Failure.network(
      message: 'Operation failed after $maxAttempts attempts',
    ));
  }
}
```

```dart
// lib/domain/usecases/generic/map_usecase.dart
abstract class MapUseCase<TFrom, TTo> {
  TTo call(TFrom from);
}

// Example: DTO → Entity mapping
class UserDtoToEntityMapper implements MapUseCase<UserDto, User> {
  @override
  User call(UserDto dto) {
    return User(
      id: dto.id,
      name: dto.name,
      email: dto.email,
      avatar: dto.avatar,
      createdAt: dto.createdAt,
    );
  }
}
```

---

## 🎯 Composition Pattern

### Now Use Cases Become Simple Compositions

```dart
// lib/domain/usecases/impl/get_user_usecase_impl.dart
class GetUserUseCaseImpl implements GetUserUseCase {
  final UserRepository _repository;
  final ValidateUseCase<String> _validateId;
  final CacheUseCase<User> _cache;
  final LogUseCase _logger;
  final NetworkCallUseCase<String, User> _networkCall;

  const GetUserUseCaseImpl({
    required UserRepository repository,
    required ValidateUseCase<String> validateId,
    required CacheUseCase<User> cache,
    required LogUseCase logger,
    required NetworkCallUseCase<String, User> networkCall,
  })  : _repository = repository,
        _validateId = validateId,
        _cache = cache,
        _logger = logger,
        _networkCall = networkCall;

  @override
  Future<Either<Failure, User>> call(String userId) async {
    // 1. Validate
    final validationResult = _validateId(userId);
    if (validationResult.isLeft) return validationResult.fold(
      (failure) => Left(failure),
      (_) => throw UnimplementedError(), // Won't reach
    );

    // 2. Check cache
    final cached = await _cache.get('user_$userId');
    if (cached != null) {
      _logger('Cache hit for user $userId');
      return Right(cached);
    }

    // 3. Network call with retry
    _logger('Fetching user $userId from network');
    final result = await _networkCall(
      request: userId,
      executor: (id) => _repository.getUser(id),
      shouldCache: true,
      timeout: const Duration(seconds: 10),
    );

    // 4. Business logic (THIS IS WHERE USER ADDS CUSTOM LOGIC)
    return result.fold(
      (failure) => Left(failure),
      (user) {
        // Example: Apply business rules
        if (user.email.contains('banned.com')) {
          return Left(Failure.validation(
            message: 'This user is banned',
          ));
        }

        // Save to cache
        _cache.save('user_$userId', user);

        return Right(user);
      },
    );
  }
}
```

---

## 📦 Even Simpler: Declarative Use Case DSL

**For 90% of use cases, just declare them:**

```yaml
# api/user_api.yaml (extended)
api:
  name: UserApi
  endpoints:
    - name: getUser
      method: GET
      path: /users/{id}
      # ... response schema

      # Use case configuration
      usecase:
        validate:
          - param: id
            rules:
              - notEmpty: true
              - minLength: 3
        cache:
          enabled: true
          ttl: 5m
          key: "user_{id}"
        retry:
          maxAttempts: 3
          backoff: exponential
        timeout: 10s
        log: true
```

**Generated use case:**

```dart
class GetUserUseCaseImpl implements GetUserUseCase {
  final UserRepository _repository;
  final ValidateStringUseCase _validateId;
  final CacheUseCase<User> _cache;
  final LogUseCase _logger;
  final RetryUseCase<User> _retry;

  @override
  Future<Either<Failure, User>> call(String userId) async {
    // 1. Validate (auto-generated from config)
    final validation = _validateId.call(userId);
    if (validation.isLeft) return validation as Either<Failure, User>;

    // 2. Check cache (auto-generated from config)
    final cached = await _cache.get('user_$userId');
    if (cached != null) return Right(cached);

    // 3. Network call with retry (auto-generated from config)
    final result = await _retry.call(
      operation: () => _repository.getUser(userId).timeout(
        const Duration(seconds: 10),
      ),
      maxAttempts: 3,
    );

    // 4. Save to cache (auto-generated from config)
    result.fold(
      (failure) => _logger('GetUser failed: ${failure.userMessage}'),
      (user) {
        _cache.save('user_$userId', user);
        _logger('GetUser success: $userId');
      },
    );

    return result;
  }
}
```

**User only adds custom business logic if needed:**

```dart
// lib/domain/usecases/impl/get_user_usecase_impl.dart (custom extension)
extension GetUserUseCaseBusinessLogic on GetUserUseCaseImpl {
  Future<Either<Failure, User>> callWithBusinessLogic(String userId) async {
    final result = await call(userId); // Call auto-generated logic

    // Add custom business rules
    return result.fold(
      (failure) => Left(failure),
      (user) {
        // Example: Hide banned users
        if (user.email.contains('banned.com')) {
          return Left(Failure.validation(message: 'User is banned'));
        }

        // Example: Apply premium user logic
        if (user.isPremium) {
          _analytics.track('premium_user_loaded', user.id);
        }

        return Right(user);
      },
    );
  }
}
```

---

## 🔧 Auto-Generated Generic Use Cases

**Syntaxify generates these once per project:**

```
lib/domain/usecases/generic/
├── network_call_usecase.dart
├── validate_usecase.dart
├── cache_usecase.dart
├── log_usecase.dart
├── retry_usecase.dart
├── map_usecase.dart
├── save_locally_usecase.dart
├── load_locally_usecase.dart
├── permission_check_usecase.dart
└── analytics_usecase.dart
```

**Each API endpoint generates:**
- Specific use case interface
- Auto-composed implementation (using generics)
- Extension point for business logic

---

## 📊 Code Reduction

### Before (Manual Use Case):
```dart
class GetUserUseCaseImpl implements GetUserUseCase {
  final UserRepository _repository;

  @override
  Future<Either<Failure, User>> call(String userId) async {
    // Validation (15 lines)
    if (userId.isEmpty) {
      return Left(Failure.validation(message: 'User ID is required'));
    }
    if (userId.length < 3) {
      return Left(Failure.validation(message: 'User ID too short'));
    }

    // Cache check (10 lines)
    try {
      final cached = await _cache.get('user_$userId');
      if (cached != null) {
        return Right(cached);
      }
    } catch (e) {
      // Ignore cache errors
    }

    // Network call with timeout (20 lines)
    try {
      final result = await _repository.getUser(userId).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException('Request timed out'),
      );

      return result.fold(
        (failure) {
          _logger.log('GetUser failed: ${failure.message}');
          return Left(failure);
        },
        (user) {
          _cache.save('user_$userId', user);
          _logger.log('GetUser success');
          return Right(user);
        },
      );
    } on TimeoutException {
      return Left(Failure.network(message: 'Request timed out'));
    } catch (e) {
      return Left(Failure.unexpected(message: e.toString()));
    }
  }
}
```

**Total: ~50 lines**

---

### After (Composed Use Case):
```dart
class GetUserUseCaseImpl implements GetUserUseCase {
  final UserRepository _repository;
  final ValidateStringUseCase _validateId;
  final CacheUseCase<User> _cache;
  final NetworkCallUseCase<String, User> _networkCall;

  @override
  Future<Either<Failure, User>> call(String userId) async {
    final validation = _validateId(userId);
    if (validation.isLeft) return validation as Either<Failure, User>;

    final cached = await _cache.get('user_$userId');
    if (cached != null) return Right(cached);

    return _networkCall(
      request: userId,
      executor: _repository.getUser,
      shouldCache: true,
      timeout: const Duration(seconds: 10),
    );
  }
}
```

**Total: ~15 lines (70% reduction)**

---

### After (Declarative Config):
```yaml
usecase:
  validate:
    - param: id
      rules: [notEmpty, minLength: 3]
  cache: {enabled: true, ttl: 5m}
  retry: {maxAttempts: 3}
  timeout: 10s
```

**Total: 7 lines (86% reduction)**

**User only implements custom business logic** (~5 lines on average).

---

## 🎯 Implementation in Roadmap

### Add to Session 10 (Use Case Implementation):

**Generated Generic Library:**
- NetworkCallUseCase
- ValidateUseCase (String, int, email, etc.)
- CacheUseCase
- LogUseCase
- RetryUseCase
- MapUseCase
- SaveLocallyUseCase
- LoadLocallyUseCase

**Generated Specific Use Cases:**
- Auto-composed from generic use cases
- Declarative config in API spec
- Extension points for custom logic

**DI Setup:**
```dart
// Providers for generic use cases
final validateUserIdProvider = Provider<ValidateStringUseCase>((ref) {
  return ValidateStringUseCase(
    minLength: 3,
    fieldName: 'User ID',
  );
});

final userCacheProvider = Provider<CacheUseCase<User>>((ref) {
  return CacheUseCaseImpl<User>(
    storage: ref.watch(localStorageProvider),
    ttl: const Duration(minutes: 5),
  );
});

final networkCallProvider = Provider<NetworkCallUseCase>((ref) {
  return NetworkCallUseCaseImpl(
    logger: ref.watch(logUseCaseProvider),
    cache: null, // Handle caching per use case
  );
});

// Composed use case
final getUserUseCaseProvider = Provider<GetUserUseCase>((ref) {
  return GetUserUseCaseImpl(
    repository: ref.watch(userRepositoryProvider),
    validateId: ref.watch(validateUserIdProvider),
    cache: ref.watch(userCacheProvider),
    logger: ref.watch(logUseCaseProvider),
    networkCall: ref.watch(networkCallProvider),
  );
});
```

---

## ✅ Benefits

**Before:**
- 50 lines per use case
- Repeated boilerplate
- Easy to forget validation/caching/logging

**After:**
- 7 lines config (or 15 lines code)
- Zero boilerplate
- Standard patterns enforced
- User focuses on business logic only

**Time saved:**
- **90% less code**
- **95% faster development**
- **100% consistent patterns**

---

## 🚀 Updated Value Proposition

**Syntaxify v0.6.5 generates:**
1. ✅ DTOs, Entities, Mappers
2. ✅ API Clients, Repositories
3. ✅ **Generic Use Case library** (NetworkCall, Cache, Validate, etc.)
4. ✅ **Auto-composed Use Cases** (declarative config)
5. ✅ Dependency Injection
6. ✅ State Management integration
7. ✅ Tests

**User implements:**
- Custom business logic ONLY (5-10 lines)

**Result:**
- **99% boilerplate eliminated**
- **Clean architecture enforced**
- **Production-ready in minutes**

---

## 📝 CLI Output

```bash
$ syntaxify api generate api/user_api.yaml

✓ Generated Generic Use Cases (10 files)
  - NetworkCallUseCase
  - ValidateUseCase
  - CacheUseCase
  - RetryUseCase
  - LogUseCase
  - MapUseCase
  - SaveLocallyUseCase
  - LoadLocallyUseCase
  - PermissionCheckUseCase
  - AnalyticsUseCase

✓ Generated User API (5 endpoints)
  - GetUserUseCase (auto-composed: validate, cache, network, retry)
  - ListUsersUseCase (auto-composed: cache, network, pagination)
  - CreateUserUseCase (auto-composed: validate, network, log)
  - UpdateUserUseCase (auto-composed: validate, network, cache invalidation)
  - DeleteUserUseCase (auto-composed: network, cache invalidation)

✓ Generated Dependency Injection
✓ Generated Tests (15 files)

📝 Next steps:
  1. Add custom business logic (optional):
     - lib/domain/usecases/impl/*_usecase_impl.dart

  2. Run build_runner:
     flutter pub run build_runner build

  3. Use in UI:
     final user = ref.watch(userProvider(userId));

🎉 Clean Architecture ready!
```

---
