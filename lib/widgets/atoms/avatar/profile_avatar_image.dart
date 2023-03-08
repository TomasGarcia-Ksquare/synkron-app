import 'package:flutter/material.dart';

class ProfileAvatarImage extends StatelessWidget {
  final String imagePath;
  final double? radius;
  const ProfileAvatarImage({
    super.key,
    required this.imagePath,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 44,
      backgroundImage: NetworkImage(imagePath),
    );
  }
}
