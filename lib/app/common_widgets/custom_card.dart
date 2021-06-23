import 'package:alo_self/app/common_widgets/custom_radius_container.dart';
import 'package:alo_self/app/utils/custom_pair.dart';
import 'package:flutter/material.dart';

class CustomCard<T> extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.details,
    this.editCallback,
    this.deleteCallback,
    this.addCallback,
    this.items,
  }) : super(key: key);

  final List<CustomPair<String, String>> details;


  final VoidCallback? editCallback;

  final VoidCallback? deleteCallback;

  final VoidCallback? addCallback;

  final List<CustomPair<VoidCallback, CustomPair<String, String>>>? items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: CustomRaduisContainer(
        radius: 10,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              for (final detail in details)
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(detail.first),
                      Text(detail.second),
                    ],
                  ),
                ),
              if (items != null)
                for (final item in items!)
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.second.first),
                        Text(item.second.second),
                        IconButton(
                          onPressed: item.first,
                          icon: Icon(Icons.edit_outlined),
                        ),
                      ],
                    ),
                  ),
              if (editCallback != null || deleteCallback != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (editCallback != null)
                      IconButton(
                        onPressed: editCallback,
                        icon: Icon(Icons.edit),
                      ),
                    SizedBox(width: 10),
                    if (deleteCallback != null)
                      IconButton(
                        onPressed: deleteCallback,
                        icon: Icon(Icons.delete),
                      ),
                    SizedBox(width: 10),
                    if (addCallback != null)
                      IconButton(
                        onPressed: addCallback,
                        icon: Icon(Icons.food_bank_outlined),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
