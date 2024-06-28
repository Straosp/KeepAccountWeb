

import 'package:flutter/material.dart';

class KeepAccountWebAppBar extends StatelessWidget implements PreferredSizeWidget {



  const KeepAccountWebAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Text("KeepAccount"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight( 48);
  
  
  
}