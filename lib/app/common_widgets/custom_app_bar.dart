import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.onTap,
    this.showLogoutAction = false,
    this.actions,
  }) : super(key: key);
  final String title;
  final VoidCallback? onTap;
  final List<Widget>? actions;
  final bool showLogoutAction;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 26,
            ),
          ),
        ),
        actions: showLogoutAction
            ? [
                if (actions != null) ...actions!,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
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
