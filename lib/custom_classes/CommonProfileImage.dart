import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CommonProfileImage extends StatelessWidget {
  final String? imageUrl; // from API
  final File? localFile; // newly picked image
  final double radius;
  final String placeholderAsset;

  const CommonProfileImage({
    Key? key,
    this.imageUrl,
    this.localFile,
    this.radius = 60,
    required this.placeholderAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ If local file exists — show immediately
    if (localFile != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(localFile!),
        backgroundColor: Colors.grey.shade200,
      );
    }

    // ✅ If image URL available — show cached network image with shimmer
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: radius * 2,
              height: radius * 2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
          errorWidget: (context, url, error) => CircleAvatar(
            radius: radius,
            backgroundImage: AssetImage(placeholderAsset),
            backgroundColor: Colors.grey.shade200,
          ),
        ),
      );
    }

    // ✅ If no image or file — show default asset
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(placeholderAsset),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
