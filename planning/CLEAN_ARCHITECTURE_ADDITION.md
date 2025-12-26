# Clean Architecture API Generation - Addition to Roadmap

**Insert after v0.6.0 Session 12, before v0.7.0**

---

## v0.6.5: Clean Architecture Backend Integration (5 weeks)
**Goal:** Generate entire clean architecture from API specs - user only implements use case logic
**Total Effort:** ~48 hours (16 sessions × 3h)

### Architecture Overview

```
API Spec (OpenAPI/Custom DSL)
          ↓
┌─────────────────────────────────────────────────┐
│         SYNTAXIFY GENERATES ALL THIS           │
├─────────────────────────────────────────────────┤
│                                                 │
│  📦 DATA LAYER                                 │
│    ├── DTOs (fromJson/toJson)                 │
│    ├── API Clients (Dio/http)                 │
│    ├── Repository Implementations             │
│    └── Mappers (DTO ↔ Entity)                │
│                                                 │
│  📦 DOMAIN LAYER                               │
│    ├── Entities (immutable)                   │
│    ├── Repository Interfaces                  │
│    ├── Use Case Interfaces                    │
│    └── Failures (error types)                 │
│                                                 │
│  📦 PRESENTATION LAYER                         │
│    ├── Providers (Riverpod)                   │
│    ├── BLoCs (if using Bloc)                  │
│    └── State Classes                          │
│                                                 │
└─────────────────────────────────────────────────┘
          ↓
   USER IMPLEMENTS ONLY THIS
          ↓
    Use Case Logic
    (business rules)
```

---

### Session 1: API Specification DSL (3h)
**Deliverables:**
- API definition syntax
- OpenAPI/Swagger parser
- Custom DSL parser
- Validation

**DSL Syntax:**
```yaml
# api/user_api.yaml
api:
  name: UserApi
  base_url: https://api.example.com/v1

endpoints:
  - name: getUser
    method: GET
    path: /users/{id}
    params:
      - name: id
        type: String
        in: path
        required: true
    response:
      type: User
      schema:
        id: String
        name: String
        email: String
        avatar: String?
        createdAt: DateTime

  - name: listUsers
    method: GET
    path: /users
    params:
      - name: page
        type: int
        in: query
        default: 1
      - name: limit
        type: int
        in: query
        default: 20
    response:
      type: List<User>

  - name: createUser
    method: POST
    path: /users
    body:
      type: CreateUserRequest
      schema:
        name: String
        email: String
        password: String
    response:
      type: User

  - name: updateUser
    method: PUT
    path: /users/{id}
    params:
      - name: id
        type: String
        in: path
    body:
      type: UpdateUserRequest
      schema:
        name: String?
        avatar: String?
    response:
      type: User

  - name: deleteUser
    method: DELETE
    path: /users/{id}
    params:
      - name: id
        type: String
        in: path
    response:
      type: void
```

**OpenAPI Support:**
```dart
// Alternative: Import from OpenAPI
syntaxify api import openapi.yaml
// Converts OpenAPI → Syntaxify API DSL
```

---

### Session 2: DTO Generation (3h)
**Deliverables:**
- Generate DTOs from schema
- JSON serialization (json_serializable)
- Freezed integration
- Validation

**Generated:**
```dart
// lib/data/dtos/user_dto.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String name,
    required String email,
    String? avatar,
    required DateTime createdAt,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

@freezed
class CreateUserRequestDto with _$CreateUserRequestDto {
  const factory CreateUserRequestDto({
    required String name,
    required String email,
    required String password,
  }) = _CreateUserRequestDto;

  factory CreateUserRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserRequestDtoToJson(this);
}
```

---

### Session 3: Entity Generation (3h)
**Deliverables:**
- Generate domain entities
- Immutable models
- Business logic methods
- Entity validation

**Generated:**
```dart
// lib/domain/entities/user.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._(); // Private constructor for methods

  const factory User({
    required String id,
    required String name,
    required String email,
    String? avatar,
    required DateTime createdAt,
  }) = _User;

  // Business logic methods (user can add more)
  bool get hasAvatar => avatar != null && avatar!.isNotEmpty;

  String get displayName => name.trim();

  bool get isNew {
    final daysSinceCreation = DateTime.now().difference(createdAt).inDays;
    return daysSinceCreation < 7;
  }
}

@freezed
class CreateUserRequest with _$CreateUserRequest {
  const factory CreateUserRequest({
    required String name,
    required String email,
    required String password,
  }) = _CreateUserRequest;
}
```

---

### Session 4: Mapper Generation (3h)
**Deliverables:**
- DTO ↔ Entity mappers
- Extension methods
- Type-safe conversions
- Null handling

**Generated:**
```dart
// lib/data/mappers/user_mapper.dart
extension UserDtoMapper on UserDto {
  /// Convert DTO to Domain Entity
  User toDomain() {
    return User(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      createdAt: createdAt,
    );
  }
}

extension UserMapper on User {
  /// Convert Domain Entity to DTO (for updates)
  UserDto toDto() {
    return UserDto(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      createdAt: createdAt,
    );
  }
}

extension CreateUserRequestMapper on CreateUserRequest {
  CreateUserRequestDto toDto() {
    return CreateUserRequestDto(
      name: name,
      email: email,
      password: password,
    );
  }
}
```

---

### Session 5: API Client Generation (3h)
**Deliverables:**
- HTTP client implementation
- Dio integration
- Request/response handling
- Error handling

**Generated:**
```dart
// lib/data/api/user_api_client.dart
import 'package:dio/dio.dart';
import '../dtos/user_dto.dart';

class UserApiClient {
  final Dio _dio;
  final String _baseUrl;

  UserApiClient({
    required Dio dio,
    String baseUrl = 'https://api.example.com/v1',
  })  : _dio = dio,
        _baseUrl = baseUrl;

  Future<UserDto> getUser(String id) async {
    try {
      final response = await _dio.get('$_baseUrl/users/$id');
      return UserDto.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<UserDto>> listUsers({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/users',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      return (response.data as List)
          .map((json) => UserDto.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserDto> createUser(CreateUserRequestDto request) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/users',
        data: request.toJson(),
      );
      return UserDto.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserDto> updateUser(String id, UpdateUserRequestDto request) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/users/$id',
        data: request.toJson(),
      );
      return UserDto.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _dio.delete('$_baseUrl/users/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  ApiException _handleError(DioException error) {
    if (error.response != null) {
      return ServerException(
        statusCode: error.response!.statusCode ?? 500,
        message: error.response!.data['message'] ?? 'Server error',
      );
    }
    return NetworkException(error.message ?? 'Network error');
  }
}
```

---

### Session 6: Failure Types Generation (3h)
**Deliverables:**
- Sealed failure classes
- Error categorization
- User-friendly messages
- Error recovery hints

**Generated:**
```dart
// lib/domain/failures/failure.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.server({
    required int statusCode,
    required String message,
  }) = ServerFailure;

  const factory Failure.network({
    required String message,
  }) = NetworkFailure;

  const factory Failure.validation({
    required String message,
    Map<String, String>? fieldErrors,
  }) = ValidationFailure;

  const factory Failure.unauthorized({
    required String message,
  }) = UnauthorizedFailure;

  const factory Failure.notFound({
    required String message,
  }) = NotFoundFailure;

  const factory Failure.unexpected({
    required String message,
  }) = UnexpectedFailure;
}

extension FailureX on Failure {
  String get userMessage => when(
        server: (code, msg) => 'Server error: $msg',
        network: (msg) => 'No internet connection. Please try again.',
        validation: (msg, fields) => msg,
        unauthorized: (msg) => 'Please log in to continue.',
        notFound: (msg) => 'Resource not found.',
        unexpected: (msg) => 'Something went wrong. Please try again.',
      );
}
```

---

### Session 7: Repository Interface Generation (3h)
**Deliverables:**
- Abstract repository contracts
- Domain-layer interfaces
- Return types (Either<Failure, T>)
- Method signatures

**Generated:**
```dart
// lib/domain/repositories/user_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../failures/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String id);

  Future<Either<Failure, List<User>>> listUsers({
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, User>> createUser(CreateUserRequest request);

  Future<Either<Failure, User>> updateUser(
    String id,
    UpdateUserRequest request,
  );

  Future<Either<Failure, void>> deleteUser(String id);
}
```

---

### Session 8: Repository Implementation Generation (3h)
**Deliverables:**
- Concrete repository implementations
- Error mapping
- DTO ↔ Entity conversion
- Caching support (optional)

**Generated:**
```dart
// lib/data/repositories/user_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../domain/entities/user.dart';
import '../../domain/failures/failure.dart';
import '../../domain/repositories/user_repository.dart';
import '../api/user_api_client.dart';
import '../mappers/user_mapper.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiClient _apiClient;

  const UserRepositoryImpl({required UserApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<Either<Failure, User>> getUser(String id) async {
    try {
      final dto = await _apiClient.getUser(id);
      return Right(dto.toDomain());
    } on ServerException catch (e) {
      return Left(Failure.server(
        statusCode: e.statusCode,
        message: e.message,
      ));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> listUsers({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final dtos = await _apiClient.listUsers(page: page, limit: limit);
      final users = dtos.map((dto) => dto.toDomain()).toList();
      return Right(users);
    } on ServerException catch (e) {
      return Left(Failure.server(
        statusCode: e.statusCode,
        message: e.message,
      ));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> createUser(CreateUserRequest request) async {
    try {
      final dto = await _apiClient.createUser(request.toDto());
      return Right(dto.toDomain());
    } on ServerException catch (e) {
      if (e.statusCode == 422) {
        return Left(Failure.validation(message: e.message));
      }
      return Left(Failure.server(
        statusCode: e.statusCode,
        message: e.message,
      ));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(
    String id,
    UpdateUserRequest request,
  ) async {
    try {
      final dto = await _apiClient.updateUser(id, request.toDto());
      return Right(dto.toDomain());
    } on ServerException catch (e) {
      return Left(Failure.server(
        statusCode: e.statusCode,
        message: e.message,
      ));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      await _apiClient.deleteUser(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.server(
        statusCode: e.statusCode,
        message: e.message,
      ));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unexpected(message: e.toString()));
    }
  }
}
```

---

### Session 9: Use Case Interface Generation (3h)
**Deliverables:**
- Use case contracts
- Input/output types
- Single responsibility
- Testable interfaces

**Generated:**
```dart
// lib/domain/usecases/get_user_usecase.dart
import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../failures/failure.dart';

abstract class GetUserUseCase {
  Future<Either<Failure, User>> call(String userId);
}

// lib/domain/usecases/list_users_usecase.dart
abstract class ListUsersUseCase {
  Future<Either<Failure, List<User>>> call({
    int page = 1,
    int limit = 20,
  });
}

// lib/domain/usecases/create_user_usecase.dart
abstract class CreateUserUseCase {
  Future<Either<Failure, User>> call(CreateUserRequest request);
}

// lib/domain/usecases/update_user_usecase.dart
abstract class UpdateUserUseCase {
  Future<Either<Failure, User>> call({
    required String userId,
    required UpdateUserRequest request,
  });
}

// lib/domain/usecases/delete_user_usecase.dart
abstract class DeleteUserUseCase {
  Future<Either<Failure, void>> call(String userId);
}
```

---

### Session 10: Use Case Implementation Scaffolding (3h)
**Deliverables:**
- Use case implementation templates
- Business logic placeholders
- Documentation comments
- Testing helpers

**Generated (USER IMPLEMENTS THIS):**
```dart
// lib/domain/usecases/impl/get_user_usecase_impl.dart
import 'package:dartz/dartz.dart';
import '../../entities/user.dart';
import '../../failures/failure.dart';
import '../../repositories/user_repository.dart';
import '../get_user_usecase.dart';

/// Implementation of GetUserUseCase
///
/// Business Rules:
/// - TODO: Add your business rules here
/// - Example: Check if user has permission to view
/// - Example: Log access for audit trail
/// - Example: Apply data transformations
class GetUserUseCaseImpl implements GetUserUseCase {
  final UserRepository _repository;

  const GetUserUseCaseImpl({required UserRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, User>> call(String userId) async {
    // TODO: Add business logic here
    // Example:
    // - Validate userId format
    // - Check permissions
    // - Apply business rules
    // - Transform data
    // - Log analytics

    // For now, just delegate to repository
    return _repository.getUser(userId);

    // Example with business logic:
    /*
    // Validate
    if (userId.isEmpty) {
      return Left(Failure.validation(
        message: 'User ID cannot be empty',
      ));
    }

    // Call repository
    final result = await _repository.getUser(userId);

    // Apply business rules
    return result.fold(
      (failure) => Left(failure),
      (user) {
        // Example: Hide email for privacy
        if (!_hasPermission('view_email')) {
          user = user.copyWith(email: '***@***.com');
        }
        return Right(user);
      },
    );
    */
  }
}
```

---

### Session 11: Dependency Injection Setup (3h)
**Deliverables:**
- Provider registration
- Dependency graph
- Service locator patterns
- Scope management

**Generated:**
```dart
// lib/injection.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/api/user_api_client.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/get_user_usecase.dart';
import 'domain/usecases/impl/get_user_usecase_impl.dart';
// ... other imports

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External
  getIt.registerLazySingleton<Dio>(() => Dio());

  // API Clients
  getIt.registerLazySingleton<UserApiClient>(
    () => UserApiClient(dio: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(apiClient: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetUserUseCase>(
    () => GetUserUseCaseImpl(repository: getIt()),
  );
  getIt.registerLazySingleton<ListUsersUseCase>(
    () => ListUsersUseCaseImpl(repository: getIt()),
  );
  getIt.registerLazySingleton<CreateUserUseCase>(
    () => CreateUserUseCaseImpl(repository: getIt()),
  );
  // ... other use cases
}
```

**Riverpod Alternative:**
```dart
// lib/providers.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/api/user_api_client.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/get_user_usecase.dart';
import 'domain/usecases/impl/get_user_usecase_impl.dart';

// External
final dioProvider = Provider<Dio>((ref) => Dio());

// API Clients
final userApiClientProvider = Provider<UserApiClient>((ref) {
  return UserApiClient(dio: ref.watch(dioProvider));
});

// Repositories
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(
    apiClient: ref.watch(userApiClientProvider),
  );
});

// Use Cases
final getUserUseCaseProvider = Provider<GetUserUseCase>((ref) {
  return GetUserUseCaseImpl(
    repository: ref.watch(userRepositoryProvider),
  );
});

final listUsersUseCaseProvider = Provider<ListUsersUseCase>((ref) {
  return ListUsersUseCaseImpl(
    repository: ref.watch(userRepositoryProvider),
  );
});

// ... other use case providers
```

---

### Session 12: State Integration (Riverpod) (3h)
**Deliverables:**
- State providers using use cases
- AsyncValue handling
- Error state management
- Loading states

**Generated:**
```dart
// lib/presentation/providers/user_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../providers.dart';

/// Get single user by ID
final userProvider = FutureProvider.family<User, String>((ref, userId) async {
  final useCase = ref.watch(getUserUseCaseProvider);
  final result = await useCase(userId);

  return result.fold(
    (failure) => throw Exception(failure.userMessage),
    (user) => user,
  );
});

/// List users with pagination
final usersProvider = FutureProvider.autoDispose
    .family<List<User>, ({int page, int limit})>((ref, params) async {
  final useCase = ref.watch(listUsersUseCaseProvider);
  final result = await useCase(page: params.page, limit: params.limit);

  return result.fold(
    (failure) => throw Exception(failure.userMessage),
    (users) => users,
  );
});

/// Create user notifier
final createUserProvider = Provider<CreateUserNotifier>((ref) {
  return CreateUserNotifier(ref.watch(createUserUseCaseProvider));
});

class CreateUserNotifier extends StateNotifier<AsyncValue<User?>> {
  final CreateUserUseCase _useCase;

  CreateUserNotifier(this._useCase) : super(const AsyncValue.data(null));

  Future<void> createUser(CreateUserRequest request) async {
    state = const AsyncValue.loading();

    final result = await _useCase(request);

    state = result.fold(
      (failure) => AsyncValue.error(failure.userMessage, StackTrace.current),
      (user) => AsyncValue.data(user),
    );
  }
}
```

---

### Session 13: State Integration (Bloc) (3h)
**Deliverables:**
- Bloc/Cubit implementations
- Event/State classes
- Error handling
- Testing support

**Generated:**
```dart
// lib/presentation/blocs/user/user_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/failures/failure.dart';
import '../../../domain/usecases/get_user_usecase.dart';

part 'user_bloc.freezed.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase _getUserUseCase;

  UserBloc({required GetUserUseCase getUserUseCase})
      : _getUserUseCase = getUserUseCase,
        super(const UserState.initial()) {
    on<UserEventLoad>(_onLoad);
  }

  Future<void> _onLoad(UserEventLoad event, Emitter<UserState> emit) async {
    emit(const UserState.loading());

    final result = await _getUserUseCase(event.userId);

    result.fold(
      (failure) => emit(UserState.error(failure)),
      (user) => emit(UserState.loaded(user)),
    );
  }
}

// user_event.dart
part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.load(String userId) = UserEventLoad;
}

// user_state.dart
part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = UserStateInitial;
  const factory UserState.loading() = UserStateLoading;
  const factory UserState.loaded(User user) = UserStateLoaded;
  const factory UserState.error(Failure failure) = UserStateError;
}
```

---

### Session 14: UI Integration (3h)
**Deliverables:**
- Screen integration with use cases
- Loading/error states
- Refresh logic
- Pagination

**Generated:**
```dart
// lib/presentation/screens/user_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_providers.dart';

class UserDetailScreen extends ConsumerWidget {
  final String userId;

  const UserDetailScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: userAsync.when(
        data: (user) => Column(
          children: [
            if (user.avatar != null)
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.avatar!),
              ),
            Text(user.displayName, style: Theme.of(context).textTheme.headlineMedium),
            Text(user.email),
            if (user.isNew)
              const Chip(label: Text('New User')),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              ElevatedButton(
                onPressed: () => ref.invalidate(userProvider(userId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### Session 15: Testing Infrastructure (3h)
**Deliverables:**
- Mock repositories
- Mock use cases
- Test helpers
- Integration test examples

**Generated:**
```dart
// test/domain/usecases/get_user_usecase_test.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:myapp/domain/entities/user.dart';
import 'package:myapp/domain/failures/failure.dart';
import 'package:myapp/domain/repositories/user_repository.dart';
import 'package:myapp/domain/usecases/impl/get_user_usecase_impl.dart';

import 'get_user_usecase_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;
  late GetUserUseCaseImpl useCase;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUserUseCaseImpl(repository: mockRepository);
  });

  group('GetUserUseCase', () {
    const testUserId = '123';
    const testUser = User(
      id: '123',
      name: 'John Doe',
      email: 'john@example.com',
      createdAt: DateTime(2024, 1, 1),
    );

    test('should return User when repository call is successful', () async {
      // Arrange
      when(mockRepository.getUser(testUserId))
          .thenAnswer((_) async => const Right(testUser));

      // Act
      final result = await useCase(testUserId);

      // Assert
      expect(result, const Right(testUser));
      verify(mockRepository.getUser(testUserId));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when repository call fails', () async {
      // Arrange
      const testFailure = Failure.network(message: 'No connection');
      when(mockRepository.getUser(testUserId))
          .thenAnswer((_) async => const Left(testFailure));

      // Act
      final result = await useCase(testUserId);

      // Assert
      expect(result, const Left(testFailure));
      verify(mockRepository.getUser(testUserId));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
```

---

### Session 16: CLI & Documentation (3h)
**Deliverables:**
- `syntaxify api generate` command
- API spec validation
- Migration guide
- Best practices documentation

**CLI Commands:**
```bash
# Generate from API spec
syntaxify api generate api/user_api.yaml

# Generate from OpenAPI
syntaxify api import openapi.yaml

# Validate API spec
syntaxify api validate api/user_api.yaml

# List generated endpoints
syntaxify api list
```

**Output:**
```
✓ Parsed API spec: UserApi (5 endpoints)
✓ Generated DTOs (3 classes)
✓ Generated Entities (3 classes)
✓ Generated Mappers (3 extensions)
✓ Generated API Client (UserApiClient)
✓ Generated Repository Interface (UserRepository)
✓ Generated Repository Implementation (UserRepositoryImpl)
✓ Generated Use Case Interfaces (5 use cases)
✓ Generated Use Case Scaffolds (5 implementations)
✓ Generated Dependency Injection (providers.dart)
✓ Generated State Providers (user_providers.dart)
✓ Generated Tests (15 test files)

Next steps:
1. Implement business logic in lib/domain/usecases/impl/*.dart
2. Run 'flutter pub run build_runner build' to generate freezed/json code
3. Run tests with 'flutter test'

📚 Documentation: https://docs.syntaxify.dev/api-generation
```

---

**End State (v0.6.5):**
- ✅ Full clean architecture generation
- ✅ OpenAPI/Swagger support
- ✅ DTOs, Entities, Mappers auto-generated
- ✅ API Clients auto-generated
- ✅ Repositories (interface + impl) auto-generated
- ✅ Use Cases (interface + scaffold) auto-generated
- ✅ Dependency injection setup
- ✅ State management integration (Riverpod/Bloc)
- ✅ Complete test infrastructure
- ✅ User only implements business logic

---

## Updated Timeline

### v0.6.0 + v0.6.5 Combined:
- **Sessions:** 28 total (12 + 16)
- **Effort:** 84 hours
- **Duration:** 7 weeks (or 3.5 weeks intensive)

### New Grand Total (v0.2 → v1.0):
- **Sessions:** 121 (was 105)
- **Effort:** 363 hours (was 315h)
- **Duration:** 38 weeks (or 2.5 months intensive)

---

## Example Workflow

**User workflow:**

1. **Define API** (5 minutes):
```yaml
# api/user_api.yaml
api:
  name: UserApi
  endpoints:
    - name: getUser
      method: GET
      path: /users/{id}
      # ...
```

2. **Generate** (1 second):
```bash
syntaxify api generate api/user_api.yaml
```

3. **Implement business logic** (30 minutes):
```dart
// lib/domain/usecases/impl/get_user_usecase_impl.dart
@override
Future<Either<Failure, User>> call(String userId) async {
  // Add your business rules here
  if (!_hasPermission(userId)) {
    return Left(Failure.unauthorized(message: 'No permission'));
  }

  return _repository.getUser(userId);
}
```

4. **Done!** ✅
- All layers generated
- Type-safe
- Testable
- Production-ready

**Time saved:** 4-6 hours per API endpoint (manual clean architecture setup)

---

## Value Proposition

**Before Syntaxify:**
- 6 hours to set up clean architecture for 1 API endpoint
- Boilerplate code everywhere
- Manual mapping between layers
- Easy to break architecture

**After Syntaxify:**
- 5 minutes to define API spec
- 1 second to generate all layers
- 30 minutes to implement business logic
- **95% time saved** ⚡

---

## Integration with Existing Roadmap

This slots perfectly between v0.6.0 (State Management) and v0.7.0 (Animations) because:
- State management is prerequisite (need providers/blocs)
- Use cases connect to state layer
- Completes the "full-stack" story for Syntaxify
- Makes Syntaxify the **only** Flutter tool with full clean architecture generation

---
