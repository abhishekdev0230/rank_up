import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/views/bottom_navigation_bar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/provider/provider_classes/subscription_provider.dart';
import '../../Home/home_view.dart';

class SubscriptionScreen extends StatefulWidget {
  final String? isSub;

  const SubscriptionScreen({super.key, this.isSub});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedPlanIndex = 0;
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _success);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _failed);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _wallet);

    Future.microtask(() {
      Provider.of<SubscriptionProvider>(context, listen: false).fetchPlans();
    });
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  /* ---------------- PAYMENT CALLBACKS ---------------- */

  void _success(PaymentSuccessResponse response) async {
    final sp = Provider.of<SubscriptionProvider>(context, listen: false);
    final plan = sp.plans[selectedPlanIndex];

    await sp.activatePremium(
      response.paymentId ?? "",
      plan.id ?? "",
      response,
      plan.price ?? 0,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Payment Successful | Premium Activated")),
    );

    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const BottomNavController(initialIndex: 0),
      ),
      (route) => false,
    );
  }

  void _failed(PaymentFailureResponse response) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("❌ Payment Failed")));
  }

  void _wallet(ExternalWalletResponse response) {}

  /* ---------------- UI ---------------- */

  @override
  Widget build(BuildContext context) {
    final sp = Provider.of<SubscriptionProvider>(context);

    return CommonScaffold(
      title: "Plans",
      backgroundColor: MyColors.color295176,
      appBarBackgroundColor: MyColors.color295176,
      body: sp.isLoading
          ? const Center(child: CommonLoader(color: Colors.white))
          : sp.plans.isEmpty
          ? const Center(
              child: Text(
                "No plans found",
                style: TextStyle(color: Colors.white),
              ),
            )
          : _buildUI(sp),
    );
  }

  Widget _buildUI(SubscriptionProvider sp) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* ---------- HEADER ---------- */
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColors.whiteText,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  "Start Your Premium Plan &\nUnlock Full Access",
                  textAlign: TextAlign.center,
                  style: boldTextStyle(
                    fontSize: 20,
                    color: MyColors.blackColor,
                  ),
                ),
                hSized20,

                /* ---------- ALL PLANS GRID ---------- */
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: sp.plans.length,
                  itemBuilder: (context, index) {
                    final plan = sp.plans[index];
                    return _priceBox(
                      title: plan.name ?? "",
                      price: "₹${plan.price}",
                      isSelected: selectedPlanIndex == index,
                      onTap: () {
                        if (widget.isSub == "true") {
                          _showAlreadySubscribedMsg();
                          return;
                        }
                        setState(() => selectedPlanIndex = index);
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          hSized20,

          /* ---------- FEATURES ---------- */
          Text(
            "Premium Plan",
            style: boldTextStyle(fontSize: 18, color: MyColors.whiteText),
          ),
          hSized10,

          ...(sp.plans[selectedPlanIndex].features != null &&
                  sp.plans[selectedPlanIndex].features!.isNotEmpty
              ? sp.plans[selectedPlanIndex].features!.map((f) => _feature(f))
              : [
                  "Unlimited Access",
                  "Recorded Classes",
                  "Premium Support",
                ].map((f) => _feature(f))),

          hSized30,

          /* ---------- PURCHASE BUTTON ---------- */
          CommonButton1(
            height: 45,
            title: "Purchase Premium Plan",
            onPressed: () {
              if (widget.isSub == "true") {
                _showAlreadySubscribedMsg();
                return;
              }
              openRazorpay(sp);
            },
          ),
          hSized12,
        ],
      ),
    );
  }

  /* ---------------- HELPERS ---------------- */

  void openRazorpay(SubscriptionProvider sp) {
    final plan = sp.plans[selectedPlanIndex];

    final options = {
      'key': ApiUrls.razorPayKey,
      'amount': (plan.price ?? 0) * 100,
      'name': plan.name ?? "Premium Plan",
      'description': 'Subscription Purchase',
    };

    _razorpay.open(options);
  }

  Widget _priceBox({
    required String title,
    required String price,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: MyColors.color295176,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? MyColors.circularProgressBackgroundColor
                : Colors.transparent,
            width: isSelected ? 3 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 2,
              style: boldTextStyle(fontSize: 13, color: Colors.white),
            ),
            hSized5,
            Text(
              price,
              style: boldTextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlreadySubscribedMsg() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("⚠️ You already have an active subscription"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _feature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: const [
              Icon(Icons.check, color: Colors.white, size: 20),
              Positioned(
                left: 6,
                child: Icon(Icons.check, color: Colors.white, size: 20),
              ),
            ],
          ),
          wSized10,
          Expanded(
            child: Text(
              text,
              style: regularTextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
