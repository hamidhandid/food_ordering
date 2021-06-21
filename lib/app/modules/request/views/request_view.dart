import 'package:alo_self/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/request_controller.dart';

class RequestView extends GetView<RequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.pageTitles_request.tr),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RequestView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
