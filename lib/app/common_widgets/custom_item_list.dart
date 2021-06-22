import 'package:flutter/material.dart';

class CustomItemList extends StatelessWidget {
  const CustomItemList({Key? key, required this.items}) : super(key: key);

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            for (final item in items)
              Column(
                children: [
                  item,
                  SizedBox(height: 12),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
