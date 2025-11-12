import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';

class StaticPageScreen extends StatefulWidget {
  final String title;
  final String slug;

  const StaticPageScreen({super.key, required this.title, required this.slug});

  @override
  State<StaticPageScreen> createState() => _StaticPageScreenState();
}

class _StaticPageScreenState extends State<StaticPageScreen> {
  String pageContent = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchPageContent();
    });
  }

  Future<void> _fetchPageContent() async {
    CommonLoaderApi.show(context);
    try {
      final headers = await ApiHeaders.withStoredToken();
      final url = ApiUrls.staticPageBySlug.replaceFirst(':slug', widget.slug);

      final response = await ApiMethods().getMethodTwo(
        method: url,
        body: {},
        header: headers,
      );

      CommonLoaderApi.hide(context);

      if (response.isNotEmpty) {
        final jsonData = jsonDecode(response);
        if (jsonData['status'] == true && jsonData['data'] != null) {
          setState(() {
            pageContent = jsonData['data']['content'] ?? "No content found.";
          });
        } else {
          Helper.customToast(jsonData['message'] ?? "Failed to load content");
        }
      } else {
        Helper.customToast("Empty response from server");
      }
    } catch (e) {
      CommonLoaderApi.hide(context);
      Helper.customToast("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: widget.title,
      body: SingleChildScrollView(
        child: Html(
          data: pageContent,
        ),
      ),
    );
  }
}
