import 'package:alo_self/app/common_widgets/custom_item_list.dart';
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
      appBar: AppBar(
        title: Text('OrdersView'),
        centerTitle: true,
      ),
      // body: FutureBuilder(
      //   future: null,
      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {},
      //   // child: CustomItemList(
      //   //   items: widget.resultFoods!
      //   //       .where((e) => e.orderable)
      //   //       .map(
      //   //         (e) => CustomCard(
      //   //           details: [
      //   //             CustomPair('Name: ${e.name}', 'Price: ${e.cost}'),
      //   //           ],
      //   //           addCallback: () {
      //   //             controller.foodsToOrder.add(e);
      //   //             setState(() {});
      //   //           },
      //   //           iconAdd: Icons.add,
      //   //         ),
      //   //       )
      //   //       .toList(),
      //   ),
      // ),
    );
  }
}
