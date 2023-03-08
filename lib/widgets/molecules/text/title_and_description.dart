import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';

class TitleAndDescription extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? description;
  final TextStyle? descriptionStyle;

  const TitleAndDescription({
    super.key,
    this.title,
    this.titleStyle,
    this.description,
    this.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'Title',
            style: titleStyle ?? TypographyTheme.fontH2AccentBlue2,
          ),
          Text(
            description ?? 'Description',
            style: descriptionStyle ?? TypographyTheme.fontBody1,
          ),
        ],
      ),
    );
    // SliverPadding(
    //   padding: const EdgeInsets.only(
    //     left: 16,
    //     right: 16,
    //   ),
    //   sliver: SliverList(
    //     delegate: SliverChildListDelegate([
    //       Text(
    //         title ?? 'Title',
    //         style: titleStyle ?? TypographyTheme.fontH2AccentBlue2,
    //       ),
    //       Text(
    //         description ?? 'Description',
    //         style: descriptionStyle ?? TypographyTheme.fontBody1,
    //       ),
    //     ]),
    //   ),
    // );
  }
}
