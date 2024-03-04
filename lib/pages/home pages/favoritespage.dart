import 'package:flutter/material.dart';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:digilogtv/services/storage.dart';
import 'package:digilogtv/services/formatting.dart';
import 'package:digilogtv/services/channels.dart';
import 'package:digilogtv/services/routing.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    super.key,
    required this.storage,
    required this.formattingProvider,
  });

  final StorageProvider storage;
  final FormattingProvider formattingProvider;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  _FavoritesPageState();

  late StorageProvider storage;
  late FormattingProvider formattingProvider;

  _favoriteChange(int index) async {
    setState(() {
      storage.favoritedChannels
          .remove(storage.arrangedChannelList[index].channelName);
      storage.arrangedChannelList.removeAt(index);
    });
    await storage.saveChanges();
  }

  _goToChannel(int index) {
    if (storage.arrangedChannelList[index].source == Source.iptv) {
      goToChannelPageIPTV(context: context, index: storage.channels.getIndexByChannelName(storage.arrangedChannelList[index].channelName), storage: storage);
    } else {
      goToChannelPageYouTube(context: context, index: storage.channels.getIndexByChannelName(storage.arrangedChannelList[index].channelName), storage: storage);
    }
  }

  @override
  void initState() {
    super.initState();
    storage = widget.storage;
    formattingProvider = widget.formattingProvider;
    storage.initializeFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return (storage.arrangedChannelList.isNotEmpty)
        ? SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: storage.arrangedChannelList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: GestureDetector(
                        onTap: () => _goToChannel(index),
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 9.0),
                                child: formattingProvider.formatIcon(
                                    storage.arrangedChannelList[index].source),
                              ),
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9.0),
                                    child: Text(
                                      storage.arrangedChannelList[index]
                                          .channelName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    )),
                              ),
                              GestureDetector(
                                onTap: () => _favoriteChange(index),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9.0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.indigo[900],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ),
                    );
                  }),
            ],
          ))
        : const Center(
            child: Text('No Channels', style: TextStyle(fontSize: 27.0)),
          );
  }
}
