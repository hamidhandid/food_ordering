import 'package:alo_self/app/api/order/order_api.dart';
import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/app/common_widgets/custom_button.dart';
import 'package:alo_self/app/common_widgets/custom_form.dart';
import 'package:alo_self/app/common_widgets/custom_money_formatter.dart';
import 'package:alo_self/app/common_widgets/custom_text_field.dart';
import 'package:alo_self/app/model/orders.dart';
import 'package:alo_self/app/model/user_profile.dart';
import 'package:alo_self/app/modules/delivery/views/delivery_view.dart';
import 'package:alo_self/app/modules/orders/views/orders_view.dart';
import 'package:alo_self/app/modules/search/views/search_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_home_controller.dart';

class UserHomeView extends StatefulWidget {
  @override
  _UserHomeViewState createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
  final controller = Get.find<UserHomeController>();
  UserProfile? userProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'خانه',
        onTap: () async {
          await controller.logout();
        },
        showLogoutAction: true,
      ),
      body: Container(
        child: StatefulBuilder(
          builder: (context, customSetState) => Container(
            child: Column(
              children: [
                Text(
                  'الوسلف',
                  style: Get.textTheme.headline1,
                ),
                SizedBox(height: 20),
                FutureBuilder<UserProfile?>(
                  future: controller.getProfile(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data == null) {
                      return Container();
                    }
                    userProfile = snapshot.data;

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              snapshot.data!.first_name.isEmpty && snapshot.data!.last_name.isEmpty
                                  ? 'نام: نامشخص'
                                  : 'نام: ${snapshot.data!.first_name} ${snapshot.data!.last_name}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Container(
                              height: 25,
                              width: 2,
                              color: Colors.grey,
                            ),
                            Text(
                              'دانشکده: ${snapshot.data!.area.isEmpty ? "نامشخص" : "${snapshot.data!.area}"}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'اعتبار: ${CustomMoneyFormatter.formatMoney(snapshot.data!.credit!)}',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: Colors.green[800]),
                        ),
                        SizedBox(height: 30),
                        userProfile!.first_name.isEmpty
                            ? CustomButton(
                                buttonOnPressed: () => _showEditProfileModal(
                                  context,
                                  userProfile: userProfile,
                                ),
                                buttonText: 'پروفایل خود را کامل کنید',
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FutureBuilder<Orders?>(
                                      future: OrderApi().getCustomerOrders(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData || snapshot.hasError) {
                                          return Container();
                                        }
                                        return Text(
                                          'تعداد کل سفارش‌ها: ${snapshot.data!.orders!.length}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        );
                                      },
                                    ),
                                    // Text(
                                    //   'تعداد غذاها: ${snapshot.data!.fold(0, (int previousValue, element) => previousValue + (element.foods?.length ?? 0))}',
                                    //   style: TextStyle(
                                    //     fontSize: 18,
                                    //     fontWeight: FontWeight.w600,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 30),
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
                              Icons.search,
                              'جستجوی غذاها',
                              onTap: () {
                                CustomForm.show(
                                  context,
                                  formTitle: 'جستجوی غذا',
                                  textFields: controller.searchControllers
                                      .map((e) => CustomTextField(
                                            controller: e.second.value,
                                            labelText: e.first,
                                          ))
                                      .toList(),
                                  buttonOnPressed: () async {
                                    final _resFoods = await controller.searchFoods();
                                    await Get.off(() => SearchView(
                                          resultFoods: _resFoods,
                                        ));
                                  },
                                  buttonText: 'جستجو',
                                );
                              },
                            ),
                            _buildIconView(
                              Icons.history,
                              'سابقه سفارش‌ها',
                              onTap: () {
                                Get.to(() => OrdersView());
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildIconView(
                              Icons.delivery_dining_rounded,
                              'سابقه ارسال‌ها',
                              onTap: () {
                                Get.to(() => DeliveryView());
                              },
                            ),
                            _buildIconView(
                              Icons.person_outline_rounded,
                              'ویرایش پروفایل',
                              onTap: () => _showEditProfileModal(
                                context,
                                userProfile: userProfile,
                              ),
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

  void _showEditProfileModal(BuildContext context, {UserProfile? userProfile}) {
    if (userProfile != null) {
      controller.firstNameController.value.text = userProfile.first_name;
      controller.lastNameController.value.text = userProfile.last_name;
      controller.areaController.value.text = userProfile.area;
      // controller.addressController.value.text = userProfile.address;
      controller.creditController.value.text = userProfile.credit.toString();
    }
    CustomForm.show(
      context,
      formTitle: 'پروفایل کاربر',
      textFields: controller.editProfileControllers
          .map((e) => CustomTextField(
                controller: e.second.value,
                labelText: e.first,
              ))
          .toList(),
      buttonOnPressed: () async {
        await controller.editProfile();
        Get.back();
        setState(() {});
      },
      buttonText: 'ویرایش پروفایل',
    );
  }
}
