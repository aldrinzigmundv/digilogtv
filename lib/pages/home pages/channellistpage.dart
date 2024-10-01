import 'package:digilogtv/models/channel.dart';
import 'package:flutter/material.dart';
import 'package:digilogtv/services/storage.dart';
import 'package:digilogtv/services/routing.dart';
import 'package:digilogtv/widgets/home%20pages%20widgets/mainappbar.dart';
import 'package:digilogtv/widgets/home%20pages%20widgets/topnavbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:digilogtv/widgets/channellistitem.dart';

//AdmobCode
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//AdmobCode

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({
    super.key,
    required this.isTV,
  });

  final bool isTV;

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  StorageProvider storageProvider = StorageProvider();
  late bool isTV;
  int _focusedIndex = 1;

  //AdmobCode
  // BannerAd? _bannerAd;
  //AdmobCode

  void _updateFocus(int newIndex) {
    if (mounted) {
      setState(() {
      _focusedIndex = newIndex;
    });
    }
  }

  //AdmobCode
  // final adUnitId = "ca-app-pub-4100835771816662/1511860042";
  // void _loadAd() {
  //   _bannerAd = BannerAd(
  //     adUnitId: adUnitId,
  //     request: const AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       onAdLoaded: (ad) {
  //         debugPrint('$ad loaded.');
  //         if (mounted) {
  //           setState(() {});
  //         }
  //       },
  //       onAdFailedToLoad: (ad, err) {
  //         debugPrint('BannerAd failed to load: $err');
  //         ad.dispose();
  //       },
  //     ),
  //   )..load();
  // }
  //AdmobCode

  Icon _favoriteIcon(String channelName) {
    if (!storageProvider.storage
        .get('favoritedChannelList', defaultValue: []).contains(channelName)) {
      return Icon(
        Icons.star_border,
        color: Colors.indigo[900],
      );
    } else {
      return Icon(
        Icons.star,
        color: Colors.indigo[900],
      );
    }
  }

  void _favoriteChange(int index) async {
    List<String> favoritedChannels = storageProvider.storage
        .get('favoritedChannelList', defaultValue: []).cast<String>();
    String selectedChannel =
        storageProvider.storage.get('channelList')[index].channelName;

    if (favoritedChannels.contains(selectedChannel)) {
      favoritedChannels.remove(selectedChannel);
      await storageProvider.storage
          .put('favoritedChannelList', favoritedChannels);
    } else {
      favoritedChannels.add(selectedChannel);
      favoritedChannels.sort((a, b) => a.compareTo(b));
      await storageProvider.storage
          .put('favoritedChannelList', favoritedChannels);
    }
  }

  void _goToChannel(int index) {
    if (storageProvider.storage.get('channelList')[index].source ==
        Source.iptv) {
      goToChannelPageIPTV(context: context, index: index, isTV: isTV);
    } else {
      goToChannelPageYouTube(context: context, index: index, isTV: isTV);
    }
  }

  void _updateScreen() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    isTV = widget.isTV;

    //AdmobCode
    // _loadAd();
    //AdmobCode

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      storageProvider.storage.listenable().addListener(_updateScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TopNavBar(
              focusedIndex: _focusedIndex,
              updateFocus: _updateFocus,
              isTV: isTV,
            ),

            //AdmobCode
            // (_bannerAd != null)
            //     ? Align(
            //         alignment: Alignment.bottomCenter,
            //         child: SafeArea(
            //           child: SizedBox(
            //             width: _bannerAd!.size.width.toDouble(),
            //             height: _bannerAd!.size.height.toDouble(),
            //             child: AdWidget(ad: _bannerAd!),
            //           ),
            //         ),
            //       )
            //     : SizedBox(),
            //AdmobCode

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: storageProvider.storage
                  .get('channelList', defaultValue: []).length,
              itemBuilder: (context, index) {
                bool isChannelFocused = _focusedIndex == index + 3;
                bool isStarFocused = _focusedIndex ==
                    index +
                        3 +
                        storageProvider.storage.get('channelList').length;

                return ChannelListItem(
                  channelName: storageProvider.storage
                      .get('channelList')[index]
                      .channelName,
                  source:
                      storageProvider.storage.get('channelList')[index].source,
                  isFocused: isChannelFocused,
                  isFavoriteFocused: isStarFocused,
                  onChannelSelect: () => _goToChannel(index),
                  onFavoriteSelect: () => _favoriteChange(index),
                  onChannelFocus: (isFocused) {
                    if (isFocused) _updateFocus(index + 3);
                  },
                  onFavoriteFocus: (isFocused) {
                    if (isFocused) {
                      _updateFocus((index +
                              3 +
                              storageProvider.storage.get('channelList').length)
                          .toInt());
                    }
                  },
                  favoriteIcon: _favoriteIcon(storageProvider.storage
                      .get('channelList')[index]
                      .channelName),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
