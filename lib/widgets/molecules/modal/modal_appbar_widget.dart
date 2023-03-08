import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';

class ModalAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBar appBar;
  String title;
  IconData icon;

  ModalAppbarWidget({
    super.key,
    required this.appBar,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(
        icon,
        color: ColorsTheme.primaryBlue,
        size: 32,
      ),
      title: Text(title, style: TypographyTheme.fontH1AccentBlue2),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomOpacity: 0.0,
      elevation: 0.0,
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.close,
              color: ColorsTheme.primaryBlue,
              size: 32,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
