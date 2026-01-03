import 'package:flutter/material.dart';
import 'package:ui_web/features/profile/user_repository.dart';

class EditProfileController extends ChangeNotifier {
  final UserRepository _repo;

  EditProfileController(this._repo);

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isSaving = false;

  Future<void> loadUserData() async {
    final user = _repo.currentUser;
    nameController.text = user?.displayName ?? "";

    final phone = await _repo.getPhone();
    phoneController.text = phone ?? "";

    notifyListeners();
  }

  Future<bool> saveProfile() async {
    if (!formKey.currentState!.validate()) return false;

    isSaving = true;
    notifyListeners();

    try {
      await _repo.updateProfile(
        nameController.text.trim(),
        phoneController.text.trim(),
      );
      return true;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
