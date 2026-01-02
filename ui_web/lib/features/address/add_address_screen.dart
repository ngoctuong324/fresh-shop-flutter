import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_web/common/constants.dart';
import 'add_address_controller.dart';
import 'widgets/address_form.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final controller = AddAddressController();
        controller.loadProvinces();
        return controller;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Thêm Địa Chỉ Giao Hàng",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: textGreen,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: AddressForm(),
        ),
      ),
    );
  }
}
