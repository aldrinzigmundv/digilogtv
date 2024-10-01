import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Digilog TV'),
      titleTextStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      centerTitle: true,
      backgroundColor: Colors.indigo[900],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
