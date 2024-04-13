import 'package:flutter/material.dart';

import 'package:digilogtv/services/storage.dart';
import 'package:digilogtv/services/formatting.dart';
import 'package:digilogtv/services/channels.dart';
import 'package:digilogtv/services/routing.dart';
import 'package:digilogtv/services/dpadoption.dart';
import 'package:digilogtv/pages/home%20pages/home%20pages%20widgets/mainappbar.dart';
import 'package:digilogtv/pages/home%20pages/home%20pages%20widgets/topnavbar.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    super.key,
    required this.storage,
    required this.formattingProvider,
    required this.isTV,
  });

  final StorageProvider storage;
  final FormattingProvider formattingProvider;
  final bool isTV;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  _FavoritesPageState();

  late StorageProvider storage;
  late FormattingProvider formattingProvider;
  late bool isTV;
  int _focusedIndex = 2;

  void _updateFocus(int newIndex) {
    setState(() {
      _focusedIndex = newIndex;
    });
  }

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
      goToChannelPageIPTV(
          context: context,
          index: storage.channels.getIndexByChannelName(
              storage.arrangedChannelList[index].channelName),
          storage: storage,
          isTV: isTV);
    } else {
      goToChannelPageYouTube(
          context: context,
          index: storage.channels.getIndexByChannelName(
              storage.arrangedChannelList[index].channelName),
          storage: storage,
          isTV: isTV);
    }
  }

  @override
  void initState() {
    super.initState();
    storage = widget.storage;
    formattingProvider = widget.formattingProvider;
    isTV = widget.isTV;
    storage.initializeFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return (storage.arrangedChannelList.isNotEmpty)
        ? Scaffold(
            appBar: const MainAppBar(),
            body: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TopNavBar(
                  storage: storage,
                  formattingProvider: formattingProvider,
                  focusedIndex: _focusedIndex,
                  updateFocus: _updateFocus,
                  isTV: isTV,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: storage.arrangedChannelList.length,
                    itemBuilder: (context, index) {
                      bool isChannelFocused = _focusedIndex == index + 3;
                      Color? channelColor =
                          isChannelFocused ? Colors.blue[300] : null;
                      bool isStarFocused = _focusedIndex ==
                          index + 3 + storage.arrangedChannelList.length;
                      Color? starColor =
                          isStarFocused ? Colors.blue[300] : null;
                      return Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: DpadOption(
                                onSelect: () => _goToChannel(index),
                                onFocus: (isFocused) {
                                  if (isFocused) {
                                    _updateFocus(index + 3);
                                  }
                                },
                                child: GestureDetector(
                                  onTap: () => _goToChannel(index),
                                  child: Card(
                                      color: channelColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 9.0),
                                              child: formattingProvider
                                                  .formatIcon(storage
                                                      .arrangedChannelList[
                                                          index]
                                                      .source),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 9.0),
                                                child: Text(
                                                  storage
                                                      .arrangedChannelList[
                                                          index]
                                                      .channelName,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0),
                                                )),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: DpadOption(
                              onSelect: () => _favoriteChange(index),
                              onFocus: (isFocused) {
                                if (isFocused) {
                                  _updateFocus(index +
                                      3 +
                                      storage.arrangedChannelList.length);
                                }
                              },
                              child: GestureDetector(
                                onTap: () => _favoriteChange(index),
                                child: Card(
                                  color: starColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 9.0),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.indigo[900],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            )),
          )
        : Scaffold(
            appBar: const MainAppBar(),
            body: Column(
              children: [
                TopNavBar(
                  storage: storage,
                  formattingProvider: formattingProvider,
                  focusedIndex: _focusedIndex,
                  updateFocus: _updateFocus,
                  isTV: isTV,
                ),
                const Expanded(
                  child: Center(
                    child:
                        Text('No Channels', style: TextStyle(fontSize: 27.0)),
                  ),
                ),
              ],
            ),
          );
  }
}
