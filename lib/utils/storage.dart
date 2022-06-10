import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Storage {
  String directory;

  Storage({required this.directory});

  Future<Directory> get localDirectory async {
    final appDirectory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final storageDirectory = Directory(join(appDirectory!.path, directory));

    if (!await storageDirectory.exists()) {
      storageDirectory.create();
    }

    return storageDirectory;
  }

  Stream<List<FileSystemEntity>> listDirectory() async* {
    final directory = await localDirectory;

    final entities = <FileSystemEntity>[];

    await for (final entity in directory.list()) {
      entities.add(entity);
      yield entities;
    }
  }

  Future<File> writeFile(String filename, String content,
      [String? extension]) async {
    final directory = await localDirectory;

    final name = extension != null ? "$filename.$extension" : filename;

    return await File(join(directory.path, name)).writeAsString(content);
  }

  Future<File> writeFileAsBytes(String filename, List<int> content,
      [String? extension]) async {
    final directory = await localDirectory;

    final name = extension != null ? "$filename.$extension" : filename;

    return await File(join(directory.path, name)).writeAsBytes(content);
  }

  Future<String> readFile(String filename) async {
    final directory = await localDirectory;

    return await File(join(directory.path, filename)).readAsString();
  }
}
