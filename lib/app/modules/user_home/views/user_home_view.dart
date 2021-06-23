import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/app/common_widgets/custom_form.dart';
import 'package:alo_self/app/model/user_profile.dart';
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
        title: 'User Home',
        onTap: () async {
          await controller.logout();
        },
        showLogoutAction: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StatefulBuilder(
              builder: (context, customSetState) => Container(
                padding: EdgeInsets.all(25).copyWith(bottom: 0),
                child: Column(
                  children: [
                    Text(
                      'Parham, the Best',
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
                                      ? 'Name: Not Specified'
                                      : 'Name: ${snapshot.data!.first_name} ${snapshot.data!.last_name}',
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
                                  'Area: ${snapshot.data!.area.isEmpty ? "Not Specified" : "${snapshot.data!.area}"}',
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
                              'Credit: ${snapshot.data!.credit} tomans',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: Colors.green[800]),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        color: Colors.green[900],
                        onPressed: () => _showEditProfileModal(
                          context,
                          userProfile: userProfile,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Edit Your Profile',
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
        setState(() {});
      },
      buttonText: 'Edit Profile',
    );
  }
}
