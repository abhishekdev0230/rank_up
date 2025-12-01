import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/custom_classes/CommonProfileImage.dart';
import 'package:rank_up/custom_classes/my_textfield.dart';
import 'package:rank_up/custom_classes/validators.dart';
import 'package:rank_up/provider/provider_classes/ProfileSetupProvider.dart';
import 'package:rank_up/custom_classes/app_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController fullNameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    final profileProvider =
    Provider.of<ProfileSetupProvider>(context, listen: false);

    // Prefill data from provider
    fullNameController = TextEditingController(text: profileProvider.fullName);
    emailController = TextEditingController(text: profileProvider.email);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileSetupProvider>(context);

    return CommonScaffold(
      title: "Edit Profile",
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSized15,
              Center(
                child: Stack(
                  children: [
                    CommonProfileImage(
                      radius: 60,
                      localFile: profileProvider.profileImage != null
                          ? File(profileProvider.profileImage!.path)
                          : null,
                      imageUrl: profileProvider.profilePictureGetApi,
                      placeholderAsset: IconsPath.defultImage,
                    ),
                    Positioned(
                      right: 4,
                      bottom: 4,
                      child: GestureDetector(
                        onTap: () => _showImagePickerOptions(context, profileProvider),
                        child: SvgPicture.asset(IconsPath.editProfile),
                      ),
                    ),
                  ],
                ),
              ),

              hSized25,

              /// ✅ Full Name
              CommonTextField(
                controller: fullNameController,
                label: "Full Name",
                hintText: "Enter your name",
                validator: (val) =>
                    CommonValidators.validateName(val, fieldName: "Full Name"),
              ),
              hSized10,

              /// ✅ Email
              CommonTextField(
                controller: emailController,
                readOnly: true,
                label: "Email",
                hintText: "Enter your email",
                validator: (val) => CommonValidators.validateEmail(val),
              ),
              hSized10,

              /// ✅ Class Dropdown
              customDropdown(
                label: "Class",
                hint: "Select your class",
                value: profileProvider.selectedClass,
                items: profileProvider.classList,
                onChanged: profileProvider.setSelectedClass,
              ),
              hSized10,

              /// ✅ State Dropdown
              customDropdown(
                label: "State",
                hint: "Select your state",
                value: profileProvider.selectedState,
                items: profileProvider.stateList,
                onChanged: profileProvider.setSelectedState,
              ),
              hSized10,

              /// ✅ City Dropdown
              customDropdown(
                label: "City",
                hint: "Select your city",
                value: profileProvider.selectedCity,
                items: profileProvider.cityList,
                onChanged: profileProvider.setSelectedCity,
              ),
              hSized25,

              /// ✅ Update Button
              CommonButton(
                text: "Save Changes",
                borderRadius: 30,
                textColor: MyColors.whiteText,
                backgroundColor: MyColors.appTheme,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    profileProvider
                      ..setFullName(fullNameController.text.trim())
                      ..setEmail(emailController.text.trim());

                    await profileProvider.updateProfile(context);
                  }
                },

              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Image Picker Modal
  void _showImagePickerOptions(
      BuildContext context,
      ProfileSetupProvider provider,
      ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SizedBox(
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            hSized20,
            Text(
              "Change Profile Picture",
              style: semiBoldTextStyle(
                fontSize: 18,
                color: MyColors.blackColor,
              ),
              textAlign: TextAlign.center,
            ),
            hSized20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _pickerOption(
                  icon: Icons.camera_alt,
                  label: "Camera",
                  onTap: () async {
                    await provider.pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
                _pickerOption(
                  icon: Icons.photo_library,
                  label: "Gallery",
                  onTap: () async {
                    await provider.pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 40, color: MyColors.appTheme),
          onPressed: onTap,
        ),
        Text(label),
      ],
    );
  }
}
