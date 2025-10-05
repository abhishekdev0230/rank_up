import 'package:flutter/material.dart';
import 'language_en.dart';
import '../../Utils/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages>{

  const AppLocalizationsDelegate();
  // , 'ar'
  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      // case 'ar':
      //   return LanguageAr();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<Languages> old) => false;
  
}