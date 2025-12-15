import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/MyQueriesListModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/Utils/helper.dart';

class MyQueriesProvider extends ChangeNotifier {
  MyQueriesListModel? queriesModel;

  List<dynamic> replies = [];
  bool isRepliesLoading = false;

  /// =======================================================
  ///  FETCH MY TICKETS
  /// =======================================================
  Future<void> fetchMyTickets(BuildContext context) async {
    try {
      CommonLoaderApi.show(context);

      final res = await ApiMethods().getMethod(
        method: ApiUrls.supportMyTickets,
        body: {},
        header: await ApiHeaders.withStoredToken(),
      );

      CommonLoaderApi.hide(context);

      final data = myQueriesListModelFromJson(res);

      if (data.status == true) {
        queriesModel = data;
      } else {
        Helper.customToast(data.message ?? "Failed to load tickets");
      }

      notifyListeners();
    } catch (e) {
      CommonLoaderApi.hide(context);
      Helper.customToast("Something went wrong");
      notifyListeners();
    }
  }

  /// =======================================================
  ///  CREATE NEW TICKET
  /// =======================================================
  Future<bool> createTicket(
      BuildContext context, {
        required String category,
        required String subject,
        required String description,
        required List<File> attachments,
      }) async {
    try {
      CommonLoaderApi.show(context);

      final response = await ApiMethods().postMultipartMultipleFiles(
        method: ApiUrls.supportMyTicketsCreat,
        fields: {
          "category": category,
          "subject": subject,
          "description": description,
        },
        files: attachments,
        fileFieldName: "attachments",
        headers: await ApiHeaders.withStoredToken(),
      );

      CommonLoaderApi.hide(context);

      if (response?.status == true) {
        Helper.customToast("Ticket created successfully");

        /// Refresh list
        fetchMyTickets(context);
        return true;
      } else {
        Helper.customToast(response?.message ?? "Failed to create ticket");
        return false;
      }
    } catch (e) {
      CommonLoaderApi.hide(context);
      Helper.customToast("Something went wrong");
      return false;
    }
  }

  /// =======================================================
  ///  FETCH REPLIES OF A TICKET
  /// =======================================================
  Future<void> fetchTicketReplies(String ticketId) async {
    try {
      isRepliesLoading = true;
      notifyListeners();

      final url = ApiUrls.supportMyTicketsRepliesById.replaceAll(":id", ticketId);

      final res = await ApiMethods().getMethod(
        method: url,
        body: {},
        header: await ApiHeaders.withStoredToken(),
      );

      final jsonData = jsonDecode(res);

      if (jsonData["status"] == true) {

        replies = [];

        List replyList = jsonData["data"]["replies"] ?? [];

        for (var r in replyList) {
          replies.add({
            "sender": r["isAdmin"] == true ? "admin" : "user",
            "message": r["message"] ?? "",
            "time": r["createdAt"] ?? "",
          });
        }

      } else {
        Helper.customToast("Failed to load replies");
      }
    } catch (e) {
      Helper.customToast("Something went wrong");
    }

    isRepliesLoading = false;
    notifyListeners();
  }


  /// =======================================================
  ///  SEND REPLY
  /// =======================================================
  Future<void> sendReply({
    required String ticketId,
    required String message,
    required List<File> attachments,
  }) async {
    try {
      final url = ApiUrls.supportMyTicketsReplies.replaceAll(":id", ticketId);

      final response = await ApiMethods().postMultipartMultipleFiles(
        method: url,
        fields: {
          "message": message,
        },
        files: attachments,
        fileFieldName: "attachments",
        headers: await ApiHeaders.withStoredToken(),
      );

      if (response?.status == true) {
        /// Push message to local list for instant UI update
        replies.add({
          "sender": "user",
          "message": message,
        });

        notifyListeners();

      } else {
        Helper.customToast(response?.message ?? "Failed to send reply");
      }
    } catch (e) {
      Helper.customToast("Something went wrong");
    }
  }
}
