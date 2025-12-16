# Performance Benchmarks

> Concrete performance targets for Meta-UI generator and runtime.

---

## 1. Generator Performance

### 1.1 Build Time Targets

| Metric | Target | Acceptable | Unacceptable |
|--------|--------|-----------|--------------|
| Cold build (10 components) | < 2s | < 5s | > 10s |
| Incremental build (1 change) | < 500ms | < 1s | > 2s |
| Watch mode reaction | < 300ms | < 500ms | > 1s |

### 1.2 Memory Usage
| Scenario | Target |
|----------|--------|
| Generator process peak | < 200MB |
| Generated code per component | < 5KB |

---

## 2. Runtime Performance

### 2.1 Widget Build Time

| Metric | Target | Acceptable |
|--------|--------|------------|
| Simple component (Button) | < 0.5ms | < 1ms |
| Complex component (Card with children) | < 2ms | < 5ms |
| Token resolution | < 0.1ms | < 0.2ms |
| Theme lookup | < 0.05ms | < 0.1ms |

### 2.2 Frame Budget Impact
- **Target:** 0% frame drops attributable to Meta-UI
- **Measurement:** 60fps maintained on mid-range device

### 2.3 Memory Overhead
| Scenario | Target |
|----------|--------|
| TokenLibrary in memory | < 50KB |
| Per-component instance | < 1KB |
| Theme switching | 0 allocation spike |

---

## 3. Comparison Baseline

### Meta-UI vs Raw Flutter
| Metric | Raw Flutter | Meta-UI | Overhead |
|--------|-------------|---------|----------|
| Button build | 0.3ms | 0.35ms | +17% |
| Card build | 1.2ms | 1.4ms | +17% |
| Theme lookup | N/A | 0.05ms | — |

**Target: < 20% overhead vs raw Flutter**

### Meta-UI vs Other Solutions
| Solution | Build Time | Runtime Overhead |
|----------|-----------|------------------|
| Hardcoded widgets | 0s | 0% |
| **Meta-UI (Static)** | 2s | < 5% |
| **Meta-UI (Dynamic)** | 2s | < 20% |
| JSON-driven UI | 0s | 50-100% |

---

## 4. Benchmark Tests

### 4.1 Synthetic Benchmark
```dart
// test/benchmark/build_benchmark.dart
void main() {
  final stopwatch = Stopwatch()..start();
  
  for (int i = 0; i < 1000; i++) {
    final button = AppButton(label: 'Test $i', onPressed: () {});
    // Force build
    button.createElement();
  }
  
  stopwatch.stop();
  print('1000 AppButtons: ${stopwatch.elapsedMilliseconds}ms');
  // Target: < 500ms
}
```

### 4.2 Real-World Benchmark
```dart
// test/benchmark/list_benchmark.dart
testWidgets('ListView with 100 meta-buttons', (tester) async {
  final stopwatch = Stopwatch()..start();
  
  await tester.pumpWidget(
    MaterialApp(
      home: ListView.builder(
        itemCount: 100,
        itemBuilder: (_, i) => AppButton(label: 'Item $i', onPressed: () {}),
      ),
    ),
  );
  
  stopwatch.stop();
  print('100-item list render: ${stopwatch.elapsedMilliseconds}ms');
  // Target: < 100ms
});
```

---

## 5. Optimization Strategies

### 5.1 Static Mode (Maximum Performance)
```bash
meta_gen build --mode=static --theme=material
```
- Tokens inlined as `const`
- No runtime lookup
- **Overhead: ~5%**

### 5.2 Dynamic Mode (Flexibility)
```bash
meta_gen build --mode=dynamic
```
- Tokens resolved via `InheritedWidget`
- Supports runtime theme switching
- **Overhead: ~15-20%**

### 5.3 Token Caching
```dart
class TokenLibrary {
  static final _cache = <DesignStyle, ButtonTokens>{};
  
  static ButtonTokens button(DesignStyle style) {
    return _cache.putIfAbsent(style, () => _compute(style));
  }
}
```

---

## 6. Profiling Workflow

### 6.1 DevTools Setup
```dart
void main() {
  Timeline.startSync('meta_init');
  MetaTheme.preload([DesignStyle.material, DesignStyle.neo]);
  Timeline.finishSync();
  
  runApp(MyApp());
}
```

### 6.2 CI Performance Regression
```yaml
# .github/workflows/benchmark.yml
- name: Run benchmarks
  run: flutter test test/benchmark --reporter=json > benchmark.json

- name: Check regression
  run: |
    if [ $(jq '.button_build_ms' benchmark.json) -gt 1 ]; then
      echo "Button build time regression!"
      exit 1
    fi
```

---

## 7. Device Tier Targets

| Tier | Example Device | Target FPS | Max Build Time |
|------|----------------|------------|----------------|
| High | iPhone 15, Pixel 8 | 120fps | 0.3ms |
| Mid | iPhone 11, Pixel 5 | 60fps | 0.5ms |
| Low | Budget Android | 60fps | 1ms |

---

*Document Version: 1.0*
