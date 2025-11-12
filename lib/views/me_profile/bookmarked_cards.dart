import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/provider/provider_classes/BookmarkedCardsProvider.dart';
import 'package:rank_up/models/BookmarkedCardListModel.dart' as Model;

class BookmarkedCards extends StatefulWidget {
  final String type;
  const BookmarkedCards({super.key, required this.type});

  @override
  State<BookmarkedCards> createState() => _BookmarkedCardsState();
}

class _BookmarkedCardsState extends State<BookmarkedCards> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<BookmarkedCardsProvider>(context, listen: false)
            .fetchBookmarkedCards(context, widget.type));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookmarkedCardsProvider>(context);
    final bool isSuspended = widget.type == "Suspended Cards";

    return CommonScaffold(
      title: widget.type,
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.bookmarkedData?.data?.cards == null ||
          provider.bookmarkedData!.data!.cards!.isEmpty
          ? Center(
        child: Text(
          isSuspended
              ? "No suspended cards found"
              : "No bookmarked cards found",
          style: const TextStyle(
              color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.only(top: 16),
        itemCount: provider.bookmarkedData!.data!.cards!.length,
        itemBuilder: (context, index) {
          final card = provider.bookmarkedData!.data!.cards![index];
          return _cardTile(context, card, isSuspended);
        },
      ),
    );
  }

  Widget _cardTile(BuildContext context, Model.Card cardData, bool isSuspended) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSuspended ? Colors.red.shade100 : Colors.green.shade100,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Question
            Text(
              cardData.question ?? "No question available",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: MyColors.blackColor,
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 Answer
            Text(
              cardData.answer ?? "No answer available",
              style: TextStyle(
                fontSize: 14,
                color: MyColors.blackColor.withOpacity(0.9),
                height: 1.4,
              ),
            ),

            // 🔹 Image (optional)
            if (cardData.answerImage != null &&
                cardData.answerImage!.isNotEmpty) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  cardData.answerImage!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stack) => const SizedBox(),
                ),
              ),
            ],

            const SizedBox(height: 14),
            const Divider(height: 1, color: Colors.black12),
            const SizedBox(height: 10),

            // 🔹 Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 🔸 Label / Status
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSuspended
                        ? Colors.red.shade50
                        : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isSuspended ? "Suspended Deck" : "Featured Deck",
                    style: TextStyle(
                      fontSize: 12,
                      color:
                      isSuspended ? Colors.red.shade700 : Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // 🔸 Action Button
                InkWell(
                  onTap: () {
                    final provider = Provider.of<BookmarkedCardsProvider>(context, listen: false);

                    if (isSuspended) {
                      // 🔴 Unsuspend the card
                      provider.removeSuspendedCard(context, cardData.id ?? "");
                    } else {
                      // 🟢 Remove bookmarked card
                      provider.removeBookmark(context, cardData.id ?? "");
                    }
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSuspended ? Colors.red.shade50 : const Color(0xFFEAF8EE),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSuspended ? Colors.red : Colors.green,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSuspended ? Icons.refresh : Icons.check,
                          color: isSuspended ? Colors.red : Colors.green,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          isSuspended ? "Unsuspend" : "Remove",
                          style: TextStyle(
                            color: isSuspended ? Colors.red : Colors.green,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
