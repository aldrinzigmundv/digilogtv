import 'package:flutter/material.dart';

import 'package:digilogtv/services/channels.dart';

class FormattingProvider {
  formatIcon(Source source) {
    if (source == Source.iptv) {
      return Icon(
        Icons.satellite_alt,
        color: Colors.indigo[900],
      );
    } else {
      return const Icon(
        Icons.smart_display,
        color: Colors.red,
      );
    }
  }
}
