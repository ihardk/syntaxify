import 'package:syntaxify/syntaxify.dart';
import 'package:test/test.dart';

void main() {
  group('DryRunFileSystem', () {
    late MemoryFileSystem memoryFs;
    late DryRunFileSystem dryRunFs;

    setUp(() {
      memoryFs = MemoryFileSystem();
      dryRunFs = DryRunFileSystem(delegate: memoryFs);
    });

    test('tracks write operations without writing', () async {
      await dryRunFs.writeFile('/test/file.dart', 'content');

      // Should NOT exist in delegate
      expect(await memoryFs.exists('/test/file.dart'), isFalse);

      // Should be tracked
      expect(dryRunFs.operations, hasLength(1));
      expect(dryRunFs.operations.first.type, equals(DryRunOperationType.write));
      expect(dryRunFs.operations.first.path, equals('/test/file.dart'));
      expect(dryRunFs.operations.first.contentLength, equals(7));
    });

    test('tracks createDirectory without creating', () async {
      await dryRunFs.createDirectory('/test/dir');

      // Should NOT exist in delegate
      expect(await memoryFs.exists('/test/dir'), isFalse);

      // Should be tracked
      expect(dryRunFs.operations, hasLength(1));
      expect(dryRunFs.operations.first.type,
          equals(DryRunOperationType.createDir));
      expect(dryRunFs.operations.first.path, equals('/test/dir'));
    });

    test('tracks delete operations', () async {
      await dryRunFs.deleteFile('/test/file.dart');

      expect(dryRunFs.operations, hasLength(1));
      expect(
          dryRunFs.operations.first.type, equals(DryRunOperationType.delete));
    });

    test('tracks copy operations', () async {
      await dryRunFs.copyFile('/source.dart', '/dest.dart');

      expect(dryRunFs.operations, hasLength(1));
      expect(dryRunFs.operations.first.type, equals(DryRunOperationType.copy));
      expect(dryRunFs.operations.first.path, contains('source.dart'));
    });

    test('reads delegate for read operations', () async {
      // Write to memory FS directly
      await memoryFs.writeFile('/existing.dart', 'existing content');

      // Read via dry run FS
      final content = await dryRunFs.readFile('/existing.dart');
      expect(content, equals('existing content'));

      // Should NOT add to operations (read is passthrough)
      expect(dryRunFs.operations, isEmpty);
    });

    test('delegates exists checks', () async {
      await memoryFs.writeFile('/exists.dart', 'content');

      expect(await dryRunFs.exists('/exists.dart'), isTrue);
      expect(await dryRunFs.exists('/not_exists.dart'), isFalse);
    });

    group('getSummary', () {
      test('returns "no changes" when empty', () {
        expect(dryRunFs.getSummary(), contains('No changes'));
      });

      test('lists all tracked operations', () async {
        await dryRunFs.createDirectory('/lib');
        await dryRunFs.writeFile('/lib/file1.dart', 'content1');
        await dryRunFs.writeFile('/lib/file2.dart', 'content longer');
        await dryRunFs.deleteFile('/old_file.dart');

        final summary = dryRunFs.getSummary();

        expect(summary, contains('Directories to create'));
        expect(summary, contains('/lib'));
        expect(summary, contains('Files to write'));
        expect(summary, contains('/lib/file1.dart'));
        expect(summary, contains('/lib/file2.dart'));
        expect(summary, contains('Files to delete'));
        expect(summary, contains('/old_file.dart'));
        expect(summary, contains('Total: 2 files, 1 directories'));
      });
    });
  });
}
