import 'package:digilogtv/services/formatting.dart';
import 'package:flutter/material.dart';

import 'package:digilogtv/services/storage.dart';
import 'package:digilogtv/pages/home pages/channellistpage.dart';
import 'package:digilogtv/pages/home pages/favoritespage.dart';
import 'package:digilogtv/pages/home%20pages/contactpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.storage, required this.formattingProvider,});

  final StorageProvider storage;
  final FormattingProvider formattingProvider;

  @override
  State<HomePage> createState() => _HomePageState(storage, formattingProvider,);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this.storage, this.formattingProvider,);

  late StorageProvider storage;
  late FormattingProvider formattingProvider;

  int _selectedIndex = 1;

  late List<Widget> _pages;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      const ContactPage(),
      ChannelListPage(storage: storage, formattingProvider: formattingProvider,),
      FavoritesPage(storage: storage, formattingProvider: formattingProvider,),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digilog TV'),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        child: _pages.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.indigo[900],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Contact Me',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.reorder),
              label: 'Channel List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ]),
    );
  }
}
