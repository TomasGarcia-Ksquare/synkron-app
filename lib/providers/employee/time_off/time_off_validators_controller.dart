import 'package:synkron_app/utils/constants.dart';

class TimeOffValidatorsController {
  isEmpty(fieldContent) {
    return fieldContent != null && fieldContent.isEmpty;
  }

  notAllowedChars(fieldContent) {
    return Constants.NOT_ALLOWED_CHARS_REG_EXP.hasMatch(fieldContent);
  }

  notValidRequestedTime(fieldContent) {
    var validTime =
        Constants.NUMBER_ONE_DECIMAL_REG_EXP.stringMatch(fieldContent ?? '');
    if (validTime == null ||
        (validTime.length < fieldContent!.length) ||
        validTime[validTime.length - 1] == '.') {
      return true;
    }
    return false;
  }

  String? commentsValidator(String? fieldContent) {
    // if (isEmpty(fieldContent)) {
    //   return 'Please fill out the field';
    // }
    if (notAllowedChars(fieldContent)) {
      return 'Not special chars';
    }
    return null;
  }

  String? timeRequestedValidator(String? fieldContent) {
    if (isEmpty(fieldContent)) return 'Please fill out the field';
    if (notValidRequestedTime(fieldContent)) {
      return 'Valid number is required, only numbers and one dot are allowed';
    }
    return null;
  }
}
