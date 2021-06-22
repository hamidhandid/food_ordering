import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/app/common_widgets/custom_form.dart';
import 'package:alo_self/app/common_widgets/custom_snackbar.dart';
import 'package:alo_self/app/modules/restaurants/controllers/restaurants_controller.dart';
import 'package:alo_self/app/modules/restaurants/views/restaurants_view.dart';
import 'package:alo_self/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Parham Food',
        onTap: () async {
          await controller.logout();
        },
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(25).copyWith(bottom: 0),
                child: SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      Text(
                        'Parham, the Best',
                        style: Get.textTheme.headline1,
                      ),
                      SizedBox(height: 35),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Text(
                      //       LocaleKeys.home_totalRequests.tr + ": 2",
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 17,
                      //       ),
                      //     ),
                      //     Container(
                      //       height: 25,
                      //       width: 2,
                      //       color: Colors.grey,
                      //     ),
                      //     Text(
                      //       LocaleKeys.home_totalDeliveries.tr + ": 1",
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 17,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Text(
                      //   LocaleKeys.home_cash.tr + ": 20,000 تومان",
                      //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: Colors.green[800]),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 45),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFC8E6C9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildIconView(
                            Icons.restaurant,
                            "Restaurant List",
                            onTap: () {
                              Get.lazyPut(() => RestaurantsController());
                              Get.to(() => RestaurantsView());
                            },
                          ),
                          _buildIconView(
                            Icons.add,
                            "Add Restaurant",
                            onTap: () => CustomForm.show(
                              context,
                              formTitle: 'Add Restaurant',
                              textFields: controller.addRestaurantControllers
                                  .map((e) => TextField(
                                        controller: e.second.value,
                                        decoration: InputDecoration(
                                          labelText: e.first,
                                        ),
                                      ))
                                  .toList(),
                              buttonOnPressed: () async {
                                final _res = await controller.addRestaurant();
                                if (_res != null) {
                                  Get.back();
                                  CustomSnackBar.show(
                                    'Succeed',
                                    'Restaurant ${_res.name} added',
                                  );
                                }
                              },
                              buttonText: 'Add',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildIconView(Icons.history, 'Send History'),
                          _buildIconView(Icons.support_agent, 'Contact Us'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconView(IconData iconData, String text, {VoidCallback? onTap}) {
    return Flexible(
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Column(
          children: [
            Icon(
              iconData,
              color: Colors.green[600],
              size: 60,
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
