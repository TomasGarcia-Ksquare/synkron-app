import 'package:flutter/material.dart';
import 'package:synkron_app/models/employee/employee_model.dart';
import 'package:synkron_app/widgets/atoms/avatar/profile_avatar_image.dart';
import 'package:synkron_app/widgets/atoms/painter/user_rectangle_painter.dart';
import 'package:synkron_app/widgets/molecules/user_widgets/user_column_info.dart';
import 'package:synkron_app/widgets/molecules/user_widgets/user_container.dart';

class UserProfileWidget extends StatelessWidget {
  final EmployeeProfileModel user;
  const UserProfileWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        UserContainer(
          child: CustomPaint(
              painter: UserRectanglePainter(),
              child: UserColumnInfo(user: user)),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ProfileAvatarImage(imagePath: user.imagePath!)),
      ],
    );
  }
}
