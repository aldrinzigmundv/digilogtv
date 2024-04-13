enum Source { iptv, youtube }

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
    Channel(
        channelName: "ABC News",
        link:
            "https://abc-iview-mediapackagestreams-2.akamaized.net/out/v1/6e1cc6d25ec0480ea099a5399d73bc4b/index.m3u8",
        source: Source.iptv,
        contactpage: 'https://abcnews.go.com/Contact'),
    Channel(
        channelName: "Al Jazeera English",
        link: "https://live-hls-web-aje.getaj.net/AJE/index.m3u8",
        source: Source.iptv,
        contactpage: 'https://network.aljazeera.net/en/contact'),
    Channel(
        channelName: "Bloomberg",
        link: "https://bloomberg.com/media-manifest/streams/us.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.bloomberg.com/professional/support/'),
    Channel(
        channelName: "Bloomberg+",
        link: "https://bloomberg.com/media-manifest/streams/phoenix-us.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.bloomberg.com/professional/support/'),
    Channel(
        channelName: "CBC News Network",
        link:
            "https://dai2.xumo.com/amagi_hls_data_xumo1212A-redboxcbcnews/CDN/playlist.m3u8",
        source: Source.iptv,
        contactpage: 'https://cbchelp.cbc.ca/hc/en-ca/requests/new'),
    Channel(
        channelName: "CBS News",
        link:
            "https://cbsnews.akamaized.net/hls/live/2020607/cbsnlineup_8/master.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.cbs.com/showfeedback/'),
    Channel(
        channelName: "Channel News Asia",
        link: "https://ythls.armelin.one/channel/UC83jt4dlz1Gjl58fzQrrKZg.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.channelnewsasia.com/contact-us'),
    Channel(
        channelName: "CNBC",
        link: "https://www.youtube.com/embed/9NyxcX3rhQs?autoplay=1",
        source: Source.youtube,
        contactpage: 'https://help.cnbc.com/contact/'),
    Channel(
        channelName: "CNN",
        link:
            "https://raw.githubusercontent.com/Alstruit/adaptive-streams/alstruit-10_23_us/streams/us/CNNUSA.us.m3u8",
        source: Source.iptv,
        contactpage: 'https://help.cnn.com/us/ContactUs'),
    Channel(
        channelName: "DW English",
        link:
            "https://dwamdstream102.akamaized.net/hls/live/2015525/dwstream102/index.m3u8",
        source: Source.iptv,
        contactpage: 'https://corporate.dw.com/en/contact/s-30606'),
    Channel(
        channelName: "Euronews",
        link:
            "https://shls-live-ak.akamaized.net/out/v1/115bfcde8fa342d182ef846445cdbdcf/index.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.euronews.com/contact'),
    Channel(
        channelName: "France 24 English",
        link: "https://ythls.armelin.one/channel/UCQfwfsi5VrQ8yKZ-UWmAEFg.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.francemediasmonde.com/en/contact'),
    Channel(
        channelName: "GB News",
        link:
            "https://live-gbnews.simplestreamcdn.com/live5/gbnews/bitrate1.isml/manifest.m3u8",
        source: Source.iptv,
        contactpage: "https://www.gbnews.com/about-us/contact-us"),
    Channel(
        channelName: "Global News",
        link: "https://i.mjh.nz/PlutoTV/62cbef9ebb857100072fc187-alt.m3u8",
        source: Source.iptv,
        contactpage: 'https://globalnews.ca/pages/contact-us/'),
    Channel(
        channelName: "i24 News",
        link:
            "https://bcovlive-a.akamaihd.net/6e3dd61ac4c34d6f8fb9698b565b9f50/eu-central-1/5377161796001/playlist-all_dvr.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.i24news.tv/en/contact'),
    Channel(
        channelName: "LiveNOW from FOX",
        link: "https://lnc-fox-live-now.tubi.video/index.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.livenowfox.com/contact-us'),
    Channel(
        channelName: "NBC News Now",
        link:
            "https://dai2.xumo.com/amagi_hls_data_xumo1212A-xumo-nbcnewsnow/CDN/master.m3u8",
        source: Source.iptv,
        contactpage:
            'https://www.nbcnews.com/information/nbc-news-info/contact-us-n1232521'),
    Channel(
        channelName: "Newsmax TV",
        link: "https://nmxlive.akamaized.net/hls/live/529965/Live_1/index.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.newsmax.com/contact/'),
    Channel(
        channelName: "NHK World Japan",
        link: "https://ythls.armelin.one/channel/UCSPEjw8F2nQDtmUKPFNF7_A.m3u8",
        source: Source.iptv,
        contactpage: 'https://www3.nhk.or.jp/nhkworld/en/contact/'),
    Channel(
        channelName: "Press TV",
        link:
            "https://cdnlive.presstv.ir/cdnlive/smil:cdnlive.smil/playlist.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.presstv.ir/aboutus/contactus'),
    Channel(
        channelName: "Russia Today",
        link: "https://rt-glb.rttv.com/live/rtnews/playlist.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.rt.com/about-us/contact-info/'),
    Channel(
        channelName: "Scripps News",
        link:
            "https://content.uplynk.com/channel/4bb4901b934c4e029fd4c1abfc766c37.m3u8",
        source: Source.iptv,
        contactpage: 'https://support.scrippsnews.com/support/tickets/new'),
    Channel(
        channelName: "Sky News",
        link: "https://i.mjh.nz/PlutoTV/55b285cd2665de274553d66f-alt.m3u8",
        source: Source.iptv,
        contactpage: 'https://news.sky.com/info/contact-us'),
    Channel(
        channelName: "The Guardian",
        link: "https://rakuten-guardian-1-ie.samsung.wurl.tv/playlist.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.theguardian.com/help/contact-us'),
    Channel(
        channelName: "Ticker",
        link:
            "https://cdn-uw2-prod.tsv2.amagi.tv/linear/amg01486-tickernews-tickernewsweb-ono/playlist.m3u8",
        source: Source.iptv,
        contactpage: 'https://tickernews.co/contact-ticker/'),
    Channel(
        channelName: "TRT World",
        link: "https://tv-trtworld.medya.trt.com.tr/master.m3u8",
        source: Source.iptv,
        contactpage: 'https://www.trtworld.com/contact'),
    Channel(
        channelName: "Yahoo! Finance",
        link: "https://d1ewctnvcwvvvu.cloudfront.net/playlist.m3u8",
        source: Source.iptv,
        contactpage: 'https://yahoo.uservoice.com/forums/382977'),
  ];
}
