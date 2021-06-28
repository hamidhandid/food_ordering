import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/app/common_widgets/custom_button.dart';
import 'package:alo_self/app/common_widgets/custom_form.dart';
import 'package:alo_self/app/common_widgets/custom_snackbar.dart';
import 'package:alo_self/app/common_widgets/custom_text_field.dart';
import 'package:alo_self/app/model/restaurant.dart';
import 'package:alo_self/app/modules/restaurants/controllers/restaurants_controller.dart';
import 'package:alo_self/app/modules/restaurants/views/restaurants_view.dart';
import 'package:alo_self/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final restaurantsController = Get.put(RestaurantsController());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'خانه مدیر',
        onTap: () async {
          await controller.logout();
        },
        showLogoutAction: true,
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
                        'الوسلف',
                        style: Get.textTheme.headline1,
                      ),
                      SizedBox(height: 20),
                      FutureBuilder<List<Restaurant>?>(
                        future: restaurantsController.getRestaurants(),
                        builder: (BuildContext context, AsyncSnapshot<List<Restaurant>?> snapshot) {
                          return !snapshot.hasData || snapshot.hasError
                              ? CircularProgressIndicator()
                              : snapshot.data == null || snapshot.data!.isEmpty
                                  ? CustomButton(
                                      buttonOnPressed: () => _showAddRestaurantModal(context),
                                      buttonText: 'رستوران خود را اضافه کنید',
                                    )
                                  : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'تعداد رستوران‌ها: ${snapshot.data!.length}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'تعداد غذاها: ${snapshot.data!.fold(0, (int previousValue, element) => previousValue + (element.foods?.length ?? 0))}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                  );
                        },
                      ),
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
                            "لیست رستوران‌ها",
                            onTap: () {
                              // Get.lazyPut(() => RestaurantsController());
                              Get.to(() => RestaurantsView());
                            },
                          ),
                          _buildIconView(
                            Icons.add,
                            "اضافه‌کردن رستوران",
                            onTap: () => _showAddRestaurantModal(context),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildIconView(
                            Icons.list_alt_sharp,
                            "سفارش‌های رسیده",
                            onTap: () {
                              // Get.lazyPut(() => RestaurantsController());
                              // Get.to(() => RestaurantsView());
                            },
                          ),
                          _buildIconView(
                            Icons.support_agent,
                            "ارتباط با پشتیبانی",
                            onTap: () {},
                          ),
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

  void _showAddRestaurantModal(BuildContext context) {
    CustomForm.show(
      context,
      formTitle: 'اضافه‌کردن رستوران',
      textFields: controller.addRestaurantControllers
          .map((e) => CustomTextField(
                controller: e.second.value,
                labelText: e.first,
                isMoney: e.first == 'هزینه ثابت ارسال غذا',
              ))
          .toList(),
      buttonOnPressed: () async {
        final _res = await controller.addRestaurant();
        if (_res != null) {
          Get.back();
          CustomSnackBar.show(
            'موفق',
            'رستوران ${_res.name} اضافه شد',
          );
        }
      },
      buttonText: 'اضافه کردن',
    );
  }
}
