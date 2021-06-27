import 'package:alo_self/app/common_widgets/custom_card.dart';
import 'package:alo_self/app/common_widgets/custom_form.dart';
import 'package:alo_self/app/common_widgets/custom_item_list.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:alo_self/app/utils/custom_pair.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key, this.resultFoods}) : super(key: key);
  final List<Food>? resultFoods;

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: [
          InkWell(
            child: Row(
              children: [
                Icon(Icons.shopping_cart),
                SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    controller.foodsToOrder.length.toString(),
                    style: TextStyle(
                      color: Colors.red[500],
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              final totalValue =
                  controller.foodsToOrder.fold<int>(0, (int previousValue, element) => (element.cost + previousValue));
              CustomForm.show(
                context,
                formTitle: 'Make Order',
                textFields: [
                  ...controller.foodsToOrder
                      .map(
                        (element) => CustomCard(
                          details: [
                            CustomPair('Name: ${element.name}', 'Price: ${element.cost.toString()}'),
                          ],
                        ),
                      )
                      .toList(),
                  SizedBox(height: 30),
                  // MaterialButton(
                  //   color: Colors.green[900],
                  //   onPressed: () {},
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: Text(
                  //       'Make Order',
                  //       style: TextStyle(
                  //         fontSize: 24,
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.w700,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Text('Total Price: $totalValue'),
                ],
                buttonOnPressed: () {},
                buttonText: 'Make Order',
              );
            },
          ),
        ],
      ),
      body: widget.resultFoods == null || widget.resultFoods!.isEmpty
          ? Center(
              child: Text('No Result!'),
            )
          : CustomItemList(
              items: widget.resultFoods!
                  .where((e) => e.orderable)
                  .map(
                    (e) => CustomCard(
                      details: [
                        CustomPair('Name: ${e.name}', 'Price: ${e.cost}'),
                      ],
                      addCallback: () {
                        controller.foodsToOrder.add(e);
                        setState(() {});
                      },
                      iconAdd: Icons.add,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
