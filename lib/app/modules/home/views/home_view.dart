import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.pageTitles_home.tr,
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
                          LocaleKeys.home_title.tr,
                          style: Get.textTheme.headline1,
                        ),
                        SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              LocaleKeys.home_totalRequests.tr + ": 2",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Container(
                              height: 25,
                              width: 2,
                              color: Colors.grey,
                            ),
                            Text(
                              LocaleKeys.home_totalDeliveries.tr + ": 1",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          LocaleKeys.home_cash.tr + ": 20,000 تومان",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: Colors.green[800]),
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
                            _buildIconView(Icons.delivery_dining, "قبول سفارش"),
                            _buildIconView(Icons.add, "ثبت سفارش"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildIconView(Icons.history, "سوابق ارسال"),
                            _buildIconView(Icons.support_agent, "ارتباط با پشتیبانی"),
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
        bottomNavigationBar: SalomonBottomBar(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          currentIndex: controller.navBarIndex.value,
          onTap: (index) => controller.updateIndex(index),
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text(LocaleKeys.pageTitles_home.tr),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.request_page),
              title: Text(LocaleKeys.pageTitles_request.tr),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.send_rounded),
              title: Text(LocaleKeys.pageTitles_delivery.tr),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text(LocaleKeys.pageTitles_profile.tr),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconView(IconData iconData, String text) {
    return Flexible(
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
    );
  }
}
