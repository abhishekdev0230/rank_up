import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/custom_classes/loder.dart' show CommonLoaderApi;
import 'package:rank_up/models/BookmarkedCardListModel.dart';
import 'package:rank_up/provider/provider_classes/ProfileSetupProvider.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/Utils/helper.dart';

class BookmarkedCardsProvider extends ChangeNotifier {
  bool isLoading = false;
  BookmarkedCardListModel? bookmarkedData;

  // ✅ Fetch either bookmarked or suspended cards
  Future<void> fetchBookmarkedCards(BuildContext context, String type) async {
    isLoading = true;
    notifyListeners();

    try {
      final headers = await ApiHeaders.withStoredToken();

      final response = await ApiMethods().getMethodTwo(
        method: type != "Suspended Cards"
            ? ApiUrls.bookmarksListApi
            : ApiUrls.suspendedCards,
        body: {},
        header: headers,
      );

      if (response.isNotEmpty) {
        final decoded = json.decode(response);
        bookmarkedData = BookmarkedCardListModel.fromJson(decoded);
      } else {
        Helper.customToast("No data received");
      }
    } catch (e) {
      Helper.customToast("Something went wrong: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  // ✅ Remove a bookmark
  Future<void> removeBookmark(BuildContext context, String bookmarkId) async {
    await _removeCommon(
      context,
      bookmarkId,
      removeType: "Bookmark",
      apiUrl: ApiUrls.bookmarksListRemoveApi,
      methodType: "DELETE",
    );
  }

  // ✅ Unsuspend a card (remove suspended card)
  Future<void> removeSuspendedCard(BuildContext context, String progressId) async {
    await _removeCommon(
      context,
      progressId,
      removeType: "Suspended Card",
      apiUrl: ApiUrls.suspendedCardsRemove,
      methodType: "POST",
    );
  }

  // 🧩 Common method to handle remove/unsuspend logic
  Future<void> _removeCommon(
      BuildContext context,
      String id, {
        required String removeType,
        required String apiUrl,
        required String methodType,
      }) async {
    try {
      CommonLoaderApi.show(context);

      final headers = await ApiHeaders.withStoredToken();
      final String url = apiUrl.replaceFirst(
        removeType == "Bookmark" ? ':bookmarkId' : ':progressId',
        id,
      );

      late String response;
      if (methodType == "DELETE") {
        response = await ApiMethods().deleteMethod(
          method: url,
          body: {},
          header: headers,
        );
      } else {
        response = await ApiMethods().postMethod(
          method: url,
          body: {},
          header: headers,
        );
      }

      CommonLoaderApi.hide(context);

      if (response.isNotEmpty) {
        final decoded = json.decode(response);
        final status = decoded['status'] ?? false;
        final message =
            decoded['message'] ?? "$removeType removed successfully";

        if (status == true) {
          // ✅ Remove from local list
          bookmarkedData?.data?.cards?.removeWhere((c) => c.id == id);
          notifyListeners();

          // ✅ Update ProfileSetupProvider count
          final profileProvider =
          Provider.of<ProfileSetupProvider>(context, listen: false);

          String currentCountStr = removeType == "Bookmark"
              ? profileProvider.bookmarkedCount
              : profileProvider.suspendedCardCount;

          int currentCount = int.tryParse(currentCountStr) ?? 0;
          if (currentCount > 0) currentCount--;

          if (removeType == "Bookmark") {
            profileProvider.bookmarkedCount = currentCount.toString();
          } else {
            profileProvider.suspendedCardCount = currentCount.toString();
          }

          profileProvider.notifyListeners();

          Helper.customToast(message);
        } else {
          Helper.customToast(message);
        }
      } else {
        Helper.customToast("Empty response from server");
      }
    } catch (e) {
      CommonLoaderApi.hide(context);
      Helper.customToast("Error while removing $removeType: $e");
    }
  }
}
