import 'package:flutter/material.dart';

import 'package:digilogtv/services/storage.dart';
import 'package:digilogtv/services/formatting.dart';
import 'package:digilogtv/services/channels.dart';
import 'package:digilogtv/pages/channelpage-iptv.dart';
import 'package:digilogtv/pages/channelpage-youtube.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage(
      {super.key,
      required this.storage,
      required this.formattingProvider,});

  final StorageProvider storage;
  final FormattingProvider formattingProvider;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState(
      storage, formattingProvider,);
}

class _FavoritesPageState extends State<FavoritesPage> {
  _FavoritesPageState(this.storage, this.formattingProvider,);

  late StorageProvider storage;
  late FormattingProvider formattingProvider;

  favoriteChange(int index) async {
      setState(() {
      storage.favoritedChannels.remove(storage.arrangedChannelList[index].channelName);
      storage.arrangedChannelList.removeAt(index);
      });
    await storage.saveChanges();
  }

  goToChannel(int index) {
    if (storage.channels.channelList[index].source == Source.iptv) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChannelPageIPTV(
                  index: storage.channels.getIndexByChannelName(storage.arrangedChannelList[index].channelName),
                  storage: storage,
                )));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChannelPageYouTube(
                  index: storage.channels.getIndexByChannelName(storage.arrangedChannelList[index].channelName),
                  storageProvider: storage,
                )));
    }
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    storage.initializeFavorites();
    super.initState();
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
                        onTap: () => goToChannel(index),
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 9.0),
                                child: formattingProvider
                                    .formatIcon(storage.arrangedChannelList[index].source),
                              ),
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9.0),
                                    child: Text(
                                      storage.arrangedChannelList[index].channelName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    )),
                              ),
                              GestureDetector(
                                onTap: () => favoriteChange(index),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 9.0),
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
                  })
            ],
          ))
        : const Center(
            child: Text('No Channels', style: TextStyle(fontSize: 27.0)),
          );
  }
}
