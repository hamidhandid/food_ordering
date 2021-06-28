import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/app/common_widgets/custom_button.dart';
import 'package:alo_self/app/common_widgets/custom_card.dart';
import 'package:alo_self/app/common_widgets/custom_item_list.dart';
import 'package:alo_self/app/common_widgets/custom_pair.dart';
import 'package:alo_self/app/common_widgets/custom_time_line.dart';
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
    return Scaffold(
      appBar: CustomAppBar(
        title: 'سفارش‌ها',
      ),
      body: CustomItemList(
        items: [
          NormalCard(
            topStart: 'سفارش قورمه سبزی و قیمه',
            bottomStart: 'زمان رسیدن: ۱۳:۳۰',
            additionItemsTitle: 'غذاها',
            additionalRowPairs: [
              CustomPair(null, CustomPair('قورمه سبزی', '۳۰,۰۰۰ تومان')),
              CustomPair(null, CustomPair('قیمه', '۲۰,۰۰۰ تومان')),
            ],
            additionalWidgets: [
              SizedBox(height: 10),
              Text(
                'ارسال کننده: عیسی عباسی',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'مقصد: دانشکده کامپیوتر',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'هزینه ارسال: ۱۰,۰۰۰ تومان',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'مبلغ کل فاکتور: ۶۰,۰۰۰ تومان',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                buttonOnPressed: () {
                  Get.to(() => CustomTimeLine(
                        title: 'وضعیت سفارش قورمه سبزی و قیمه',
                      ));
                },
                buttonText: 'مشاهده وضعیت سفارش',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
