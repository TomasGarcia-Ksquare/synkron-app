class TimesheetMyTeam {
  int id;
  List<TimesheetModel> myTeam;

  TimesheetMyTeam({required this.id, required this.myTeam});
}

class TimesheetModel {
  final int id;
  final String startDate;
  final String endDate;
  final String status;
  final String comment;
  final String workedHours;
  final TimesheetEmployee employee;
  final ProjectModel projectModel;
  final List<WorkShiftModel> workShiftList;

  TimesheetModel(
      {required this.startDate,
      required this.endDate,
      required this.projectModel,
      required this.employee,
      required this.workShiftList,
      required this.id,
      required this.status,
      required this.comment,
      required this.workedHours});

  @override
  String toString() {
    return '{starDate: $startDate, endDate: $endDate, workedHours: $workedHours, employeeName: $employee, projectsInfo: $projectModel, workShift: $workShiftList}';
  }
}

class TimesheetEmployee {
  TimesheetEmployee({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.secondLastName,
    required this.fullName,
  });

  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String secondLastName;
  final String fullName;

  factory TimesheetEmployee.fromJson(Map<String, dynamic> json) =>
      TimesheetEmployee(
        id: json["id"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        secondLastName: json["secondLastName"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "secondLastName": secondLastName,
        "fullName": fullName,
      };

  @override
  String toString() {
    return '{fullName: $fullName}';
  }
}

class ProjectModel {
  final int id;
  final String name;
  final String description;

  ProjectModel(
      {required this.id, required this.name, required this.description});

  @override
  String toString() {
    return '{id: $id, name: $name}';
  }
}

class WorkShiftModel {
  final int id;
  String hours;
  final String date;
  final int timesheetId;
  final String createdAt;
  final String updatedAt;

  WorkShiftModel(
      {required this.id,
      required this.hours,
      required this.date,
      required this.timesheetId,
      required this.createdAt,
      required this.updatedAt});

  @override
  String toString() {
    return '{id : $id, hours: $hours, date: $date, timesheetId: $timesheetId}';
  }
}

class Status {
  static const String approved = 'approved';
  static const String reject = 'rejected';
}
