import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';

class TitleAndDescriptionSliver extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? description;
  final TextStyle? descriptionStyle;

  const TitleAndDescriptionSliver({
    super.key,
    this.title,
    this.titleStyle,
    this.description,
    this.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Text(
            title ?? 'Title',
            style: titleStyle ?? TypographyTheme.fontH2AccentBlue2,
          ),
          Text(
            description ?? 'Description',
            style: descriptionStyle ?? TypographyTheme.fontBody1,
          ),
        ]),
      ),
    );
  }
}
