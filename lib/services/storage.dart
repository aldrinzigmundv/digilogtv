import 'package:digilogtv/services/channels.dart';

import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider {
  late SharedPreferences storage;

  Channels channels = Channels();

  List<Channel> arrangedChannelList = [];

  List<String> favoritedChannels = [];

  initialize() async {
    storage = await SharedPreferences.getInstance();
    storage.reload();
    List<String>? retrievedFavoritedChannels =
        storage.getStringList('favorite channels');
    favoritedChannels = retrievedFavoritedChannels ?? [];
    channels = Channels();
  }

  initializeFavorites() {
    arrangedChannelList = channels.getMatchingChannels(favoritedChannels);
  }

  saveChanges() async {
    await storage.setStringList('favorite channels', favoritedChannels);
  }

  String? getLastVersion() {
    return storage.getString('last version');
  }

  updateVersion(String version) async {
    await storage.setString('last version', version);
  }
}
