import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_web/data/model/location_model.dart';
import 'package:ui_web/data/model/shipping_address_model.dart';
import 'package:ui_web/data/services/location_service.dart';

class AddAddressController extends ChangeNotifier {
  final LocationService _locationService = LocationService();

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final detailController = TextEditingController();

  List<LocationModel> provinces = [];
  List<LocationModel> districts = [];
  List<LocationModel> wards = [];

  LocationModel? selectedProvince;
  LocationModel? selectedDistrict;
  LocationModel? selectedWard;

  Future<void> loadProvinces() async {
    provinces = await _locationService.getProvinces();
    notifyListeners();
  }

  Future<void> onProvinceChanged(LocationModel? value) async {
    selectedProvince = value;
    selectedDistrict = null;
    selectedWard = null;
    districts = [];
    wards = [];

    if (value != null) {
      districts = await _locationService.getDistricts(value.code);
    }
    notifyListeners();
  }

  Future<void> onDistrictChanged(LocationModel? value) async {
    selectedDistrict = value;
    selectedWard = null;
    wards = [];

    if (value != null) {
      wards = await _locationService.getWards(value.code);
    }
    notifyListeners();
  }

  void onWardChanged(LocationModel? value) {
    selectedWard = value;
    notifyListeners();
  }

  Future<void> saveAddress(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final address = ShippingAddressModel(
      fullName: nameController.text,
      phone: phoneController.text,
      province: selectedProvince!.name,
      district: selectedDistrict!.name,
      ward: selectedWard!.name,
      detail: detailController.text,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('addresses')
        .add(address.toMap());

    Navigator.pop(context);
  }
}
