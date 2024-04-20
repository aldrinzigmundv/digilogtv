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
    return "Fixed a bug causing TV interface to appear on phones.";
  }

  removeUpdate(StorageProvider storage) async {
    storage.updateVersion(packageInfo.version);
  }
}