import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// CommonTextField(hintText: "example@gmail.com",controller: emailController,)
//  TextEditingController emailController = TextEditingController();

import 'package:flutter/services.dart';
import 'package:rank_up/constraints/my_colors.dart';

import '../Utils/keyboardoverlay.dart';
import '../constraints/my_fonts_style.dart';

class CapitalizeWordsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    final words = text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return '';
          final firstLetter = word.substring(0, 1).toUpperCase();
          final rest = word.length > 1 ? word.substring(1).toLowerCase() : '';
          return '$firstLetter$rest';
        })
        .join(' ');

    return newValue.copyWith(
      text: words,
      selection: TextSelection.collapsed(offset: words.length),
    );
  }
}

///...........CommonButton..............
class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle? textStyle;
  final Widget? icon;

  const CommonButton({
    super.key,
    required this.text,
    this.onTap,
    this.height = 56.0,
    this.borderRadius = 15.0,
    this.backgroundColor = MyColors.appTheme,
    this.textColor = MyColors.color0E0F0F,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isDisabled ? 0.6 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          width: double.infinity,
          alignment: Alignment.center,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 5)],
              Text(
                text,
                style:
                    textStyle ??
                    semiBoldTextStyle(fontSize: 16.0, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///...........about me formatter................
class SentenceCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    if (text.isEmpty) return newValue;

    // Convert everything to lowercase first
    text = text.toLowerCase();

    // Capitalize first letter and after every ". "
    StringBuffer buffer = StringBuffer();
    bool capitalizeNext = true;

    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      if (capitalizeNext && RegExp(r'[a-z]').hasMatch(char)) {
        buffer.write(char.toUpperCase());
        capitalizeNext = false;
      } else {
        buffer.write(char);
      }

      if (char == '.') {
        capitalizeNext = true;
      }
    }

    return newValue.copyWith(
      text: buffer.toString(),
      selection: newValue.selection,
    );
  }
}

///.........CommonTextField...............
String capitalizeWords(String text) {
  if (text.isEmpty) return "";
  return text
      .split(" ")
      .map((word) {
        if (word.isEmpty) return "";
        return word[0].toUpperCase() + word.substring(1);
      })
      .join(" ");
}

void hideKeyboard(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();
}

class CommonTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final Color? colorBg;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final int maxLines;
  final int maxLength;
  final TextCapitalization textCapitalization;
  final Color? selectBorderColor;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextField({
    super.key,
    this.inputFormatters,
    required this.label,
    this.selectBorderColor,
    this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.colorBg,
    this.readOnly = false,
    this.enableInteractiveSelection = true,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.maxLines = 1,
    this.maxLength = 50,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    if (Platform.isIOS) {
      _focusNode.addListener(() {
        if (_focusNode.hasFocus) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            KeyboardOverlay.showOverlay(context);
          });
        } else {
          KeyboardOverlay.removeOverlay();
        }
      });
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      maxLength: widget.maxLength,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      focusNode: _focusNode,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      maxLines: widget.maxLines,
      textCapitalization: widget.textCapitalization,
      textInputAction: Platform.isIOS
          ? TextInputAction.done
          : TextInputAction.next,

      inputFormatters:
          widget.inputFormatters ??
          (widget.textCapitalization == TextCapitalization.words
              ? [CapitalizeWordsFormatter()]
              : null),

      decoration: InputDecoration(
        filled: widget.colorBg != null,
        fillColor: widget.colorBg,
        labelText: widget.label,
        labelStyle: boldTextStyle(fontSize: 13, color: MyColors.blackColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        hintStyle: mediumTextStyle(fontSize: 15, color: MyColors.color949494),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: widget.selectBorderColor ?? MyColors.color949494,
            width: 1.2,
          ),
          // borderSide: const BorderSide(color: MyColors.colorD5D5D5, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: MyColors.appTheme, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        counterText: "",
      ),
    );
  }
}

class AccountEditTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final int maxLines;

  const AccountEditTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.readOnly = false,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.maxLines = 1,
  });

  @override
  State<AccountEditTextField> createState() => _AccountEditTextFieldState();
}

class _AccountEditTextFieldState extends State<AccountEditTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (Platform.isIOS) {
        if (_focusNode.hasFocus) {
          KeyboardOverlay.showOverlay(context);
        } else {
          KeyboardOverlay.removeOverlay();
        }
      }
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
      textInputAction: Platform.isIOS
          ? TextInputAction.done
          : TextInputAction.next,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: boldTextStyle(fontSize: 17.0, color: MyColors.blackColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        hintStyle: regularTextStyle(fontSize: 15, color: MyColors.color7C7C7C),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: MyColors.color949494, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: MyColors.appTheme, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}

///............customDropdown

Widget customDropdown({
  required String label,
  required String hint,
  required String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return DropdownButtonFormField2<String>(
    value: value,
    isExpanded: true,

    decoration: InputDecoration(
      labelText: label,
      labelStyle: boldTextStyle(fontSize: 14, color: MyColors.blackColor),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: MyColors.color949494, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: MyColors.appTheme, width: 1.2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 1.2),
      ),
    ),

    hint: Text(
      hint,
      style: regularTextStyle(fontSize: 15, color: MyColors.color949494),
    ),

    iconStyleData: const IconStyleData(
      icon: Icon(Icons.keyboard_arrow_down_rounded),
      iconSize: 24,
    ),

    dropdownStyleData: DropdownStyleData(
      maxHeight: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
    ),

    menuItemStyleData: const MenuItemStyleData(
      height: 35,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    ),

    items: items.map((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: regularTextStyle(fontSize: 14, color: MyColors.blackColor),
        ),
      );
    }).toList(),

    onChanged: onChanged,
  );
}
