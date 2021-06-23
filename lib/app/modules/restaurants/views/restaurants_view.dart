import 'package:alo_self/app/common_widgets/custom_card.dart';
import 'package:alo_self/app/common_widgets/custom_form.dart';
import 'package:alo_self/app/common_widgets/custom_item_list.dart';
import 'package:alo_self/app/common_widgets/custom_screen.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:alo_self/app/model/restaurant.dart';
import 'package:alo_self/app/utils/custom_pair.dart';
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
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: controller.getRestaurants(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text('You Dont Have Any Restaurants!'),
            );
          }
          return CustomScreen(
            child: CustomItemList(
              items: snapshot.data!
                  .map(
                    (e) => CustomCard(
                      editCallback: () async {
                        controller.nameController.value.text = e.name;
                        controller.areaController.value.text = e.area;
                        controller.addressController.value.text = e.address;
                        controller.serviceAreasController.value.text = e.service_areas.first;
                        controller.workHourController.value.text = e.work_hour;
                        controller.deliverCostController.value.text = e.deliver_cost.toString();
                        CustomForm.show(
                          context,
                          formTitle: 'Edit Restaurant',
                          textFields: controller.editRestaurantControllers
                              .map(
                                (el) => TextField(
                                  controller: el.second.value,
                                  decoration: InputDecoration(
                                    labelText: el.first,
                                  ),
                                ),
                              )
                              .toList(),
                          buttonText: 'Edit',
                          buttonOnPressed: () async {
                            await controller.editRestaurant(e);
                            Get.back();
                            setState(() {});
                          },
                        );
                      },
                      addCallback: () {
                        CustomForm.show(
                          context,
                          formTitle: 'Add Food',
                          textFields: controller.addFoodControllers
                              .map(
                                (e) => TextField(
                                  controller: e.second.value,
                                  decoration: InputDecoration(labelText: e.first),
                                ),
                              )
                              .toList(),
                          buttonOnPressed: () async {
                            await controller.addFoodToRestaurant(
                              e,
                              Food(
                                name: controller.foodNameController.value.text,
                                cost: int.parse(controller.foodCostController.value.text),
                              ),
                            );
                            Get.back();
                            setState(() {});
                          },
                        );
                      },
                      details: [
                        CustomPair(e.name, e.work_hour),
                        CustomPair(e.area, e.address),
                        CustomPair('Delivery Cost: ${e.deliver_cost} tomans', ''),
                        if (e.foods != null && e.foods!.isNotEmpty) CustomPair('Foods:', ''),
                      ],
                      items: [
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
                                  formTitle: 'Edit Food',
                                  buttonText: 'Edit',
                                  textFields: [
                                    ...controller.addFoodControllers
                                        .map((elem) => TextField(
                                              controller: elem.second.value,
                                              decoration: InputDecoration(
                                                labelText: elem.first,
                                              ),
                                            ))
                                        .toList(),
                                    StatefulBuilder(
                                      builder: (BuildContext context, void Function(void Function()) customSetState) {
                                        return Switch.adaptive(
                                          value: _orderable,
                                          onChanged: (value) {
                                            customSetState(() {
                                              _orderable = !_orderable;
                                              controller.foodIsOrderable.value = _orderable;
                                            });
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        CustomForm.show(
                                          context,
                                          formTitle: 'Delete ${food.name} Food?',
                                          textFields: [
                                            MaterialButton(
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              color: Colors.red[400],
                                              onPressed: () async {
                                                await controller.removeFood(e, food);
                                                // Get.back();
                                                // Get.back();
                                                // setState(() {});
                                              },
                                            ),
                                            MaterialButton(
                                              color: Colors.green[500],
                                              child: Text(
                                                'Cancel',
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
                                      icon: Icon(Icons.delete_outline),
                                    ),
                                  ],
                                  buttonOnPressed: () async {
                                    await controller.editFood(
                                      e,
                                      food,
                                      orderable: controller.foodIsOrderable.value,
                                    );
                                    Get.back();
                                    // setState(() {});
                                  },
                                );
                              },
                              CustomPair('Food Name: ${food.name}', 'Food Price: ${food.cost} tomans'),
                            )
                      ],
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
