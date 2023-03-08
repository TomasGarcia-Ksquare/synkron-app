import 'package:synkron_app/utils/utils.dart';

class EmployeeTimeOffModel {
  bool? allowPastDates;
  int? benefitId;
  String? iconName;
  String? displayName;
  String? helperText;
  int? availableHours;
  int? takenHours;
  int? requestedHours;
  int? temporalRemainder;
  int? grantedHours;
  String? renewalDate;
  String? timeUnit;
  bool? isActive;
  bool? shouldShownInBalance;

  EmployeeTimeOffModel(
      {this.allowPastDates,
      this.benefitId,
      this.iconName,
      this.displayName,
      this.helperText,
      this.availableHours,
      this.takenHours,
      this.requestedHours,
      this.temporalRemainder,
      this.grantedHours,
      this.renewalDate,
      this.timeUnit,
      this.isActive,
      this.shouldShownInBalance});

  EmployeeTimeOffModel.fromJson(Map<String, dynamic> json) {
    allowPastDates = json['allowPastDates'];
    benefitId = json['benefitId'];
    iconName = json['iconName'];
    displayName = json['displayName'];
    helperText = json['helperText'];
    availableHours = json['availableHours'];
    takenHours = json['takenHours'];
    requestedHours = json['requestedHours'];
    temporalRemainder = json['temporalRemainder'];
    grantedHours = json['grantedHours'];
    renewalDate = json['renewalDate'] != null
        ? Utils.formatDate(
            date: json['renewalDate'], format: DateFormatInterface.MM_DD_YYY)
        : null;
    timeUnit = json['timeUnit'];
    isActive = json['isActive'];
    shouldShownInBalance = json['shouldShownInBalance'];
  }
}
