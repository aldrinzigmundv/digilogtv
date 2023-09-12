import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:digilogtv/services/channels.dart';

part 'formatting.g.dart';

class FormattingProvider = _FormattingProvider with _$FormattingProvider;

abstract class _FormattingProvider with Store {
  @action
  formatIcon(Source source) {
    if (source == Source.iptv) {
      return Icon(Icons.satellite_alt, color: Colors.indigo[900],);
    } else {
      return const Icon(Icons.smart_display, color: Colors.red,);
    }
  }
}