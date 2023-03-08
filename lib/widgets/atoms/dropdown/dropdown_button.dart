import 'package:flutter/material.dart';

import '../../../styles/colors_theme.dart';
import '../../../styles/font_styles.dart';

class DropdownButtonCustom extends StatefulWidget {
  //EdgeInsetsGeometry? ddPadding;
  DropdownButtonCustom({
    Key? key,
    //required this.ddPadding,
  }) : super(key: key);

  @override
  State<DropdownButtonCustom> createState() => _DropdownButtonCustomState();
}

class _DropdownButtonCustomState extends State<DropdownButtonCustom> {
  List<String> list = <String>['Future Request', 'Past Request'];
  String dropdownValue = 'Future Request';
  //late EdgeInsetsGeometry ddPadding;

  // @override
  // void initState() {
  //   super.initState();
  //   ddPadding;
  // }

  @override
  Widget build(BuildContext context) {
    //TO DO: This widget is not working properly. Need to fix it.
    return const SizedBox(
        // width: double.infinity,
        // height: 55,
        // child: DecoratedBox(
        //   decoration: BoxDecoration(
        //     color: ColorsTheme.white,
        //     border: Border.all(color: ColorsShadesTheme.neutralGray2, width: 1),
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   child: SizedBox(
        //     child: Padding(
        //       padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
        //       child: DropdownButton<String>(
        //         underline: Container(),
        //         elevation: 0,
        //         value: dropdownValue,
        //         style: TypographyTheme.fontBody1,
        //         alignment: AlignmentDirectional.center,
        //         onChanged: (String? value) {
        //           setState(() {
        //             dropdownValue = value!;
        //           });
        //         },
        //         icon: const Padding(
        //           padding: EdgeInsets.only(left: 165),
        //           child: Icon(
        //             Icons.expand_more,
        //             color: ColorsTheme.primaryBlue,
        //           ),
        //         ),
        //         items: list.map<DropdownMenuItem<String>>((String value) {
        //           return DropdownMenuItem<String>(
        //             value: value,
        //             child: Text(value),
        //           );
        //         }).toList(),
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}

//Provitional widget
class DropdownButtonClone extends StatefulWidget {
  DropdownButtonClone({
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownButtonClone> createState() => _DropdownButtonCloneState();
}

class _DropdownButtonCloneState extends State<DropdownButtonClone> {
  List<String> list = <String>['Future Request', 'Past Request'];
  String dropdownValue = 'Future Request';
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220, //double.infinity,
      height: 55,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ColorsTheme.white,
          border: Border.all(color: ColorsShadesTheme.neutralGray2, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
            child: DropdownButton<String>(
              underline: Container(),
              elevation: 2,
              value: dropdownValue,
              style: TypographyTheme.fontBody1,
              alignment: AlignmentDirectional.center,
              focusColor: ColorsTheme.white,
              dropdownColor: ColorsShadesTheme.neutralGray1,
              borderRadius: BorderRadius.circular(8),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              icon: const Padding(
                padding: EdgeInsets.only(left: 40), //165
                child: Icon(
                  Icons.expand_more,
                  color: ColorsTheme.primaryBlue,
                ),
              ),
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
