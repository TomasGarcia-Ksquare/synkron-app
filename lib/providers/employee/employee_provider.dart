import 'package:flutter/material.dart';
import 'package:synkron_app/models/employee/employee_model.dart';
import 'package:synkron_app/models/employee/employee_project_model.dart';
import 'package:synkron_app/models/employee/employee_timeoff_model.dart';
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import 'package:synkron_app/services/auth/auth_service.dart';
import 'package:synkron_app/services/employee/employee_service.dart';

class EmployeeProvider extends ChangeNotifier {
  EmployeeProfileModel employee = EmployeeProfileModel();
  static List<BenefitsModel> benefitsByLaw = [];
  static List<BenefitsModel> benefitsAditional = [];
  static List<EmployeeProjectModel> projects = [];
  static List<EmployeeTimeOffModel> timeOff = [];

  final AuthService authServices = AuthService();

  loadUserInfo() async {
    await getEmployeeProfileInfo();
    await getEmployeeProjects();
    await getEmployeeTimeOff();
    getEmployeeBenefits();
    return employee;
  }

  getEmployeeProfileInfo() async {
    WsResponse wsResponse = await EmployeeService().fetchEmployeeProfileInfo();
    dynamic data = wsResponse.data;
    employee = EmployeeProfileModel.fromJson(data["data"]);
    if (employee.profileImageId != null) {
      wsResponse =
          await EmployeeService().fetchProfileImage(employee.profileImageId!);
      data = wsResponse.data;
      employee.imagePath = data["data"]["url"];
    }
  }

  getEmployeeProjects() async {
    WsResponse wsResponse = await EmployeeService().fetchEmployeeProjects();
    dynamic resp = wsResponse.data;
    List<EmployeeProjectModel> data = [];
    for (var element in resp["data"]) {
      data.add(EmployeeProjectModel.fromJson(element));
    }
    projects = data;
  }

  getEmployeeBenefits() {
    benefitsByLaw = employee.benefitsPackage!.benefits!
        .where((element) => element.benefitTagId == 2)
        .toList();
    benefitsAditional = employee.benefitsPackage!.benefits!
        .where((BenefitsModel element) => element.benefitTagId == 3)
        .toList();
  }

  getEmployeeTimeOff() async {
    String token = await authServices.getToken();
    if (token.isNotEmpty) {
      WsResponse wsResponse =
          await EmployeeService().fetchEmployeeTimeOffBalance();
      dynamic resp = wsResponse.data;
      List<EmployeeTimeOffModel> data = [];
      for (var element in resp["data"]) {
        if (element["shouldShownInBalance"] == true) {
          data.add(EmployeeTimeOffModel.fromJson(element));
        }
      }
      timeOff = List<EmployeeTimeOffModel>.from(data);
    }
  }
}
