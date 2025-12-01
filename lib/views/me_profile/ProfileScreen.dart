import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/CommonProfileImage.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/provider/provider_classes/ProfileSetupProvider.dart';
import 'package:rank_up/views/me_profile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();

    /// ✅ Call provider method when screen opens
    Future.microtask(() {
      final profileProvider =
      Provider.of<ProfileSetupProvider>(context, listen: false);
      profileProvider.getProfileApi(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileSetupProvider>(
      builder: (context, profileProvider, _) {
        return CommonScaffold(
          title: "My Profile",
          body: SingleChildScrollView(
            child: Column(
              children: [
                /// ✅ Profile Image
                hSized15,
                Center(
                  child: Stack(
                    children: [
                      CommonProfileImage(
                        imageUrl: profileProvider.profilePictureGetApi,
                        localFile: profileProvider.profileImage != null
                            ? File(profileProvider.profileImage!.path)
                            : null,
                        radius: 60,
                        placeholderAsset: IconsPath.defultImage,
                      ),

                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: GestureDetector(
                          onTap: (){
                            CustomNavigator.pushNavigate(context, EditProfileScreen());
                          },
                          child: SvgPicture.asset(IconsPath.editProfile),
                        ),
                      ),
                    ],
                  ),
                ),
                hSized20,
                /// ✅ User Info
                Text(
                  profileProvider.fullName.isNotEmpty
                      ? profileProvider.fullName
                      : "----",
                  style: semiBoldTextStyle(
                    fontSize: 22,
                    color: MyColors.blackColor,
                  ),
                ),
                Text(
                  profileProvider.email.isNotEmpty
                      ? profileProvider.email
                      : "-----",
                  style: mediumTextStyle(
                      fontSize: 15, color: MyColors.color949494),
                ),

                hSized25,

                /// ✅ Info Card
                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    color: MyColors.whiteText,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _infoRow("Class", profileProvider.selectedClass ?? "—"),
                      _infoRow("State", profileProvider.selectedState ?? "—"),
                      _infoRow("City", profileProvider.selectedCity ?? "—"),
                     if(profileProvider.phoneNumber?.isNotEmpty ?? false) _infoRow("Phone Number", profileProvider.phoneNumber ?? "—"),
                    ],
                  ),
                ),

                hSized30,

                /// ✅ Buttons
                _actionButton(
                  title: "Edit Profile",
                  icon: Icons.edit_outlined,
                  color: MyColors.appTheme,
                  onTap: () {
                    CustomNavigator.pushNavigate(context, EditProfileScreen());
                    // TODO: Navigate to edit profile
                  },
                ),
                hSized10,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style:
              mediumTextStyle(fontSize: 15, color: MyColors.color949494),
            ),
          ),
          Text(
            value,
            style: semiBoldTextStyle(fontSize: 15, color: MyColors.blackColor),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: MyColors.whiteText,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Icon(icon, color: color),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: mediumTextStyle(fontSize: 16, color: color),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.black54,
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }

  void _showImagePicker(BuildContext context, ProfileSetupProvider provider) {
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
