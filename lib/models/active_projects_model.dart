class ActiveProjectsModel {
  int? id;
  bool? isActive;
/*   Null? startDate;
  Null? endDate; */
  int? accumulatedHours;
  int? accumulatedExtraHours;
  int? employeeId;
  int? projectPositionId;
  String? createdAt;
  String? updatedAt;
  ProjectPosition? projectPosition;

  ActiveProjectsModel(
      {this.id,
      this.isActive,
      /*  this.startDate,
      this.endDate, */
      this.accumulatedHours,
      this.accumulatedExtraHours,
      this.employeeId,
      this.projectPositionId,
      this.createdAt,
      this.updatedAt,
      this.projectPosition});

  ActiveProjectsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['isActive'];
    /* startDate = json['startDate'];
    endDate = json['endDate']; */
    accumulatedHours = json['accumulatedHours'];
    accumulatedExtraHours = json['accumulatedExtraHours'];
    employeeId = json['employeeId'];
    projectPositionId = json['projectPositionId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    projectPosition = json['projectPosition'] != null
        ? ProjectPosition.fromJson(json['projectPosition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isActive'] = isActive;
    /*  data['startDate'] = this.startDate;
    data['endDate'] = this.endDate; */
    data['accumulatedHours'] = accumulatedHours;
    data['accumulatedExtraHours'] = accumulatedExtraHours;
    data['employeeId'] = employeeId;
    data['projectPositionId'] = projectPositionId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (projectPosition != null) {
      data['projectPosition'] = projectPosition!.toJson();
    }
    return data;
  }
}

class ProjectPosition {
  int? id;
  String? billRate;
  bool? isActive;
  /*  Null? startDate;
  Null? endDate; */
  int? weeklyForecastedHours;
  int? positionId;
  int? projectId;
  //Null? currencyId;
  String? createdAt;
  String? updatedAt;
  Project? project;

  ProjectPosition(
      {this.id,
      this.billRate,
      this.isActive,
      /*  this.startDate,
      this.endDate, */
      this.weeklyForecastedHours,
      this.positionId,
      this.projectId,
      //this.currencyId,
      this.createdAt,
      this.updatedAt,
      this.project});

  ProjectPosition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billRate = json['billRate'];
    isActive = json['isActive'];
    /*  startDate = json['startDate'];
    endDate = json['endDate']; */
    weeklyForecastedHours = json['weeklyForecastedHours'];
    positionId = json['positionId'];
    projectId = json['projectId'];
    //currencyId = json['currencyId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['billRate'] = billRate;
    data['isActive'] = isActive;
    /* data['startDate'] = this.startDate;
    data['endDate'] = this.endDate; */
    data['weeklyForecastedHours'] = weeklyForecastedHours;
    data['positionId'] = positionId;
    data['projectId'] = projectId;
    //data['currencyId'] = this.currencyId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    return data;
  }
}

class Project {
  int? id;
  String? name;
  String? description;
  String? status;
  String? projectType;
  String? startDate;
  String? endDate;
  bool? isActive;
  bool? isGeneral;
  int? customerId;
  int? businessunitId;
  /*  Null? contractTypeId;
  Null? approverId; */
  String? creationStep;
  int? totalForecastedHours;
  String? budget;
  String? extraInformation;
  int? approvals;
  int? currencyId;
  /*  Null? updatedById;
  Null? applicantId; */
  String? createdAt;
  String? updatedAt;
  Customer? customer;
  Businessunit? businessunit;
  //Null? approver;

  Project({
    this.id,
    this.name,
    this.description,
    this.status,
    this.projectType,
    this.startDate,
    this.endDate,
    this.isActive,
    this.isGeneral,
    this.customerId,
    this.businessunitId,
    /*  this.contractTypeId,
      this.approverId, */
    this.creationStep,
    this.totalForecastedHours,
    this.budget,
    this.extraInformation,
    this.approvals,
    this.currencyId,
    /* this.updatedById,
      this.applicantId, */
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.businessunit,
    //this.approver
  });

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    projectType = json['projectType'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    isActive = json['isActive'];
    isGeneral = json['isGeneral'];
    customerId = json['customerId'];
    businessunitId = json['businessunitId'];
    /*  contractTypeId = json['contractTypeId'];
    approverId = json['approverId']; */
    creationStep = json['creationStep'];
    totalForecastedHours = json['totalForecastedHours'] ?? 0;
    budget = json['budget'];
    extraInformation = json['extraInformation'];
    approvals = json['approvals'];
    currencyId = json['currencyId'];
    /* updatedById = json['updatedById'];
    applicantId = json['applicantId']; */
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    businessunit = json['businessunit'] != null
        ? Businessunit.fromJson(json['businessunit'])
        : null;
    //approver = json['approver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['status'] = status;
    data['projectType'] = projectType;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['isActive'] = isActive;
    data['isGeneral'] = isGeneral;
    data['customerId'] = customerId;
    data['businessunitId'] = businessunitId;
    /* data['contractTypeId'] = this.contractTypeId;
    data['approverId'] = this.approverId; */
    data['creationStep'] = creationStep;
    data['totalForecastedHours'] = totalForecastedHours;
    data['budget'] = budget;
    data['extraInformation'] = extraInformation;
    data['approvals'] = approvals;
    data['currencyId'] = currencyId;
    /* data['updatedById'] = this.updatedById;
    data['applicantId'] = this.applicantId; */
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (businessunit != null) {
      data['businessunit'] = businessunit!.toJson();
    }
    //data['approver'] = this.approver;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? shortName;
  bool? isActive;
  int? createdById;
  int? updatedById;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.name,
      this.shortName,
      this.isActive,
      this.createdById,
      this.updatedById,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    isActive = json['isActive'];
    createdById = json['createdById'];
    updatedById = json['updatedById'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['shortName'] = shortName;
    data['isActive'] = isActive;
    data['createdById'] = createdById;
    data['updatedById'] = updatedById;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Businessunit {
  int? id;
  String? name;
  /*  Null? createdById;
  Null? updatedById; */
  String? createdAt;
  String? updatedAt;

  Businessunit(
      {this.id,
      this.name,
      /*  this.createdById,
      this.updatedById, */
      this.createdAt,
      this.updatedAt});

  Businessunit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    /*  createdById = json['createdById'];
    updatedById = json['updatedById']; */
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    /* data['createdById'] = this.createdById;
    data['updatedById'] = this.updatedById; */
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
