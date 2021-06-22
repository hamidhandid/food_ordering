import 'package:alo_self/app/common_widgets/custom_card.dart';
import 'package:alo_self/app/common_widgets/custom_item_list.dart';
import 'package:alo_self/app/common_widgets/custom_screen.dart';
import 'package:alo_self/app/utils/custom_pair.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/restaurants_controller.dart';

class RestaurantsView extends GetView<RestaurantsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
      body: CustomScreen(
        onInit: () async => await controller.getRestaurants(),
        isLoading: controller.isLoading,
        child: controller.restaurants != null
            ? CustomItemList(
                items: controller.restaurants!
                    .map(
                      (e) => CustomCard(
                        editCallback: () {},
                        details: [
                          CustomPair(e.name, e.work_hour),
                          CustomPair(e.area, e.address),
                        ],
                      ),
                    )
                    .toList(),
              )
            : Container(),
      ),
    );
  }
}
