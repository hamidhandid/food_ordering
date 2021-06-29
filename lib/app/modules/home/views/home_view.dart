import 'package:alo_self/app/api/order/order_api.dart';
import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/app/common_widgets/custom_button.dart';
import 'package:alo_self/app/common_widgets/custom_card.dart';
import 'package:alo_self/app/common_widgets/custom_form.dart';
import 'package:alo_self/app/common_widgets/custom_item_list.dart';
import 'package:alo_self/app/common_widgets/custom_snackbar.dart';
import 'package:alo_self/app/common_widgets/custom_text_field.dart';
import 'package:alo_self/app/model/order.dart';
import 'package:alo_self/app/model/orders.dart';
import 'package:alo_self/app/model/restaurant.dart';
import 'package:alo_self/app/modules/restaurants/controllers/restaurants_controller.dart';
import 'package:alo_self/app/modules/restaurants/views/restaurants_view.dart';
import 'package:alo_self/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Order>? orders;

  @override
  Widget build(BuildContext context) {
    final restaurantsController = Get.put(RestaurantsController());
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'خانه مدیر',
        onTap: () async {
          await controller.logout();
        },
        showLogoutAction: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(
              Icons.replay_outlined,
              size: 30,
            ),
          ),
        ],
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
                                      buttonOnPressed: () => _showAddRestaurantModal(controller, context),
                                      buttonText: 'رستوران خود را اضافه کنید',
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Column(
                                        children: [
                                          Row(
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
                                          SizedBox(height: 25),
                                          FutureBuilder<Orders?>(
                                            future: OrderApi().getAllOrders(),
                                            builder: (context, orderSnapshot) {
                                              if (!orderSnapshot.hasData || orderSnapshot.hasError) {
                                                return Container();
                                              }
                                              orders = orderSnapshot.data!.orders!;
                                              if (orders!
                                                  .where((el) => el.sender != null)
                                                  .where((el) => el.status != 'در حال ارسال')
                                                  .isNotEmpty) {
                                                return CustomButton(
                                                  buttonOnPressed: () {
                                                    _onPressedOfOrders();
                                                  },
                                                  buttonText: 'رسیدگی به سفارش‌ها',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                );
                                              }
                                              return Column(
                                                children: [
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'سفارشی به شما نرسیده است',
                                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              );
                                            },
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
                            onTap: () => _showAddRestaurantModal(controller, context),
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
                              _onPressedOfOrders();
                            },
                          ),
                          _buildIconView(
                            Icons.support_agent,
                            "ارتباط با پشتیبانی",
                            onTap: () {
                              CustomForm.show(context, formTitle: 'انتقادها و پیشنهادها', textFields: [
                                CustomTextField(
                                  controller: TextEditingController(),
                                  labelText: 'عنوان',
                                ),
                                CustomTextField(
                                  controller: TextEditingController(),
                                  labelText: 'متن',
                                ),
                              ], buttonOnPressed: () {
                                Get.back();
                                CustomSnackBar.show('موفق', 'نظر شما ارسال شد');
                              }, buttonText: 'ارسال نظر');
                            },
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

  void _showAddRestaurantModal(HomeController controller, BuildContext context) {
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
        setState(() {});
      },
      buttonText: 'اضافه کردن',
    );
  }

  void _onPressedOfOrders() {
    CustomForm.show(
      context,
      formTitle: 'سفارش‌های رسیده',
      textFields: [
        if (orders != null &&
            orders!.where((el) => el.sender != null).where((el) => el.status != 'در حال ارسال').isNotEmpty)
          CustomItemList(
            items: [
              for (final ord in orders!.where((el) => el.sender != null).where((el) => el.status != 'در حال ارسال'))
                NormalCard(
                  topStart:
                      'مقصد: ${ord.customer?.area} | ارسال کننده: ${ord.sender?.first_name ?? ''} ${ord.sender?.last_name ?? ''}',
                  bottomStart:
                      'سفارش ${ord.foods.map((e) => e.name).toList().join(' و ')} به ${ord.customer?.first_name ?? ""} ${ord.customer?.last_name ?? ""}',
                  bottomEnd:
                      'زمان سفارش: ${ord.time!.substring(ord.time!.indexOf('2021') + 5, ord.time!.indexOf('2021') + 10)}',
                  addCallback: () async {
                    final _res = await OrderApi().editOrder(
                      ord.id!,
                      status: 'در حال ارسال',
                      // sender: profileSnapshot.data,
                    );
                    if (_res != null) {
                      CustomSnackBar.show(
                        'موفق',
                        'شما سفارش ${ord.foods.map((e) => e.name).toList().join(' و ')} را به ارسال کننده تحویل دادید',
                      );
                      setState(() {});
                    }
                  },
                  additionItemsTitle: '',
                  iconAdd: Icons.delivery_dining_sharp,
                )
            ],
          )
        else
          Text(
            'سفارشی ندارید',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
      buttonOnPressed: () {},
      showSubmitButton: false,
    );
  }
}
