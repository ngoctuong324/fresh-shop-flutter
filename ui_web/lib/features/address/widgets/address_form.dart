import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_web/common/constants.dart';
import '../add_address_controller.dart';
import 'address_dropdown.dart';
import 'address_text_field.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AddAddressController>();

    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title("Thông tin người nhận"),

          AddressTextField(
            controller: controller.nameController,
            hint: "Tên người nhận",
            icon: Icons.person,
            validator: (v) =>
                v == null || v.isEmpty ? "Vui lòng nhập tên" : null,
          ),

          AddressTextField(
            controller: controller.phoneController,
            hint: "Số điện thoại",
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (v) =>
                v == null || v.isEmpty ? "Vui lòng nhập số điện thoại" : null,
          ),

          const SizedBox(height: 20),
          _title("Thông tin vị trí"),

          AddressDropdown(
            label: "Tỉnh / Thành phố",
            items: controller.provinces,
            value: controller.selectedProvince,
            onChanged: controller.onProvinceChanged,
            validator: (v) =>
                v == null ? "Vui lòng chọn tỉnh / thành phố" : null,
          ),

          AddressDropdown(
            label: "Quận / Huyện",
            items: controller.districts,
            value: controller.selectedDistrict,
            onChanged: controller.onDistrictChanged,
            validator: (v) => v == null ? "Vui lòng chọn quận / huyện" : null,
          ),

          AddressDropdown(
            label: "Phường / Xã",
            items: controller.wards,
            value: controller.selectedWard,
            onChanged: controller.onWardChanged,
            validator: (v) => v == null ? "Vui lòng chọn phường / xã" : null,
          ),

          const SizedBox(height: 20),
          _title("Địa chỉ cụ thể"),

          AddressTextField(
            controller: controller.detailController,
            hint: "Số nhà, tên đường...",
            icon: Icons.home,
            validator: (v) =>
                v == null || v.isEmpty ? "Vui lòng nhập địa chỉ" : null,
          ),

          const SizedBox(height: 40),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: textGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => controller.saveAddress(context),
              child: const Text(
                "XÁC NHẬN ĐỊA CHỈ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );
}
