import 'package:flutter/material.dart';

import 'package:digilogtv/services/storage.dart';
import 'package:digilogtv/services/formatting.dart';
import 'package:digilogtv/services/channels.dart';
import 'package:digilogtv/services/routing.dart';
import 'package:digilogtv/services/dpadoption.dart';
import 'package:digilogtv/pages/home%20pages/home%20pages%20widgets/mainappbar.dart';
import 'package:digilogtv/pages/home%20pages/home%20pages%20widgets/topnavbar.dart';

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({
    super.key,
    required this.storage,
    required this.formattingProvider,
    required this.isTV,
  });

  final StorageProvider storage;
  final FormattingProvider formattingProvider;
  final bool isTV;

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  late StorageProvider storage;
  late FormattingProvider formattingProvider;
  late bool isTV;
  int _focusedIndex = 1;

  void _updateFocus(int newIndex) {
    setState(() {
      _focusedIndex = newIndex;
    });
  }

  _favoriteIcon(String channelName) {
    if (!storage.favoritedChannels.contains(channelName)) {
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
    if (storage.favoritedChannels
        .contains(storage.channels.channelList[index].channelName)) {
      setState(() {
        storage.favoritedChannels
            .remove(storage.channels.channelList[index].channelName);
      });
    } else {
      setState(() {
        storage.favoritedChannels
            .add(storage.channels.channelList[index].channelName);
      });
    }
    await storage.saveChanges();
  }

  void _goToChannel(int index) {
    if (storage.channels.channelList[index].source == Source.iptv) {
      goToChannelPageIPTV(
          context: context, index: index, storage: storage, isTV: isTV);
    } else {
      goToChannelPageYouTube(
          context: context, index: index, storage: storage, isTV: isTV);
    }
  }

  @override
  void initState() {
    super.initState();
    storage = widget.storage;
    formattingProvider = widget.formattingProvider;
    isTV = widget.isTV;
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
              storage: storage,
              formattingProvider: formattingProvider,
              isTV: isTV,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: storage.channels.channelList.length,
              itemBuilder: (context, index) {
                bool isChannelFocused = _focusedIndex == index + 3;
                Color? channelColor =
                    isChannelFocused ? Colors.blue[300] : null;
                bool isStarFocused = _focusedIndex ==
                    index + 3 + storage.channels.channelList.length;
                Color? starColor = isStarFocused ? Colors.blue[300] : null;
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 9.0),
                                      child: formattingProvider.formatIcon(
                                          storage.channels.channelList[index]
                                              .source),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 9.0),
                                      child: Text(
                                        storage.channels.channelList[index]
                                            .channelName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                                storage.channels.channelList.length);
                          }
                        },
                        child: GestureDetector(
                          onTap: () => _favoriteChange(index),
                          child: Card(
                            color: starColor,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 9.0),
                                child: _favoriteIcon(storage
                                    .channels.channelList[index].channelName),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
