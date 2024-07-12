import 'package:digilogtv/services/storage.dart';

import 'package:package_info_plus/package_info_plus.dart';

class UpdateManager {
  late PackageInfo packageInfo;

  Future<bool> checkIfAppWasUpdated(StorageProvider storage) async {
    packageInfo = await PackageInfo.fromPlatform();
    String lastVersion = storage.getLastVersion() ?? '0.0.0';
    if (lastVersion == packageInfo.version) {
      return false;
    } else {
      return true;
    }
  }

  getUpdateMessage() {
    return "Updated the Digilog TV channel list. Thanks to our free, legal, and publicly available content provider - Free-TV/IPTV on GitHub.";
  }

  removeUpdate(StorageProvider storage) async {
    storage.updateVersion(packageInfo.version);
  }
}