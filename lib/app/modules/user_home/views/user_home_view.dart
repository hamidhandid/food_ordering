import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/app/common_widgets/custom_form.dart';
import 'package:alo_self/app/model/user_profile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_home_controller.dart';

class UserHomeView extends GetView<UserHomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'User Home',
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
                        'Parham, the Best',
                        style: Get.textTheme.headline1,
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          color: Colors.green[900],
                          onPressed: () => _showEditProfileModal(
                            context,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Add Your Profile',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
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

  void _showEditProfileModal(BuildContext context, {UserProfile? userProfile}) {
    if (userProfile != null) {
      controller.firstNameController.value.text = userProfile.first_name;
      controller.lastNameController.value.text = userProfile.last_name;
      controller.areaController.value.text = userProfile.area;
      controller.addressController.value.text = userProfile.address;
    }
    CustomForm.show(
      context,
      formTitle: 'User Profile',
      textFields: controller.editProfileControllers
          .map((e) => TextField(
                controller: e.second.value,
                decoration: InputDecoration(
                  labelText: e.first,
                ),
              ))
          .toList(),
      buttonOnPressed: () async {
        await controller.editProfile();
        Get.back();
      },
      buttonText: 'Edit Profile',
    );
  }
}
