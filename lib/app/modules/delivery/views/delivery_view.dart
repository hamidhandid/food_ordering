import 'package:alo_self/app/api/order/order_api.dart';
import 'package:alo_self/app/api/user/user_api.dart';
import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/app/common_widgets/custom_button.dart';
import 'package:alo_self/app/common_widgets/custom_card.dart';
import 'package:alo_self/app/common_widgets/custom_form.dart';
import 'package:alo_self/app/common_widgets/custom_item_list.dart';
import 'package:alo_self/app/common_widgets/custom_money_formatter.dart';
import 'package:alo_self/app/common_widgets/custom_pair.dart';
import 'package:alo_self/app/common_widgets/custom_snackbar.dart';
import 'package:alo_self/app/common_widgets/custom_time_line.dart';
import 'package:alo_self/app/model/orders.dart';
import 'package:alo_self/app/model/user_profile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/delivery_controller.dart';

class DeliveryView extends StatefulWidget {
  @override
  _DeliveryViewState createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  bool reload = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Orders?>(
      future: OrderApi().getAllOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return FutureBuilder<UserProfile?>(
          future: UserApi().getProfile(),
          builder: (context, profileSnapshot) {
            if (profileSnapshot.hasError || !profileSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Scaffold(
              appBar: CustomAppBar(
                title: 'ارسال‌ها',
                actions: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        reload = true;
                      });
                    },
                    icon: Icon(
                      Icons.replay_outlined,
                      size: 30,
                    ),
                  ),
                ],
              ),
              body: snapshot.data!.orders!.where((el) => el.sender?.id == profileSnapshot.data!.id).isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'هیچ ارسالی ندارید',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          CustomButton(
                            buttonText: 'قبول یک سفارش',
                            buttonOnPressed: () {
                              CustomForm.show(
                                context,
                                formTitle: 'قبول سفارش',
                                textFields: [
                                  CustomItemList(
                                    items: [
                                      if (snapshot.data!.orders!
                                          .where((el) => el.customer?.id != profileSnapshot.data!.id).where((el) => el.sender == null)
                                          .isNotEmpty)
                                        for (final ord in snapshot.data!.orders!
                                            .where((el) => el.customer?.id != profileSnapshot.data!.id).where((el) => el.sender == null))
                                          NormalCard(
                                            topStart: 'مقصد: ${ord.customer?.area}',
                                            bottomStart: 'سفارش ${ord.foods.map((e) => e.name).toList().join(' و ')} به ${ord.customer?.first_name ?? ""} ${ord.customer?.last_name ?? ""}',
                                            bottomEnd:
                                                'زمان سفارش: ${ord.time!.substring(ord.time!.indexOf('2021') + 5, ord.time!.indexOf('2021') + 10)}',
                                            addCallback: () async {
                                              final _res = await OrderApi().editOrder(
                                                ord.id!,
                                                status: 'در حال تحویل به ارسال کننده',
                                                sender: profileSnapshot.data,
                                              );
                                              if (_res != null) {
                                                Get.back();
                                                CustomSnackBar.show(
                                                  'موفق',
                                                  'شما سفارش ${ord.foods.map((e) => e.name).toList().join(' و ')} را پذیرفتید',
                                                );
                                                setState(() {});
                                              }
                                            },
                                            additionItemsTitle: '',
                                            iconAdd: Icons.check_rounded,
                                          )
                                      else
                                        Text(
                                          'هیچ سفارشی برای ارسال موجود نیست',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        )
                                    ],
                                  ),
                                ],
                                buttonOnPressed: () {},
                                showSubmitButton: false,
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : CustomItemList(
                      items: [
                        for (final order
                            in snapshot.data!.orders!.where((el) => el.sender?.id == profileSnapshot.data!.id))
                          NormalCard(
                            topStart: 'سفارش ${order.foods.map((e) => e.name).toList().join(' و ')}',
                            bottomStart:
                                'زمان سفارش: ${order.time!.substring(order.time!.indexOf('2021') + 5, order.time!.indexOf('2021') + 10)}',
                            bottomEnd: order.status,
                            additionItemsTitle: 'غذاها',
                            additionalRowPairs: [
                              for (final food in order.foods)
                                CustomPair(null, CustomPair(food.name, CustomMoneyFormatter.formatMoney(food.cost))),
                            ],
                            additionalWidgets: [
                              SizedBox(height: 10),
                              Text(
                                'گیرنده: ${order.customer?.first_name ?? 'ندارد'} ${order.customer?.last_name ?? ''}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'مقصد: ${order.customer?.area ?? 'نامشخص'}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'مبلغ کل فاکتور: ${CustomMoneyFormatter.formatMoney(order.foods.fold(0, (int previousValue, el) => previousValue + el.cost) + order.restaurant!.deliver_cost)}',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // SizedBox(height: 30),
                              // CustomButton(
                              //   buttonOnPressed: () {
                              //     Get.to(() => CustomTimeLine(
                              //           title: 'وضعیت سفارش ${order.foods.map((e) => e.name).toList().join(' و ')}',
                              //           index: _convertStatusToIndex(order.status),
                              //         ));
                              //   },
                              //   buttonText: 'مشاهده وضعیت سفارش',
                              //   fontWeight: FontWeight.bold,
                              //   fontSize: 16,
                              // ),
                              SizedBox(height: 20),
                            ],
                          ),
                        SizedBox(height: 20),
                        CustomButton(
                                buttonText: 'قبول سفارش',
                                buttonOnPressed: () {
                                  CustomForm.show(
                                    context,
                                    formTitle: 'قبول سفارش',
                                    textFields: [
                                      CustomItemList(
                                        items: [
                                          if (snapshot.data!.orders!
                                              .where((el) => el.customer?.id != profileSnapshot.data!.id).where((el) => el.sender == null)
                                              .isNotEmpty)
                                            for (final ord in snapshot.data!.orders!
                                                .where((el) => el.customer?.id != profileSnapshot.data!.id).where((el) => el.sender == null))
                                              NormalCard(
                                                topStart: 'مقصد: ${ord.customer?.area}',
                                                bottomStart:
                                                    'سفارش ${ord.foods.map((e) => e.name).toList().join(' و ')}',
                                                bottomEnd:
                                                    'زمان سفارش: ${ord.time!.substring(ord.time!.indexOf('2021') + 5, ord.time!.indexOf('2021') + 10)}',
                                                addCallback: () async {
                                                  final _res = await OrderApi().editOrder(
                                                    ord.id!,
                                                    status: 'در حال تحویل به ارسال کننده',
                                                    sender: profileSnapshot.data,
                                                  );
                                                  if (_res != null) {
                                                    Get.back();
                                                    CustomSnackBar.show(
                                                      'موفق',
                                                      'شما سفارش ${ord.foods.map((e) => e.name).toList().join(' و ')} را پذیرفتید',
                                                    );
                                                  }
                                                },
                                                additionItemsTitle: '',
                                                iconAdd: Icons.check_rounded,
                                              )
                                          else
                                            Text(
                                              'هیچ سفارشی برای ارسال موجود نیست',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            )
                                        ],
                                      ),
                                    ],
                                    buttonOnPressed: () {},
                                    showSubmitButton: false,
                                  );
                                },
                              ),
                      
                        SizedBox(height: 20),
                      ],
                    ),
            );
          },
        );
      },
    );
  }
}
