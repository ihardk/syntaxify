import 'package:syntaxify/syntaxify.dart';
import 'package:syntaxify/src/use_cases/generate_screen.dart';
import 'package:test/test.dart';

void main() {
  group('GenerateScreenUseCase', () {
    late GenerateScreenUseCase useCase;
    late MemoryFileSystem fileSystem;

    setUp(() {
      fileSystem = MemoryFileSystem();
      useCase = GenerateScreenUseCase(
        fileSystem: fileSystem,
        registry: GeneratorRegistry(),
      );
    });

    tearDown(() {
      fileSystem.clear();
    });

    group('execute', () {
      test('generates screen file in correct location', () async {
        // Arrange
        final screen = ScreenDefinition(
          id: 'login',
          layout: App.column(
            children: [
              App.text(text: 'Welcome'),
            ],
          ),
        );

        // Act
        final filePath = await useCase.execute(
          screen: screen,
          outputDir: '/output',
        );

        // Assert
        expect(filePath, equals('screens/login_screen.dart'));
        expect(fileSystem.hasFile('/output/screens/login_screen.dart'), isTrue);
      });

      test('generates correct file name from screen id', () async {
        final screen = ScreenDefinition(
          id: 'profile',
          layout: App.column(children: []),
        );

        final filePath = await useCase.execute(
          screen: screen,
          outputDir: '/output',
        );

        expect(filePath, equals('screens/profile_screen.dart'));
      });

      test('creates screens directory if it doesn\'t exist', () async {
        final screen = ScreenDefinition(
          id: 'home',
          layout: App.column(children: []),
        );

        await useCase.execute(
          screen: screen,
          outputDir: '/output',
        );

        final files = await fileSystem.listFiles('/output/screens');
        expect(files, isNotEmpty);
      });

      test('writes valid Dart code to file', () async {
        final screen = ScreenDefinition(
          id: 'login',
          layout: App.column(
            children: [
              App.text(text: 'Login'),
              App.button(label: 'Submit', onPressed: 'handleSubmit'),
            ],
          ),
        );

        await useCase.execute(
          screen: screen,
          outputDir: '/output',
        );

        final code = fileSystem.getFile('/output/screens/login_screen.dart');
        expect(code, isNotNull);
        expect(code, contains('class LoginScreen'));
        expect(code, contains('StatelessWidget'));
        expect(code, contains('build(BuildContext context)'));
      });

      test('includes callbacks from button nodes', () async {
        final screen = ScreenDefinition(
          id: 'profile',
          layout: App.column(
            children: [
              App.button(label: 'Logout', onPressed: 'handleLogout'),
              App.button(label: 'Settings', onPressed: 'handleSettings'),
            ],
          ),
        );

        await useCase.execute(
          screen: screen,
          outputDir: '/output',
        );

        final code = fileSystem.getFile('/output/screens/profile_screen.dart');
        expect(code, contains('handleLogout'));
        expect(code, contains('handleSettings'));
        expect(code, contains('VoidCallback?'));
      });

      test('generates screen with app bar', () async {
        final screen = ScreenDefinition(
          id: 'home',
          appBar: AppBarNode(
            title: 'Home',
          ),
          layout: App.column(children: []),
        );

        await useCase.execute(
          screen: screen,
          outputDir: '/output',
        );

        final code = fileSystem.getFile('/output/screens/home_screen.dart');
        expect(code, contains('AppBar'));
        expect(code, contains('Home'));
      });

      test('generates screen without app bar', () async {
        final screen = ScreenDefinition(
          id: 'splash',
          layout: App.column(children: [
            App.text(text: 'Loading...'),
          ]),
        );

        await useCase.execute(
          screen: screen,
          outputDir: '/output',
        );

        final code = fileSystem.getFile('/output/screens/splash_screen.dart');
        expect(code, isNotNull);
        expect(code, contains('class SplashScreen'));
      });

      test('handles nested layout', () async {
        final screen = ScreenDefinition(
          id: 'complex',
          layout: App.column(
            children: [
              App.row(
                children: [
                  App.text(text: 'Left'),
                  App.text(text: 'Right'),
                ],
              ),
              App.column(
                children: [
                  App.button(label: 'Action1', onPressed: 'onAction1'),
                  App.button(label: 'Action2', onPressed: 'onAction2'),
                ],
              ),
            ],
          ),
        );

        await useCase.execute(
          screen: screen,
          outputDir: '/output',
        );

        final code = fileSystem.getFile('/output/screens/complex_screen.dart');
        expect(code, contains('Column'));
        expect(code, contains('Row'));
      });

      test('includes text field callbacks', () async {
        final screen = ScreenDefinition(
          id: 'form',
          layout: App.column(
            children: [
              App.textField(
                label: 'Email',
                onChanged: 'handleEmailChanged',
              ),
            ],
          ),
        );

        await useCase.execute(
          screen: screen,
          outputDir: '/output',
        );

        final code = fileSystem.getFile('/output/screens/form_screen.dart');
        expect(code, contains('handleEmailChanged'));
        expect(code, contains('ValueChanged<String>?'));
      });

      test('does not overwrite existing screen file', () async {
        final screen = ScreenDefinition(
          id: 'existing',
          layout: App.column(children: []),
        );

        // Pre-create the file
        await fileSystem.createDirectory('/output/screens');
        await fileSystem.writeFile(
          '/output/screens/existing_screen.dart',
          '// Existing content',
        );

        await useCase.execute(
          screen: screen,
          outputDir: '/output',
        );

        final code = fileSystem.getFile('/output/screens/existing_screen.dart');
        expect(code, equals('// Existing content'));
      });

      test('generates multiple different screens', () async {
        final login = ScreenDefinition(
          id: 'login',
          layout: App.column(children: []),
        );

        final profile = ScreenDefinition(
          id: 'profile',
          layout: App.column(children: []),
        );

        await useCase.execute(screen: login, outputDir: '/output');
        await useCase.execute(screen: profile, outputDir: '/output');

        expect(fileSystem.hasFile('/output/screens/login_screen.dart'), isTrue);
        expect(
            fileSystem.hasFile('/output/screens/profile_screen.dart'), isTrue);
      });

      test('handles screen with spacer nodes', () async {
        final screen = ScreenDefinition(
          id: 'spaced',
          layout: App.column(
            children: [
              App.text(text: 'Title'),
              App.spacer(size: SpacerSize.lg),
              App.text(text: 'Subtitle'),
            ],
          ),
        );

        await useCase.execute(
          screen: screen,
          outputDir: '/output',
        );

        final code = fileSystem.getFile('/output/screens/spaced_screen.dart');
        // SpacerSize.lg emits SizedBox with height: 24.0
        expect(code, contains('SizedBox'));
        expect(code, contains('height: 24'));
      });

      test('handles screen with icon nodes', () async {
        final screen = ScreenDefinition(
          id: 'gallery',
          layout: App.column(
            children: [
              App.icon(
                name: 'home',
                size: IconSize.lg,
              ),
            ],
          ),
        );

        await useCase.execute(
          screen: screen,
          outputDir: '/output',
        );

        final code = fileSystem.getFile('/output/screens/gallery_screen.dart');
        expect(code, contains('Icon'));
        expect(code, contains('home'));
      });
    });
  });
}
