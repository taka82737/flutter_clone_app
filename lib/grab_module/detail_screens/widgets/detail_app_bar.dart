import 'package:flutter/material.dart';

class DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;
  final Widget? trailing;

  const DetailAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onBackPressed,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      elevation: 0.5,
      backgroundColor: Colors.white,
      actions: trailing != null ? [Padding(padding: EdgeInsets.all(16), child: trailing)] : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
