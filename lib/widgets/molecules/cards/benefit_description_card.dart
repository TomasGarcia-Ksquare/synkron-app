import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:synkron_app/models/employee/employee_model.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/painter/benefits_card_painter.dart';

class BenefitDescriptionCard extends StatelessWidget {
  final BenefitsModel benefits;
  const BenefitDescriptionCard({super.key, required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: ColorsShadesTheme.neutralGray1,
        elevation: 0,
        child: CustomPaint(
            painter: BenefitsCardPainter(),
            child: Column(children: <Widget>[
              const SizedBox(height: 16.0),
              SvgPicture.asset("assets/icons/${benefits.iconName}.svg"),
              const SizedBox(height: 18.0),
              SizedBox(
                  width: 132.0,
                  child: Text(benefits.displayName!,
                      style: TypographyTheme.fontH4,
                      textAlign: TextAlign.center)),
              const SizedBox(height: 16.0),
              SizedBox(
                  width: 132.0,
                  child: Text(benefits.description!,
                      style: TypographyTheme.fontBody2,
                      textAlign: TextAlign.center))
            ])));
  }
}
