import 'package:alo_self/app/api/order/order_api.dart';
import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/app/common_widgets/custom_button.dart';
import 'package:alo_self/app/common_widgets/custom_card.dart';
import 'package:alo_self/app/common_widgets/custom_item_list.dart';
import 'package:alo_self/app/common_widgets/custom_money_formatter.dart';
import 'package:alo_self/app/common_widgets/custom_pair.dart';
import 'package:alo_self/app/common_widgets/custom_time_line.dart';
import 'package:alo_self/app/model/orders.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends StatefulWidget {
  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Orders?>(
      future: OrderApi().getCustomerOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // final String title = 'سفارش' + [snapshot.data.orders]
        return Scaffold(
          appBar: CustomAppBar(
            title: 'سفارش‌ها',
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
          body: snapshot.data!.orders!.isNotEmpty
              ? CustomItemList(
                  items: [
                    for (final order in snapshot.data!.orders!)
                      NormalCard(
                        topStart: 'سفارش ${order.foods.map((e) => e.name).toList().join(' و ')}',
                        bottomStart:
                            'زمان سفارش: ${order.time!.substring(order.time!.indexOf('2021') + 5, order.time!.indexOf('2021') + 10)}',
                        bottomEnd: order.status,
                        additionItemsTitle: 'غذاها',
                        additionalRowPairs: [
                          for (final food in order.foods)
                            CustomPair(null, CustomPair(food.name, CustomMoneyFormatter.formatMoney(food.cost))),
                          // CustomPair(null, CustomPair('قیمه', '۲۰,۰۰۰ تومان')),
                        ],
                        additionalWidgets: [
                          SizedBox(height: 10),
                          Text(
                            'ارسال کننده: ${order.sender?.first_name ?? 'ندارد'} ${order.sender?.last_name ?? ''}',
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
                            'هزینه ارسال: ${CustomMoneyFormatter.formatMoney(order.restaurant!.deliver_cost)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            'مبلغ کل فاکتور: ${CustomMoneyFormatter.formatMoney(order.foods.fold(0, (int previousValue, el) => previousValue + el.cost))}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30),
                          CustomButton(
                            buttonOnPressed: () {
                              Get.to(() => CustomTimeLine(
                                    title: 'وضعیت سفارش ${order.foods.map((e) => e.name).toList().join(' و ')}',
                                    index: _convertStatusToIndex(order.status),
                                  ));
                            },
                            buttonText: 'مشاهده وضعیت سفارش',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    SizedBox(height: 20),
                  ],
                )
              : Center(
                  child: Text(
                    'هیچ سفارشی ندارید',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
        );
      },
    );
  }

  int _convertStatusToIndex(String? status) {
    if (status == 'در حال ارسال') {
      return 2;
    } else if (status == 'تحویل داده شده') {
      return 3;
    } else if (status == 'در حال تحویل به ارسال کننده') {
      return 1;
    }
    return 0;
  }
}
