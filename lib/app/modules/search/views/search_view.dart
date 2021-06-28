import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/app/common_widgets/custom_card.dart';
import 'package:alo_self/app/common_widgets/custom_form.dart';
import 'package:alo_self/app/common_widgets/custom_item_list.dart';
import 'package:alo_self/app/common_widgets/custom_money_formatter.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:alo_self/app/common_widgets/custom_pair.dart';
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
  late final List<Food> foodsOfOrder = [];

  bool reload = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchController());
    return Scaffold(
      appBar: CustomAppBar(
        title: 'نتایج جستجو',
        actions: [
          Obx(
            () => InkWell(
              child: Row(
                children: [
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      controller.foodsToOrder.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                CustomForm.show(
                  context,
                  formTitle: 'سفارش غذا',
                  showTextFields: false,
                  hasBackgroundColor: true,
                  textFields: [
                    StatefulBuilder(
                      builder: (context, customSetState) {
                        final totalValue = controller.foodsToOrder
                            .fold<int>(0, (int previousValue, element) => (element.cost + previousValue));
                        return Wrap(
                          children: [
                            SafeArea(
                              child: Container(
                                // color: Theme.of(context).backgroundColor.withOpacity(0.5),
                                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ...foodsOfOrder
                                              .map(
                                                (element) => NormalCard(
                                                  topStart: 'نام غذا: ${element.name}',
                                                  bottomStart:
                                                      'قیمت غذا: ${CustomMoneyFormatter.formatMoney(element.cost)}',
                                                  additionItemsTitle: 'سفارش‌ها',
                                                  iconAdd: Icons.remove_circle_outline,
                                                  addCallback: () {
                                                    controller.foodsToOrder.remove(element);
                                                    foodsOfOrder.remove(element);
                                                    customSetState(() {});
                                                    setState(() {});
                                                  },
                                                ),
                                              )
                                              .toList(),
                                          SizedBox(height: 20),
                                          SizedBox(height: 30),
                                          Text(
                                            'مجموع هزینه: ${CustomMoneyFormatter.formatMoney(totalValue)}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                  buttonOnPressed: () {},
                  buttonText: 'سفارش',
                );
              },
            ),
          ),
        ],
      ),
      body: widget.resultFoods == null || widget.resultFoods!.isEmpty
          ? Center(
              child: Text('نتیجه‌ای یافت نشد'),
            )
          : CustomItemList(
              items: widget.resultFoods!
                  .where((e) => e.orderable)
                  .map(
                    (e) => NormalCard(
                      topStart: 'نام غذا: ${e.name}',
                      bottomStart: 'قیمت غذا: ${CustomMoneyFormatter.formatMoney(e.cost)}',
                      addCallback: () {
                        controller.foodsToOrder.add(e);
                        foodsOfOrder.add(e);
                        setState(() {});
                      },
                      iconAdd: Icons.add,
                      additionItemsTitle: 'سفارش‌ها',
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
