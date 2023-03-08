class TimeOffEmployeeRecordsModel {
  final int id;
  final String approvedAt;
  final String startDate;
  final String endDate;
  final String state;
  // String? comments;
  // String approverComments;
  // String hrComments;
  // bool isEdited;
  final bool isCancelPending;
  final bool isInAdvance;
  final bool isInPast;
  final int approverId;
  // int? lastHrId; //Null
  final int employeeId;
  final int benefitId;
  final String createdAt;
  final String updatedAt;
  final BenefitModel benefit; //modelo 1
  final List<HoursPerDayListModel> hoursPerDayList; //modelo 3
  // List<int>? timeOffAttachments; //modelo 4 - Null

  TimeOffEmployeeRecordsModel(
      {required this.id,
      required this.approvedAt,
      required this.startDate,
      required this.endDate,
      required this.state,
      required this.isCancelPending,
      required this.isInAdvance,
      required this.isInPast,
      required this.approverId,
      required this.employeeId,
      required this.benefitId,
      required this.createdAt,
      required this.updatedAt,
      required this.benefit,
      required this.hoursPerDayList
      //this.comments,
      //this.approverComments,
      //this.hrComments,
      //this.isEdited,
      //this.lastHrId,
      // this.timeOffAttachments,
      });

  @override
  String toString() {
    return '{id: $id, approvedAt: $approvedAt, starDate: $startDate, endDate: $endDate, state: $state, isCancelPending: $isCancelPending, isInAdvance: $isInAdvance, isInPast: $isInPast, approverId: $approverId, employeeId: $employeeId, benefitId: $benefitId, createdAt: $createdAt, updateAt: $updatedAt, benefit: $benefit, hoursPerDayList: $hoursPerDayList}';
  }
}

// MODELO 1
class BenefitModel {
  final int id;
  final String name;
  final String displayName;
  final String description;
  //final String descriptionLinks;
  //final String iconName;
  //ParamsModel? params; //Modelo
  final String type;
  final String status;
  //final String helperText;
  //final int regionId;
  final int benefitSchemaId;
  final int updatedById;
  final String createdAt;
  final String updatedAt;
  //final int benefitTagId;

  BenefitModel(
      {required this.id,
      required this.name,
      required this.displayName,
      required this.description,
      required this.type,
      required this.status,
      required this.updatedById,
      required this.createdAt,
      required this.updatedAt,
      required this.benefitSchemaId
      //this.params,
      //this.descriptionLinks,
      //this.iconName,
      //this.helperText,
      //this.regionId,
      //this.benefitTagId,
      });

  @override
  String toString() {
    return '{id: $id, name: $name, displayName: $displayName, description: $description, type: $type, status: $status, updatedById: $updatedById, createdAt: $createdAt, updatedAt: $updatedAt, benefitSchemaId: $benefitSchemaId}';
  }
}

class BenefitForHoursModel {
  final int defaultAssignedHours;

  BenefitForHoursModel({required this.defaultAssignedHours});

  @override
  String toString() {
    return '{defaultAssignedHours: $defaultAssignedHours}';
  }
}

// MODEL 3
class HoursPerDayListModel {
  final int id;
  final int hours;
  final String date;
  //int? timeOffRequestId;
  //String? createdAt;
  //String? updatedAt;

  HoursPerDayListModel({
    required this.id,
    required this.hours,
    required this.date,
    //this.timeOffRequestId,
    //this.createdAt,
    //this.updatedAt
  });

  @override
  String toString() {
    return '{id: $id, hours: $hours, date: $date';
  }
}

class BenefitsEmployeeModel {
  int? benefitId;
  String? iconName;
  String? displayName;
  String? helperText;

  BenefitsEmployeeModel({
    this.benefitId,
    this.iconName,
    this.displayName,
    this.helperText,
  });

  BenefitsEmployeeModel.fromJson(Map<String, dynamic> json) {
    benefitId = json['benefitId'];
    iconName = json['iconName'];
    displayName = json['displayName'];
    helperText = json['helperText'];
  }
}
