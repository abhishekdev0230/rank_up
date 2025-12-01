import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/custom_classes/my_textfield.dart';
import 'package:rank_up/custom_classes/validators.dart';
import 'package:rank_up/provider/provider_classes/ProfileSetupProvider.dart';



class ProfileSetupContainer extends StatefulWidget {
  final dynamic lang;
  const ProfileSetupContainer({super.key, required this.lang});

  @override
  State<ProfileSetupContainer> createState() => _ProfileSetupContainerState();
}

class _ProfileSetupContainerState extends State<ProfileSetupContainer> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    final profileProvider = Provider.of<ProfileSetupProvider>(
      context,
      listen: false,
    );
    fullNameController = TextEditingController(text: profileProvider.fullName);
    emailController = TextEditingController(text: profileProvider.email);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.lang;
    final profileProvider = Provider.of<ProfileSetupProvider>(context);

    return Container(
      height: context.hp(0.65),
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(
        horizontal: context.wp(0.05),
        vertical: context.hp(0.03),
      ),
      decoration: const BoxDecoration(
        color: MyColors.whiteText,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.completeProfileTitle,
                style: semiBoldTextStyle(
                  fontSize: 26,
                  color: MyColors.blackColor,
                ),
              ),
              hSized8,
              Text(
                lang.completeProfileSubtitle,
                style: mediumTextStyle(
                  fontSize: 18,
                  color: MyColors.color949494,
                ),
              ),
              hSized20,
              /// ✅ Profile Image Section
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: MyColors.color949494.withOpacity(0.2),
                      backgroundImage: profileProvider.profileImage != null
                          ? FileImage(File(profileProvider.profileImage!.path))
                          : AssetImage(IconsPath.defultImage) as ImageProvider,
                    ),
                    Positioned(
                      right: 7,
                      bottom: 7,
                      child: GestureDetector(
                        onTap: () =>
                            _showImagePickerOptions(context, profileProvider),
                        child: SvgPicture.asset(IconsPath.editProfile),
                      ),
                    ),
                  ],
                ),
              ),

              hSized30,

              /// ✅ Full Name
              CommonTextField(
                controller: fullNameController,
                label: lang.fullNameLabel,
                hintText: lang.fullNameHint,
                validator: (val) => CommonValidators.validateName(
                  val,
                  fieldName: lang.fullNameLabel,
                ),
              ),
              hSized10,

              /// ✅ Email
              CommonTextField(
                controller: emailController,
                label: lang.emailLabel,
                hintText: lang.emailHint,

                readOnly: profileProvider.loggedInViaGoogle,

                enableInteractiveSelection: !profileProvider.loggedInViaGoogle,

                validator: (val) => CommonValidators.validateEmail(val),
                colorBg: profileProvider.loggedInViaGoogle
                    ? MyColors.color949494.withOpacity(0.15)
                    : null,
              ),


              hSized10,

              /// ✅ Phone
              // CommonTextField(
              //   controller: phoneController,
              //   label: lang.phoneNumberLabel,
              //   hintText: lang.phoneNumberHint,
              //   maxLength: 10,
              //   keyboardType: TextInputType.phone,
              //   validator: (val) => CommonValidators.validateMobile(val, fieldName: lang.phoneNumberLabel),
              // ),
              // hSized10,

              /// ✅ Class Dropdown
              /// ✅ Class Dropdown
              customDropdown(
                label: lang.classLabel,
                hint: lang.classHint,
                value: profileProvider.selectedClass,
                items: profileProvider.classList,
                onChanged: profileProvider.setSelectedClass,
              ),
              hSized10,

              /// ✅ State Dropdown
              customDropdown(
                label: lang.stateLabel,
                hint: lang.stateHint,
                value: profileProvider.selectedState,
                items: profileProvider.stateList,
                onChanged: profileProvider.setSelectedState,
              ),
              hSized10,

              /// ✅ City Dropdown
              customDropdown(
                label: lang.cityLabel,
                hint: lang.cityHint,
                value: profileProvider.selectedCity,
                items: profileProvider.cityList,
                onChanged: profileProvider.setSelectedCity,
              ),
              hSized20,

              /// ✅ Continue Button
              CommonButton(
                text: lang.continueButton,
                borderRadius: 30,
                textColor: MyColors.whiteText,
                backgroundColor: MyColors.appTheme,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    profileProvider
                      ..setFullName(fullNameController.text.trim())
                      ..setEmail(emailController.text.trim());

                    final res = await ProfileSetupProvider.completeProfileApi(
                      context: context,
                      fullName: profileProvider.fullName,
                      email: profileProvider.email,
                      selectedClass: profileProvider.selectedClass ?? "",
                      selectedState: profileProvider.selectedState ?? "",
                      selectedCity: profileProvider.selectedCity ?? "",
                      profileImage: profileProvider.profileImage != null
                          ? File(profileProvider.profileImage!.path)
                          : null,
                    );


                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Image picker bottom sheet
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
              "Select Profile Picture",
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
