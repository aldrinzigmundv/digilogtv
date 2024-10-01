import 'package:digilogtv/models/channel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageProvider {
  static final StorageProvider _instance = StorageProvider._internal();
  late Box storage;

  StorageProvider._internal();

  factory StorageProvider() {
    return _instance;
  }

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ChannelAdapter());
    Hive.registerAdapter(SourceAdapter());

    storage = await Hive.openBox('digilogtvBox');
  }
}
