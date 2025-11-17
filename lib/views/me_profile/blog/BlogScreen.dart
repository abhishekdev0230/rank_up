import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/custom_classes/CommonProfileImage.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/BlogModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/views/me_profile/blog/BlogDetailScreen.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  bool isLoading = true;
  List<BlogData> blogs = [];

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    try {
      final headers = await ApiHeaders.withStoredToken();
      final res = await ApiMethods().getMethod(
        method: ApiUrls.blog,
        body: {},
        header: headers,
      );

      if (res.isNotEmpty) {
        final blogModel = blogModelFromJson(res);
        if (blogModel.status == true && blogModel.data != null) {
          setState(() {
            blogs = blogModel.data!;
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);
          Helper.customToast(blogModel.message ?? "No blogs found");
        }
      }
    } catch (e) {
      setState(() => isLoading = false);
      Helper.customToast("Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Blogs",
      body: isLoading
          ? const Center(child: CommonLoader())
          : blogs.isEmpty
          ? const Center(child: Text("No blogs available"))
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: blogs.length,
              separatorBuilder: (_, __) => const Divider(
                color: Colors.black12,
                thickness: 0.5,
                height: 20,
              ),
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlogDetailScreen(blogId: blog.id ?? "",titel: blog.category?.toUpperCase() ?? "",),
                      ),
                    );

                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail Image
                      CommonNetworkImage(
                        imageUrl: blog.featuredImage,
                        width: 80,
                        height: 80,
                        borderRadius: 8,
                        placeholderAsset: 'assets/images/blog_placeholder.png',
                      ),

                      const SizedBox(width: 12),

                      // Blog Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blog.category?.toUpperCase() ?? "",
                              style: mediumTextStyle(
                                fontSize: 11,
                                // color: MyColors.orangeColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              blog.title ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: semiBoldTextStyle(
                                fontSize: 14,
                                color: MyColors.blackColor,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  _formatDate(blog.publishedAt),
                                  style: mediumTextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  "•",
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "${blog.readTime ?? 0} mins",
                                  style: mediumTextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.day.toString().padLeft(2, '0')} "
        "${_monthName(date.month)} ${date.year}";
  }

  String _monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }
}
