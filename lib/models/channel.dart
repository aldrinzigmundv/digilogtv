import 'package:hive_flutter/hive_flutter.dart';

enum Source { iptv, youtube }

class SourceAdapter extends TypeAdapter<Source> {
  @override
  final int typeId = 0;

  @override
  Source read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Source.iptv;
      case 1:
        return Source.youtube;
      default:
        return Source.iptv;
    }
  }

  @override
  void write(BinaryWriter writer, Source obj) {
    switch (obj) {
      case Source.iptv:
        writer.writeByte(0);
        break;
      case Source.youtube:
        writer.writeByte(1);
        break;
    }
  }
}

class Channel {
  Channel(
      {required this.channelName,
      required this.link,
      required this.source,
      required this.contactpage});

  String channelName;
  String link;
  Source source;
  String contactpage;

  String getChannelName() {
    return channelName;
  }

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      channelName: json['channelName'],
      link: json['link'],
      source: Source.values.firstWhere((e) => e.toString() == 'Source.' + json['source']),
      contactpage: json['contactpage'],
    );
  }
}

class ChannelAdapter extends TypeAdapter<Channel> {
  @override
  final int typeId = 1;

  @override
  Channel read(BinaryReader reader) {
    return Channel(
      channelName: reader.readString(),
      link: reader.readString(),
      source: Source.values[reader.readByte()],
      contactpage: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Channel obj) {
    writer.writeString(obj.channelName);
    writer.writeString(obj.link);
    writer.writeByte(obj.source.index);
    writer.writeString(obj.contactpage);
  }
}