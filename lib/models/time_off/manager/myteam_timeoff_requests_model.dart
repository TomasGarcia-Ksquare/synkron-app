class TimeOffRequestsModel {
  final int id;
  final String approvedAt;
  final String startDate;
  final String endDate;
  final String state;
  final bool isCancelPending;
  final bool isInAdvance;
  final bool isInPast;
  final int approverId;
  final int employeeId;
  final int benefitId;
  final String createdAt;
  final String updatedAt;
  final BenefitModel benefit; //modelo 1
  final EmployeeModel employee; //modelo 2
  final List<HoursPerDayListModel> hoursPerDayList; //modelo 3
  // String? comments;
  // String approverComments;
  // String hrComments;
  // bool isEdited;
  // int? lastHrId; //Null
  // List<int>? timeOffAttachments; //modelo 4 - Null

  TimeOffRequestsModel(
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
      required this.employee,
      required this.hoursPerDayList
      //this.comments,
      //this.approverComments,
      //this.hrComments,
      //this.isEdited,
      //this.lastHrId,
      // this.timeOffAttachments,
      });

  /*TimeOffRequestsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    approvedAt = json['approvedAt'] == null
        ? 'null'
        : Utils.formatDate(
            date: json['approvedAt'], format: DateFormatInterface.MM_DD_YY);
    startDate = Utils.formatDate(
        date: json['startDate'], format: DateFormatInterface.MM_DD_YY);
    endDate = Utils.formatDate(
        date: json['endDate'], format: DateFormatInterface.MM_DD_YY);
    state = json['state'];
    isCancelPending = json['isCancelPending'];
    isInAdvance = json['isInAdvance'];
    isInPast = json['isInPast'];
    approverId = json['approverId'];
    employeeId = json['employeeId'];
    benefitId = json['benefitId'];
    createdAt = Utils.formatDate(
        date: json['createdAt'], format: DateFormatInterface.MM_DD_YY);
    updatedAt = Utils.formatDate(
        date: json['updatedAt'], format: DateFormatInterface.MM_DD_YY);
    benefit =
        json['benefit'] != null ? BenefitModel.fromJson(json['benefit']) : null;
    employee = json['employee'] != null
        ? EmployeeModel.fromJson(json['employee'])
        : null;
    if (json['hoursPerDayList'] != null) {
      hoursPerDayList = <HoursPerDayListModel>[];
      json['hoursPerDayList'].forEach((v) {
        hoursPerDayList!.add(HoursPerDayListModel.fromJson(v));
      });
    }
    //comments = json['comments'];
    //approverComments = json['approverComments'];
    //hrComments = json['hrComments'];
    //isEdited = json['isEdited'];
    //lastHrId = json['lastHrId'];
    // if (json['timeOffAttachments'] != null) {
    //   timeOffAttachments = <int>[];
    //   json['timeOffAttachments'].forEach((v) {
    //     timeOffAttachments!.add(int.fromJson(v));
    //   });
    // }
  }*/

  @override
  String toString() {
    return '{id: $id, approvedAt: $approvedAt, starDate: $startDate, endDate: $endDate, state: $state, isCancelPending: $isCancelPending, isInAdvance: $isInAdvance, isInPast: $isInPast, approverId: $approverId, employeeId: $employeeId, benefitId: $benefitId, createdAt: $createdAt, updateAt: $updatedAt, benefit: $benefit, employee: $employee, hoursPerDayList: $hoursPerDayList}';
  }
}

// MODELO 1
class BenefitModel {
  final int id;
  final String name;
  final String displayName;
  final String description;
  //ParamsModel? params; //Modelo
  final String type;
  final String status;
  final int updatedById;
  final String createdAt;
  final String updatedAt;
  final int benefitSchemaId;
  //final String descriptionLinks;
  //final String iconName;
  //final String helperText;
  //final int regionId;
  //final int benefitTagId;

  BenefitModel(
      {required this.id,
      required this.name,
      required this.displayName,
      required this.description,
      //this.params,
      required this.type,
      required this.status,
      required this.updatedById,
      required this.createdAt,
      required this.updatedAt,
      required this.benefitSchemaId
      //this.descriptionLinks,
      //this.iconName,
      //this.helperText,
      //this.regionId,
      //this.benefitTagId,
      });

  /*
  BenefitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['displayName'];
    description = json['description'];
    params =
        json['params'] != null ? ParamsModel.fromJson(json['params']) : null;
    type = json['type'];
    status = json['status'];
    updatedById = json['updatedById'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    benefitSchemaId = json['benefitSchemaId'];
    //descriptionLinks = json['descriptionLinks'];
    //iconName = json['iconName'];
    //helperText = json['helperText'];
    //regionId = json['regionId'];
    //benefitTagId = json['benefitTagId'];
  }*/
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

//MODELO 2
class EmployeeModel {
  final int id;
  final String fullName;
  final int departmentId;
  final bool isDepartmentManager;
  final int managerId;
  //String? personalEmail;
  //int? regionId;
  //String? firstName;
  //String? middleName;
  //String? lastName;
  //String? secondLastName;
  //String? gender;
  //String? nationalIdentificationNumber;
  //String? taxIdentificationNumber;
  //String? socialSecurityNumber;
  //String? phone;
  //String? birthdate;
  //String? address;
  //String? emergencyContact;
  //String? emergencyNumber;
  //String? medicalConditions;
  //String? pronouns;
  //String? hiringDate;
  //String? employmentRelationship;
  //Null? profileImageId;
  //String? jobEmail;
  //bool? isExternal;
  //int? positionId;
  //String? createdAt;
  //String? updatedAt;
  //int? seniority;
  final int workingHours;
  final String status;
  final String externalId;
  final int updatedById;

  EmployeeModel({
    required this.id,
    required this.fullName,
    //this.personalEmail,
    //this.firstName,
    //this.middleName,
    //this.lastName,
    //this.secondLastName,
    //this.gender,
    //this.nationalIdentificationNumber,
    //this.taxIdentificationNumber,
    //this.socialSecurityNumber,
    //this.phone,
    // this.birthdate,
    // this.address,
    // this.emergencyContact,
    // this.emergencyNumber,
    // this.medicalConditions,
    // this.pronouns,
    //this.hiringDate,
    //this.employmentRelationship,
    //this.profileImageId,
    //this.regionId,
    //this.jobEmail,
    //this.isExternal,
    //this.positionId,
    //this.seniority,
    //this.createdAt,
    //this.updatedAt
    required this.departmentId,
    required this.isDepartmentManager,
    required this.managerId,
    required this.workingHours,
    required this.status,
    required this.externalId,
    required this.updatedById,
  });

  @override
  String toString() {
    return '{id: $id, fullName: $fullName, departmentId: $departmentId}, isDepartmentManager: $isDepartmentManager, managerId: $managerId, workingHours:$workingHours,  status: $status, externalId: $externalId, updatedById: $updatedById';
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

class StateModel {
  static const String approved = 'approved';
  static const String reject = 'rejected';
}
