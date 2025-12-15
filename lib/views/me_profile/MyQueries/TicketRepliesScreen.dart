import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // <-- For time formatting
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/provider/provider_classes/MyQueriesProvider.dart';

class TicketRepliesScreen extends StatefulWidget {
  final String ticketId;
  final String subject;

  const TicketRepliesScreen({
    super.key,
    required this.ticketId,
    required this.subject,
  });

  @override
  State<TicketRepliesScreen> createState() => _TicketRepliesScreenState();
}

class _TicketRepliesScreenState extends State<TicketRepliesScreen> {
  TextEditingController messageCtrl = TextEditingController();
  List<File> attachments = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MyQueriesProvider>().fetchTicketReplies(widget.ticketId);
    });
  }

  String formatTime(String rawTime) {
    try {
      DateTime dt = DateTime.parse(rawTime);
      return DateFormat('dd MMM yyyy, hh:mm a').format(dt);
    } catch (e) {
      return "Just now";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyQueriesProvider>(
      builder: (context, provider, child) {
        return CommonScaffold(
          title: widget.subject,
          body: Column(
            children: [
              /// ***********************
              /// CHAT LIST
              /// ***********************
              Expanded(
                child: provider.isRepliesLoading
                    ? Center(child: CircularProgressIndicator())
                    : provider.replies.isEmpty
                    ? Center(
                  child: Text(
                    "No replies yet.",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  itemCount: provider.replies.length,
                  itemBuilder: (context, index) {
                    final msg = provider.replies[index];
                    bool isMe = msg["sender"] == "user";

                    return Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6),
                          padding: const EdgeInsets.all(12),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.75),
                          decoration: BoxDecoration(
                            color: isMe
                                ? MyColors.appTheme
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(
                                  isMe ? 12 : 0),
                              bottomRight: Radius.circular(
                                  isMe ? 0 : 12),
                            ),
                          ),
                          child: Text(
                            msg["message"] ?? "",
                            style: TextStyle(
                                fontSize: 14,
                                color: isMe
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        /// TIMESTAMP
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            formatTime(msg["time"] ?? ""),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              /// ***********************
              /// ATTACHMENT PREVIEW
              /// ***********************
              if (attachments.isNotEmpty)
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: attachments.length,
                    separatorBuilder: (_, __) => SizedBox(width: 10),
                    itemBuilder: (context, i) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              attachments[i],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() => attachments.removeAt(i));
                              },
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.black54,
                                child: Icon(Icons.close,
                                    size: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

              /// ***********************
              /// WRITE MESSAGE BOX
              /// ***********************
              Container(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Row(
                  children: [
                    /// TEXTFIELD
                    Expanded(
                      child: TextField(
                        controller: messageCtrl,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    /// SEND BUTTON
                    GestureDetector(
                      onTap: () async {
                        if (messageCtrl.text.isEmpty &&
                            attachments.isEmpty) return;

                        await provider.sendReply(
                          ticketId: widget.ticketId,
                          message: messageCtrl.text,
                          attachments: attachments,
                        );

                        messageCtrl.clear();
                        setState(() => attachments.clear());
                      },
                      child: CircleAvatar(
                        radius: 23,
                        backgroundColor: MyColors.appTheme,
                        child: Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
