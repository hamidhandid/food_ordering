import 'package:alo_self/app/common_widgets/custom_radius_container.dart';
import 'package:alo_self/app/utils/custom_pair.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.details,
    this.editCallback,
    this.deleteCallback,
  }) : super(key: key);

  final List<CustomPair<String, String>> details;

  final VoidCallback? editCallback;

  final VoidCallback? deleteCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: CustomRaduisContainer(
        radius: 10,
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
            if (editCallback != null || deleteCallback != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                ],
              ),
          ],
        ),
      ),
    );
  }
}
