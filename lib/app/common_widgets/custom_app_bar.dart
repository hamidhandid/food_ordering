import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.onTap,
    this.showLogoutAction = true,
  }) : super(key: key);
  final String title;
  final VoidCallback? onTap;
  final bool showLogoutAction;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 28,
            ),
          ),
        ),
        actions: showLogoutAction
            ? [
                InkWell(
                  onTap: () {
                    if (onTap != null) {
                      onTap!();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.logout,
                      size: 30,
                    ),
                  ),
                ),
              ]
            : null,
        // centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
