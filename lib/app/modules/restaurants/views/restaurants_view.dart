import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/app/common_widgets/custom_card.dart';
import 'package:alo_self/app/common_widgets/custom_form.dart';
import 'package:alo_self/app/common_widgets/custom_item_list.dart';
import 'package:alo_self/app/common_widgets/custom_screen.dart';
import 'package:alo_self/app/common_widgets/custom_snackbar.dart';
import 'package:alo_self/app/common_widgets/custom_text_field.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:alo_self/app/model/restaurant.dart';
import 'package:alo_self/app/common_widgets/custom_pair.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/restaurants_controller.dart';

class RestaurantsView extends StatefulWidget {
  @override
  _RestaurantsViewState createState() => _RestaurantsViewState();
}

class _RestaurantsViewState extends State<RestaurantsView> {
  bool _orderable = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestaurantsController());
    return Scaffold(
      appBar: CustomAppBar(
        title: 'رستوران‌ها',
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: controller.getRestaurants(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text('شما هیچ رستورانی ندارید'),
            );
          }
          return CustomScreen(
            child: CustomItemList(
              items: snapshot.data!
                  .map(
                    (e) => NormalCard(
                      editCallback: () async {
                        controller.nameController.value.text = e.name;
                        controller.areaController.value.text = e.area;
                        // controller.addressController.value.text = e.address;
                        controller.serviceAreasController.value.text = e.service_areas.first;
                        controller.workHourController.value.text = e.work_hour;
                        controller.deliverCostController.value.text = e.deliver_cost.toString();
                        CustomForm.show(
                          context,
                          formTitle: 'ویرایش رستوران',
                          textFields: controller.editRestaurantControllers
                              .map(
                                (el) => CustomTextField(
                                  controller: el.second.value,
                                  labelText: el.first,
                                ),
                              )
                              .toList(),
                          buttonText: 'ویرایش',
                          buttonOnPressed: () async {
                            await controller.editRestaurant(e);
                            Get.back();
                            setState(() {});
                          },
                        );
                      },
                      addCallback: () {
                        CustomForm.show(context,
                            formTitle: 'اضافه کردن غذا',
                            textFields: controller.addFoodControllers
                                .map(
                                  (e) => CustomTextField(
                                    controller: e.second.value,
                                    labelText: e.first,
                                  ),
                                )
                                .toList(), buttonOnPressed: () async {
                          await controller.addFoodToRestaurant(
                            e,
                            Food(
                              name: controller.foodNameController.value.text,
                              cost: controller.foodCostController.value.numberValue.toInt(),
                            ),
                          );
                          Get.back();
                          setState(() {});
                        }, buttonText: 'اضافه‌کردن');
                      },
                      topStart: 'نام: ${e.name}',
                      bottomStart: 'منطقه: ${e.area}',
                      bottomEnd: 'هزینه ثابت ارسال غذا: ${e.deliver_cost} تومان',
                      additionalRowPairs: e.foods != null && e.foods!.isNotEmpty
                          ? [
                              if (e.foods != null && e.foods!.isNotEmpty)
                                for (final food in e.foods!)
                                  CustomPair(
                                    () {
                                      setState(() {
                                        _orderable = food.orderable;
                                      });
                                      controller.foodCostController.value.text = food.cost.toString();
                                      controller.foodNameController.value.text = food.name;
                                      CustomForm.show(
                                        context,
                                        formTitle: 'ویرایش غذا',
                                        buttonText: 'ویرایش',
                                        deleteCallback: () {
                                          CustomForm.show(
                                            context,
                                            formTitle: 'غذای ${food.name} حذف شود؟',
                                            textFields: [
                                              SizedBox(height: 20),
                                              MaterialButton(
                                                child: Text(
                                                  'حذف غذا',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                color: Colors.red[400],
                                                onPressed: () async {
                                                  await controller.removeFood(e, food);
                                                  Get.back();
                                                  Get.back();
                                                  CustomSnackBar.show(
                                                    'موفق',
                                                    '${food.name} حذف شد',
                                                  );
                                                  setState(() {});
                                                },
                                              ),
                                              MaterialButton(
                                                color: Colors.green[500],
                                                child: Text(
                                                  'لغو',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              )
                                            ],
                                            buttonOnPressed: () {},
                                            showSubmitButton: false,
                                          );
                                        },
                                        textFields: [
                                          ...controller.addFoodControllers
                                              .map((elem) => CustomTextField(
                                                    controller: elem.second.value,
                                                    labelText: elem.first,
                                                  ))
                                              .toList(),
                                          StatefulBuilder(
                                            builder:
                                                (BuildContext context, void Function(void Function()) customSetState) {
                                              return Flexible(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'قابل سفارش: ',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
                                                    Switch.adaptive(
                                                      value: _orderable,
                                                      onChanged: (value) {
                                                        customSetState(() {
                                                          _orderable = !_orderable;
                                                          controller.foodIsOrderable.value = _orderable;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                        buttonOnPressed: () async {
                                          await controller.editFood(
                                            e,
                                            food,
                                            orderable: controller.foodIsOrderable.value,
                                          );
                                          Get.back();
                                          CustomSnackBar.show(
                                            'موفق',
                                            '${food.name} ویرایش شد',
                                          );
                                          setState(() {});
                                        },
                                      );
                                    },
                                    CustomPair('نام: ${food.name}', 'موجودی: ${food.number}'),
                                  )
                            ]
                          : null,
                      additionItemsTitle: 'غذاها',
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
