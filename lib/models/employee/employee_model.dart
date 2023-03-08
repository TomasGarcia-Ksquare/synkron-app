import 'package:synkron_app/extensions/camel_case_extension.dart';
import 'package:synkron_app/utils/utils.dart';

class EmployeeProfileModel {
  int? id;
  String? firstName;
  String? fullName;
  String? gender;
  String? phone;
  String? birthdate;
  String? address;
  String? hiringDate;
  String? jobEmail;
  String? status;
  int? profileImageId;
  String? imagePath;
  RegionModel? region;
  PositionModel? position;
  BenefitsPackageModel? benefitsPackage;
  EmployeeProfileModel? manager;
  bool? isManager;

  EmployeeProfileModel({
    this.id,
    this.firstName,
    this.fullName,
    this.gender,
    this.phone,
    this.birthdate,
    this.address,
    this.hiringDate,
    this.jobEmail,
    this.status,
    this.profileImageId,
    this.imagePath,
    this.region,
    this.position,
    this.benefitsPackage,
    this.manager,
    this.isManager,
  });

  EmployeeProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    fullName = json['fullName'];
    gender = json['gender'];
    phone = (json['phone'] == null || json['phone'] == "")
        ? json['phone'] = "N/A"
        : json['phone'] = json['phone'];
    birthdate = json['birthdate'];
    address = json['address'];
    hiringDate = Utils.formatDate(
        date: json['hiringDate'], format: DateFormatInterface.MM_DD_YY);
    jobEmail = json['jobEmail'];
    status = json['status'];
    profileImageId = json['profileImageId'];
    imagePath =
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
    region =
        json['region'] != null ? RegionModel.fromJson(json['region']) : null;
    position = json['position'] != null
        ? PositionModel.fromJson(json['position'])
        : null;
    benefitsPackage = json['benefitsPackage'] != null
        ? BenefitsPackageModel.fromJson(json['benefitsPackage'])
        : null;
    if (json['managerId'] != null) {
      // print(json['manager']);
      manager = EmployeeProfileModel.basicInfoFromJson(json['manager']);
    }
    json['roles'].forEach((element) {
      element.forEach((key, value) {
        if (value == 'Manager') {
          isManager = true;
          //print('manager');
        } else {
          isManager = false;
          //print('employee');
        }
      });
    });
  }
  EmployeeProfileModel.basicInfoFromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    fullName = json['fullName'];
    jobEmail = json['jobEmail'];
    profileImageId = json['profileImageId'];
  }
  Map<String, dynamic> userBasicInfoToJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['fullName'] = fullName;
    json['jobEmail'] = jobEmail;
    json['profileImageId'] = profileImageId;
    return json;
  }
}

class RegionModel {
  int? id;
  String? name;
  String? regionCodeAlphaThree;

  RegionModel({this.id, this.name, this.regionCodeAlphaThree});

  RegionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString().capitalize();
    regionCodeAlphaThree = json['regionCodeAlphaThree'];
  }
}

class PositionModel {
  int? id;
  String? name;
  String? acronym;

  PositionModel({this.id, this.name, this.acronym});

  PositionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    acronym = json['acronym'];
  }
}

class BenefitsPackageModel {
  int? id;
  String? name;
  String? description;
  String? status;
  int? regionId;
  List<BenefitsModel>? benefits;

  BenefitsPackageModel(
      {this.id,
      this.name,
      this.description,
      this.status,
      this.regionId,
      this.benefits});

  BenefitsPackageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    regionId = json['regionId'];
    if (json['benefits'] != null) {
      benefits = <BenefitsModel>[];
      json['benefits'].forEach((v) {
        benefits!.add(BenefitsModel.fromJson(v));
      });
    }
  }
}

class BenefitsModel {
  int? id;
  String? name;
  String? displayName;
  String? description;
  String? iconName;
  int? regionId;
  int? benefitTagId;

  BenefitsModel(
      {this.id,
      this.name,
      this.displayName,
      this.description,
      this.iconName,
      this.regionId,
      this.benefitTagId});

  BenefitsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['displayName'];
    description = json['description'];
    iconName = json['iconName'];
    regionId = json['regionId'];
    benefitTagId = json['benefitTagId'];
  }
}
