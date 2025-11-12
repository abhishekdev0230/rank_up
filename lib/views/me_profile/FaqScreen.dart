import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  bool isLoading = true;
  List<dynamic> faqs = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchFaqs();
    });
  }

  Future<void> _fetchFaqs() async {
    CommonLoaderApi.show(context);
    try {
      final headers = await ApiHeaders.withStoredToken();

      final response = await ApiMethods().getMethodTwo(
        method: ApiUrls.faq,
        body: {},
        header: headers,
      );

      CommonLoaderApi.hide(context);

      if (response.isNotEmpty) {
        final jsonData = jsonDecode(response);
        if (jsonData['status'] == true && jsonData['data'] != null) {
          setState(() {
            faqs = jsonData['data'];
          });
        } else {
          Helper.customToast(jsonData['message'] ?? "Failed to load FAQs");
        }
      } else {
        Helper.customToast("Empty response from server");
      }
    } catch (e) {
      CommonLoaderApi.hide(context);
      Helper.customToast("Error loading FAQs: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "FAQ",
      body: faqs.isEmpty
          ? const Center(
              child: Text(
                "No FAQs available",
                style: TextStyle(color: Colors.black54),
              ),
            )
          : ListView.separated(
              itemCount: faqs.length,
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.black12, thickness: 0.5),
              itemBuilder: (context, index) {
                final item = faqs[index];
                return ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  title: Text(
                    item["question"] ?? "",
                    style: semiBoldTextStyle(
                      fontSize: 14,
                      color: MyColors.blackColor,
                    ),
                  ),
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Text(
                        item["answer"] ?? "",
                        textAlign: TextAlign.start,
                        style: mediumTextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],

                );
              },
            ),
    );
  }
}
