import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/features/profile/user_repository.dart';

import 'edit_profile_controller.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/name_field.dart';
import 'widgets/phone_field.dart';
import 'widgets/save_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileController(UserRepository())..loadUserData(),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatelessWidget {
  const _EditProfileView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EditProfileController>();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Chỉnh sửa hồ sơ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: textGreen,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const ProfileAvatar(),
              const SizedBox(height: 30),
              NameField(controller: controller.nameController),
              const SizedBox(height: 20),
              PhoneField(controller: controller.phoneController),
              const SizedBox(height: 30),
              SaveButton(
                isLoading: controller.isSaving,
                onPressed: () async {
                  final success = await controller.saveProfile();
                  if (success && context.mounted) {
                    Navigator.pop(context, true);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
