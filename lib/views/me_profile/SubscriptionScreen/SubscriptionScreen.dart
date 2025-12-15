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
  const SubscriptionScreen({super.key});

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

  void _success(PaymentSuccessResponse response) async {
    final sp = Provider.of<SubscriptionProvider>(context, listen: false);
    final plan = sp.plans[selectedPlanIndex];

    final raw = {
      "paymentId": response.paymentId,
      "orderId": response.orderId,
      "signature": response.signature,
    };

    await sp.activatePremium(
      response.paymentId ?? "",
      plan.id ?? "",
      raw,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Successful ✔ Premium Activated")),
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
    ).showSnackBar(SnackBar(content: Text("❌ Payment Failed")));
  }

  void _wallet(ExternalWalletResponse response) {}

  @override
  Widget build(BuildContext context) {
    final sp = Provider.of<SubscriptionProvider>(context);

    return CommonScaffold(
      title: "Plans",
      backgroundColor: MyColors.color295176,
      appBarBackgroundColor: MyColors.color295176,
      body: sp.isLoading
          ? Center(child: CommonLoader(color: Colors.white))
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
          Container(
            padding: const EdgeInsets.all(20),
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

                Row(
                  children: [
                    Expanded(
                      child: _priceBox(
                        title: sp.plans[0].name ?? "",
                        price: "₹${sp.plans[0].price}",
                        isSelected: selectedPlanIndex == 0,
                        onTap: () => setState(() => selectedPlanIndex = 0),
                      ),
                    ),
                    wSized15,
                    Expanded(
                      child: _priceBox(
                        title: sp.plans[1].name ?? "",
                        price: "₹${sp.plans[1].price}",
                        isSelected: selectedPlanIndex == 1,
                        onTap: () => setState(() => selectedPlanIndex = 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          hSized20,

          Text(
            "Premium Plan",
            style: boldTextStyle(fontSize: 18, color: MyColors.whiteText),
          ),
          hSized10,

          ...?sp.plans[selectedPlanIndex].features?.map((f) => _feature(f)),

          hSized30,

          CommonButton1(
            height: 45,
            title: "Purchase Premium Plan",
            onPressed: () => openRazorpay(sp),
          ),
        ],
      ),
    );
  }

  void openRazorpay(SubscriptionProvider sp) {
    var plan = sp.plans[selectedPlanIndex];

    var options = {
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
            color: isSelected ? MyColors.circularProgressBackgroundColor : Colors.transparent,
            width: isSelected ? 3 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: boldTextStyle(fontSize: 16, color: Colors.white),
            ),
            hSized5,
            Text(
              price,
              style: mediumTextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
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
