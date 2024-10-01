import 'package:digilogtv/models/channel.dart';
import 'package:flutter/material.dart';

class FormattingProvider {
  FormattingProvider._internal();

  static final FormattingProvider _instance = FormattingProvider._internal();

  factory FormattingProvider() {
    return _instance;
  }

  Icon formatIcon(Source source) {
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
