import 'package:flutter/material.dart';

class UserRow extends StatelessWidget {
  final String title;
  final String gender;
  final String? imageUrl;      // supports asset or network
  final Widget right;
  final double imageSize;

  const UserRow({
    super.key,
    required this.title,
    required this.gender,
    required this.right,
    this.imageUrl,
    this.imageSize = 60,
  });

  bool get isAsset =>
      imageUrl != null && imageUrl!.startsWith("assets/");

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        // ----------------------------
        //     LEFT IMAGE
        // ----------------------------
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: imageSize,
            height: imageSize,
            child: _buildImage(),
          ),
        ),

        const SizedBox(width: 12),

        // ----------------------------
        //     TITLE + GENDER
        // ----------------------------
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              gender,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),

        const Spacer(),

        // ----------------------------
        //     RIGHT SIDE WIDGET
        // ----------------------------
        right,
      ],
    );
  }

  // ----------------------------
  //     IMAGE LOGIC
  // ----------------------------
  Widget _buildImage() {
    if (imageUrl == null) {
      return Container(
        color: Colors.grey.shade300,
        child: const Icon(Icons.person, color: Colors.white),
      );
    }

    if (isAsset) {
      return Image.asset(
        imageUrl!,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
      );
    }

    return Image.network(
      imageUrl!,
      width: imageSize,
      height: imageSize,
      fit: BoxFit.cover,
      errorBuilder: (c, e, s) => Container(
        color: Colors.grey.shade300,
        child: const Icon(Icons.error),
      ),
    );
  }
}
