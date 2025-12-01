import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/CommonProfileImage.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/models/BlogDetailModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'dart:convert';


class BlogDetailScreen extends StatefulWidget {
  final String blogId;
  final String titel;

  const BlogDetailScreen({super.key, required this.blogId, required this.titel});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  BlogDetailData? blog;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBlogDetail();
  }

  Future<void> fetchBlogDetail() async {
    try {
      // ✅ Prepare headers
      final headers = await ApiHeaders.withStoredToken();

      // ✅ API call using your ApiMethods().getMethod
      final responseBody = await ApiMethods().getMethod(
        method: ApiUrls.blogDetail.replaceFirst(':id', widget.blogId),
        body: {},
        header: headers,
      );

      if (responseBody.isNotEmpty) {
        final decoded = jsonDecode(responseBody);

        if (decoded['status'] == true) {
          blog = BlogDetailModel.fromJson(decoded).data;
        } else {
          debugPrint("❌ API returned false status: ${decoded['message']}");
        }
      }
    } catch (e) {
      debugPrint("❌ Error fetching blog detail: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: widget.titel,
      body: isLoading
          ? _buildShimmer()
          : blog == null
          ? const Center(child: Text("Failed to load blog"))
          : _buildBlogDetail(),
    );
  }

  Widget _buildBlogDetail() {
    final date = blog!.publishedAt != null
        ? DateFormat('dd MMM yyyy').format(blog!.publishedAt!)
        : "";

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hSized20,
          // ✅ Featured Image
          CommonNetworkImage(
            imageUrl: blog!.featuredImage,
            width: double.infinity,
            height: 200,
            borderRadius: 12,
          ),
          const SizedBox(height: 16),

          // ✅ Category & Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                blog!.category ?? "",
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "$date • ${blog!.readTime ?? 0} mins read",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // ✅ Title
          Text(
            blog!.title ?? "",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),

          // ✅ Author
          Text(
            "by ${blog!.authorName ?? "Admin"}",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),

          Html(shrinkWrap: true, data: blog!.content ?? ""),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Column(
      children: [
        hSized20,
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _shimmerLine(width: 80, height: 14),
        const SizedBox(height: 8),
        _shimmerLine(width: double.infinity, height: 20),
        const SizedBox(height: 8),
        _shimmerLine(width: 150, height: 14),
        const SizedBox(height: 16),
        _shimmerLine(width: double.infinity, height: 14),
        const SizedBox(height: 6),
        _shimmerLine(width: double.infinity, height: 14),
        const SizedBox(height: 6),
        _shimmerLine(width: double.infinity, height: 14),
      ],
    );
  }

  Widget _shimmerLine({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(width: width, height: height, color: Colors.white),
    );
  }
}
