import 'package:mobx/mobx.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:digilogtv/services/channels.dart';

part 'storage.g.dart';

class StorageProvider = _StorageProvider with _$StorageProvider;

abstract class _StorageProvider with Store {

  late SharedPreferences storage;

  late Channels channels = Channels();

  @observable
  List<Channel> arrangedChannelList = [];

  @observable
  late List<String> favoritedChannels = [];

  @action
  initialize() async {
    storage = await SharedPreferences.getInstance();
    storage.reload();
    List<String>? retrievedFavoritedChannels = storage.getStringList('favorite channels');
    favoritedChannels = retrievedFavoritedChannels ?? [];
    channels = Channels();
  }

  @action
  initializeFavorites() {
    arrangedChannelList = channels.getMatchingChannels(favoritedChannels);
  }

  @action
  saveChanges () async {
    await storage.setStringList('favorite channels', favoritedChannels);
  }
}