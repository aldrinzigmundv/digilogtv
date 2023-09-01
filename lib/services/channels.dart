enum Source {
  iptv,
  youtube
}

class Channel {
  Channel({required this.channelName, required this.link, required this.source});

  String channelName;
  String link;
  Source source;

  String getChannelName() {
    return channelName;
  }

}

class Channels {
  List<Channel> getMatchingChannels(List<String> channelNames) {
    List<Channel> matchingChannels = [];

    for (Channel channel in channelList) {
      if (channelNames.contains(channel.channelName)) {
        matchingChannels.add(channel);
      }
    }

    return matchingChannels;
  }

  int getIndexByChannelName(String channelName) {
    for (int i = 0; i < channelList.length; i++) {
      if (channelList[i].channelName == channelName) {
        return i;
      }
    }
    return -1;
  }

  List<Channel> channelList = [
    Channel(channelName: "ABC News", link: "https://abc-iview-mediapackagestreams-2.akamaized.net/out/v1/6e1cc6d25ec0480ea099a5399d73bc4b/index.m3u8", source: Source.iptv),
    Channel(channelName: "Africanews", link: "https://www.youtube.com/embed/NQjabLGdP5g?autoplay=1", source: Source.youtube),
    Channel(channelName: "Al Jazeera English", link: "https://live-hls-web-aje.getaj.net/AJE/index.m3u8", source: Source.iptv),
    Channel(channelName: "Arirang", link: "http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/playlist.m3u8", source: Source.iptv),
    Channel(channelName: "Bloomberg", link: "https://bloomberg.com/media-manifest/streams/us.m3u8", source: Source.iptv),
    Channel(channelName: "CBS News", link: "https://cbsnews.akamaized.net/hls/live/2020607/cbsnlineup_8/master.m3u8", source: Source.iptv),
    Channel(channelName: "Channel News Asia", link: "https://www.youtube.com/embed/XWq5kBlakcQ?autoplay=1", source: Source.youtube),
    Channel(channelName: "CNBC", link: "https://www.youtube.com/embed/9NyxcX3rhQs?autoplay=1", source: Source.youtube),
    Channel(channelName: "DW English", link: "https://dwamdstream102.akamaized.net/hls/live/2015525/dwstream102/index.m3u8", source: Source.iptv),
    Channel(channelName: "Euronews", link: "https://www.youtube.com/embed/pykpO5kQJ98?autoplay=1", source: Source.youtube),
    Channel(channelName: "France 24 English", link: "https://www.youtube.com/embed/h3MuIUNCCzI?autoplay=1", source: Source.youtube),
    Channel(channelName: "Global News", link: "https://i.mjh.nz/PlutoTV/62cbef9ebb857100072fc187-alt.m3u8", source: Source.iptv),
    Channel(channelName: "Newsmax TV", link: "https://nmxlive.akamaized.net/hls/live/529965/Live_1/index.m3u8", source: Source.iptv),
    Channel(channelName: "NHK World Japan", link: "https://nhkwlive-ojp.akamaized.net/hls/live/2003459/nhkwlive-ojp-en/index_4M.m3u8", source: Source.iptv),
    Channel(channelName: "PBS America", link: "https://pbs-samsunguk.amagi.tv/playlist.m3u8", source: Source.iptv),
    Channel(channelName: "Press TV", link: "https://cdnlive.presstv.ir/cdnlive/smil:cdnlive.smil/playlist.m3u8", source: Source.iptv),
    Channel(channelName: "Reuters TV", link: "https://reuters-reutersnow-1-eu.rakuten.wurl.tv/playlist.m3u8", source: Source.iptv),
    Channel(channelName: "Sky News", link: "https://i.mjh.nz/PlutoTV/55b285cd2665de274553d66f-alt.m3u8", source: Source.iptv),
    Channel(channelName: "TRT World", link: "https://tv-trtworld.medya.trt.com.tr/master.m3u8", source: Source.iptv),
  ];
}