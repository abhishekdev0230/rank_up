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

  /// 🔥 HTML decode function
  String decodeHtmlString(String html) {
    return html
        .replaceAll("&lt;", "<")
        .replaceAll("&gt;", ">")
        .replaceAll("&amp;", "&")
        .replaceAll("&quot;", "\"")
        .replaceAll("&#039;", "'");
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
          final rawContent = jsonData['data']['content'] ?? "";

          setState(() {
            pageContent = decodeHtmlString(rawContent);
          });
        } else {
          /// ❗ Error message received → UI में दिखाओ
          final msg = jsonData['message'] ?? "Failed to load content";

          setState(() {
            pageContent = "<p><b>$msg</b></p>";
          });

          Helper.customToast(msg);
        }
      } else {
        /// ❗ Empty response → UI में भी message
        setState(() {
          pageContent = "<p><b>Empty response from server</b></p>";
        });

        Helper.customToast("Empty response from server");
      }
    } catch (e) {
      CommonLoaderApi.hide(context);

      setState(() {
        pageContent = "<p><b>Error: $e</b></p>";
      });

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
