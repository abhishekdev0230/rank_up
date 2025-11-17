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

class CommonNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit fit;
  final String? placeholderAsset;

  const CommonNetworkImage({
    Key? key,
    this.imageUrl,
    required this.width,
    required this.height,
    this.borderRadius = 8,
    this.fit = BoxFit.cover,
    this.placeholderAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ If URL is empty or null, show placeholder immediately
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _placeholder();
    }

    // ✅ Cached Network Image with shimmer loader
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        color: Colors.grey.shade200,
        child: placeholderAsset != null
            ? Image.asset(
          placeholderAsset!,
          width: width,
          height: height,
          fit: BoxFit.cover,
        )
            : const Icon(
          Icons.image_not_supported,
          color: Colors.grey,
          size: 30,
        ),
      ),
    );
  }
}
