import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/provider/provider_classes/MyQueriesProvider.dart';
import '../../../Utils/helper.dart';
import 'TicketRepliesScreen.dart';

class MyQueriesScreen extends StatefulWidget {
  const MyQueriesScreen({super.key});

  @override
  State<MyQueriesScreen> createState() => _MyQueriesScreenState();
}

class _MyQueriesScreenState extends State<MyQueriesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MyQueriesProvider>(context, listen: false)
          .fetchMyTickets(context);
    });
  }

  /// ===========================
  ///   NEW TICKET BOTTOM SHEET
  /// ===========================
  void openNewTicketSheet() {
    final provider = Provider.of<MyQueriesProvider>(context, listen: false);

    TextEditingController subjectCtrl = TextEditingController();
    TextEditingController descCtrl = TextEditingController();

    String selectedCategory = "GENERAL";
    List<File> selectedImages = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: MyColors.whiteText,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Drag handle
                  Container(
                    width: 80,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  Text("Create Ticket",
                      style: semiBoldTextStyle(
                          fontSize: 18, color: MyColors.blackColor)),
                  const SizedBox(height: 20),

                  /// CATEGORY
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      labelText: "Select Category",
                      labelStyle:
                      mediumTextStyle(fontSize: 13, color: MyColors.hintTextColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: "GENERAL", child: Text("GENERAL")),
                      DropdownMenuItem(
                          value: "TECHNICAL_ISSUE",
                          child: Text("TECHNICAL ISSUE")),
                      DropdownMenuItem(value: "ACCOUNT", child: Text("ACCOUNT")),
                      DropdownMenuItem(
                          value: "SUBSCRIPTION", child: Text("SUBSCRIPTION")),
                      DropdownMenuItem(value: "PAYMENT", child: Text("PAYMENT")),
                      DropdownMenuItem(value: "CONTENT", child: Text("CONTENT")),
                      DropdownMenuItem(
                          value: "FEATURE_REQUEST",
                          child: Text("FEATURE REQUEST")),
                      DropdownMenuItem(value: "FEEDBACK", child: Text("FEEDBACK")),
                      DropdownMenuItem(value: "OTHER", child: Text("OTHER")),
                    ],
                    onChanged: (val) => selectedCategory = val!,
                  ),

                  const SizedBox(height: 15),

                  /// SUBJECT FIELD
                  TextField(
                    controller: subjectCtrl,
                    style: regularTextStyle(
                        fontSize: 14, color: MyColors.blackColor),
                    decoration: InputDecoration(
                      hintText: "Enter Subject",
                      hintStyle: mediumTextStyle(
                          fontSize: 13, color: MyColors.hintTextColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// DESCRIPTION FIELD
                  TextField(
                    controller: descCtrl,
                    maxLines: 4,
                    style: regularTextStyle(
                        fontSize: 14, color: MyColors.blackColor),
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: mediumTextStyle(
                          fontSize: 13, color: MyColors.hintTextColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// ADD ATTACHMENTS BUTTON
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () async {
                        final img = await Helper.pickImage();
                        if (img != null) {
                          setState(() => selectedImages.add(img));
                        }
                      },
                      icon: const Icon(Icons.attach_file),
                      label: const Text("Add Attachments"),
                    ),
                  ),

                  /// SELECTED IMAGES PREVIEW
                  if (selectedImages.isNotEmpty)
                    SizedBox(
                      height: 85,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedImages.length,
                        itemBuilder: (ctx, i) {
                          return Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: FileImage(selectedImages[i]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              /// Remove Button
                              Positioned(
                                right: 4,
                                top: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() => selectedImages.removeAt(i));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                    padding: const EdgeInsets.all(3),
                                    child: const Icon(Icons.close,
                                        color: Colors.white, size: 14),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 20),

                  /// SUBMIT + CANCEL
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.appTheme,
                          ),
                          onPressed: () async {
                            if (subjectCtrl.text.isEmpty ||
                                descCtrl.text.isEmpty) {
                              Helper.customToast("Please fill all the details 😊");
                              return;
                            }

                            final success = await provider.createTicket(
                              context,
                              category: selectedCategory,
                              subject: subjectCtrl.text,
                              description: descCtrl.text,
                              attachments: selectedImages,
                            );

                            if (success) Navigator.pop(context);
                          },
                          child: Text(
                            "Submit",
                            style: semiBoldTextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// ======================
  ///   MAIN UI
  /// ======================
  @override
  Widget build(BuildContext context) {
    return Consumer<MyQueriesProvider>(
      builder: (context, provider, child) {
        return CommonScaffold(
          title: "My Queries",
          centerTitle: true,
          backgroundColor: MyColors.bgBackgroundColor,

          floatingActionButton: FloatingActionButton(
            backgroundColor: MyColors.appTheme,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            onPressed: openNewTicketSheet,
            child: const Icon(Icons.add, color: Colors.white),
          ),

          /// List of Tickets
          body: provider.queriesModel?.data == null ||
              provider.queriesModel!.data!.isEmpty
              ? Center(
            child: Text(
              "No tickets found",
              style: mediumTextStyle(
                  fontSize: 14, color: MyColors.color7C7C7C),
            ),
          )
              : ListView.separated(
            padding: const EdgeInsets.only(top: 25),
            itemCount: provider.queriesModel!.data!.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = provider.queriesModel!.data![index];

              return GestureDetector(
                onTap: (){

                  CustomNavigator.pushNavigate(context, TicketRepliesScreen(subject: item.subject.toString(),ticketId: item.id.toString(),),);
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: MyColors.whiteText,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// SUBJECT
                      Text(
                        item.subject ?? "",
                        style: semiBoldTextStyle(
                          fontSize: 15,
                          color: MyColors.blackColor,
                        ),
                      ),
                      const SizedBox(height: 6),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// STATUS
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: (item.status == "Resolved"
                                  ? MyColors.color2DB552
                                  : MyColors.colorD77937)
                                  .withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item.status ?? "",
                              style: mediumTextStyle(
                                fontSize: 12,
                                color: item.status == "Resolved"
                                    ? MyColors.color2DB552
                                    : MyColors.colorD77937,
                              ),
                            ),
                          ),

                          /// DATE
                          Text(
                            item.createdAt != null
                                ? "${item.createdAt!.day}-${item.createdAt!.month}-${item.createdAt!.year}"
                                : "",
                            style: mediumTextStyle(
                              fontSize: 11,
                              color: MyColors.color969696,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
