import 'package:flutter/material.dart';
import 'package:synkron_app/models/employee/employee_model.dart';
import 'package:synkron_app/models/employee/employee_timeoff_model.dart';
import 'package:synkron_app/models/time_off/time_off_attachment_model.dart';
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import 'package:synkron_app/providers/employee/employee_provider.dart';
import 'package:synkron_app/providers/employee/time_off/time_off_hours_controller.dart';
import 'package:synkron_app/services/employee/employee_service.dart';
import 'package:synkron_app/services/time_off/time_off_service.dart';
import 'package:synkron_app/utils/constants.dart';

class TimeOffRequestProvider extends ChangeNotifier {
  EmployeeProvider userProvider = EmployeeProvider();
  EmployeeProfileModel user = EmployeeProfileModel();
  EmployeeProfileModel userManager = EmployeeProfileModel();
  TimeOffService timeOffService = TimeOffService();
  TimeOffAttachmentModel timeOffAttachmentModel = TimeOffAttachmentModel();
  bool loading = false;
  List<EmployeeTimeOffModel> timeOffAvailable = [];
  TextEditingController startDateCtrl = TextEditingController();
  TextEditingController endDateCtrl = TextEditingController();
  TextEditingController timeCtrl = TextEditingController();
  TextEditingController commentsCtrl = TextEditingController();
  bool formfilled = false;
  bool edited = false;
  bool enableTextformfields = false;
  bool validDateRange = true;
  var lastTimeOffDay;
  var currentTimeOffId;
  int maxHours = 0;
  int maxDays = 0;
  bool maxTimeError = false;
  bool minTime = false;
  int daysInRange = 0;
  EmployeeTimeOffModel timeOff = EmployeeTimeOffModel();
  dynamic startInitialValue;
  dynamic endInitialValue;
  WsResponse createdTimeOffRequest = WsResponse(success: false);
  Map errors = {
    'maxTime': false,
    'minTime': false,
  };
  void setCurrentTimeOff(index) {
    currentTimeOffId = index;
    timeOff =
        timeOffAvailable.firstWhere((element) => element.benefitId == index);
    enableTextformfields = true;
    startInitialValue = null;
    endInitialValue = null;
    lastTimeOffDay = null;
    maxHours = 0;
    maxDays = 0;
    daysInRange = 0;
    clearInputs();
    noEmptyFields();
    notifyListeners();
  }

  EmployeeTimeOffModel findTimeOffByDisplayName(
      List<EmployeeTimeOffModel> timeOffAvailable, String displayName) {
    return timeOffAvailable
        .firstWhere((element) => element.displayName == displayName);
  }

  getCurrentTimeOffId() {
    return currentTimeOffId;
  }

  getCurrentTimeOff() {
    return timeOff;
  }

  getUserInfo() async {
    loading = true;
    validDateRange = true;
    currentTimeOffId = null;
    edited = false;
    formfilled = false;
    enableTextformfields = false;
    maxHours = 0;
    maxDays = 0;
    maxTimeError = false;
    daysInRange = 0;
    clearInputs();
    user = await userProvider.loadUserInfo();
    if (user.manager != null) {
      userManager = user.manager!;
      if (userManager.profileImageId != null) {
        WsResponse wsResponse = await EmployeeService()
            .fetchProfileImage(userManager.profileImageId!);
        dynamic data = wsResponse.data;
        userManager.imagePath = data["data"]["url"];
      }
    }
    await getUserTimeOff();
    setCurrentTimeOff(
        findTimeOffByDisplayName(timeOffAvailable, 'Paid Time Off (PTO)')
            .benefitId);
    loading = false;
    notifyListeners();
  }

  getUserTimeOff() async {
    WsResponse wsResponse =
        await EmployeeService().fetchEmployeeTimeOffBalance();
    dynamic resp = wsResponse.data;
    List<EmployeeTimeOffModel> data = [];
    for (var element in resp["data"]) {
      if (element["availableHours"] > 0 &&
          element['requestedHours'] < element['availableHours']) {
        data.add(EmployeeTimeOffModel.fromJson(element));
      }
    }
    timeOffAvailable = data;
  }

  addTextFormFieldsListeners() {
    startDateCtrl.addListener(() {
      startDateInitialValue();
      manageSelectedDates();
      noEmptyFields();
      setLastTimeOffDay();
      if (isValidSelectedRange() != null && !isValidSelectedRange()) {
        endDateCtrl.clear();
        timeCtrl.clear();
      }
    });
    endDateCtrl.addListener(() {
      startDateInitialValue();
      manageSelectedDates();
      noEmptyFields();
    });
    timeCtrl.addListener(() {
      noEmptyFields();
    });
    commentsCtrl.addListener(() {
      noEmptyFields();
    });
  }

  removeErrors() {
    errors.forEach((key, value) {
      errors[key] = false;
    });
  }

  removeInputListeners() {
    startDateCtrl.removeListener(() => noEmptyFields());
    endDateCtrl.removeListener(() => noEmptyFields());
    timeCtrl.removeListener(() => noEmptyFields());
    commentsCtrl.removeListener(() => noEmptyFields());
  }

  disposeTextFormFieldsCtrl() {
    startDateCtrl.dispose();
    endDateCtrl.dispose();
    timeCtrl.dispose();
    commentsCtrl.dispose();
  }

  setLastTimeOffDay() {
    if (currentTimeOffId != null) {
      if (timeOff.timeUnit == 'days' && startDateCtrl.text.isNotEmpty) {
        DateTime startDate =
            TimeOffHoursController().stringToDate(startDateCtrl.text);
        int availableDays =
            (timeOff.availableHours! - timeOff.requestedHours!) ~/ 8;
        var days =
            TimeOffHoursController().getLastDay(startDate, availableDays);
        lastTimeOffDay = days.last;
        notifyListeners();
        return days;
      }
    }
  }

  startDateInitialValue() {
    if (startDateCtrl.text.isEmpty && endDateCtrl.text.isEmpty) {
      startInitialValue = DateTime.now();
      endInitialValue = DateTime.now();
    }
    if (startDateCtrl.text.isNotEmpty) {
      startInitialValue =
          TimeOffHoursController().stringToDate(startDateCtrl.text);
      endInitialValue = startInitialValue;
    }
    if (startDateCtrl.text.isEmpty && endDateCtrl.text.isNotEmpty) {
      startInitialValue = null;
      endInitialValue = TimeOffHoursController().stringToDate(endDateCtrl.text);
    }
    if (endDateCtrl.text.isNotEmpty) {
      if (startDateCtrl.text.isNotEmpty &&
          endDateCtrl.text.isNotEmpty &&
          TimeOffHoursController().stringToDate(startDateCtrl.text).isAfter(
              TimeOffHoursController().stringToDate(endDateCtrl.text))) {
        endInitialValue = startInitialValue;
        endDateCtrl.text = startDateCtrl.text;
      } else {
        endInitialValue =
            TimeOffHoursController().stringToDate(endDateCtrl.text);
      }

      notifyListeners();
    }
  }

  manageSelectedDates() {
    if (currentTimeOffId != null &&
        startDateCtrl.text.isNotEmpty &&
        endDateCtrl.text.isNotEmpty) {
      DateTime startDate =
          TimeOffHoursController().stringToDate(startDateCtrl.text);
      DateTime endDate =
          TimeOffHoursController().stringToDate(endDateCtrl.text);

      var notRequestedHrs = timeOff.availableHours! - timeOff.requestedHours!;
      var numDays = TimeOffHoursController()
          .getWeekdaysBetween(startDate, endDate)
          .length;
      daysInRange = numDays;
      if (!startDate.isAfter(endDate)) {
        validDateRange = true;
        notifyListeners();
        var diffOnDays = endDate.difference(startDate).inDays + 1;
        var hrsPerDay = diffOnDays * 8;

        if (notRequestedHrs >= hrsPerDay) {
          if (timeOff.timeUnit == 'hrs') {
            timeCtrl.text = hrsPerDay.toString();
            maxHours = hrsPerDay;
          } else {
            timeCtrl.text = numDays.toString();
            maxDays = numDays;
          }
          notifyListeners();
        } else {
          if (timeOff.timeUnit == 'hrs') {
            timeCtrl.text = notRequestedHrs.toString();
            maxHours = notRequestedHrs;
            notifyListeners();
          } else {
            timeCtrl.text = numDays.toString();
            maxDays = numDays;
          }

          notifyListeners();
        }
      } else {
        validDateRange = false;
        notifyListeners();
      }
    }
  }

  noEmptyFields() {
    if (currentTimeOffId != null &&
        startDateCtrl.text.isNotEmpty &&
        endDateCtrl.text.isNotEmpty &&
        timeCtrl.text.isNotEmpty) {
      edited = true;
      formfilled = true;
      removeErrors();
      notifyListeners();
    } else if (edited == true &&
        (currentTimeOffId == null ||
            startDateCtrl.text.isEmpty ||
            endDateCtrl.text.isEmpty ||
            timeCtrl.text.isEmpty)) {
      formfilled = false;
      notifyListeners();
    } else {
      formfilled = false;
    }
  }

  clearInputs() {
    endDateCtrl.clear();
    startDateCtrl.clear();
    timeCtrl.clear();
    commentsCtrl.clear();
  }

  isValidSelectedRange() {
    if (timeOff.timeUnit == 'days' &&
        endDateCtrl.text.isNotEmpty &&
        startDateCtrl.text.isNotEmpty) {
      var selected = TimeOffHoursController()
          .getWeekdaysBetween(
              TimeOffHoursController().stringToDate(startDateCtrl.text),
              TimeOffHoursController().stringToDate(endDateCtrl.text))
          .length;
      int availableDays =
          (timeOff.availableHours! - timeOff.requestedHours!) ~/ 8;
      if (selected > availableDays) {
        return false;
      } else {
        return true;
      }
    }
  }

  sanitizeInputs(RegExp notAllowed, String text) {
    return text.replaceAll(notAllowed, '');
  }

  createTimeOffRequest() async {
    removeErrors();
    notifyListeners();
    if (formfilled) {
      String sanitizedComments = sanitizeInputs(
          Constants.NOT_ALLOWED_CHARS_REG_EXP, commentsCtrl.text);
      String sanitizedStartDate =
          sanitizeInputs(RegExp(r"[^0-9/]+"), startDateCtrl.text);
      String sanitizedEndDate =
          sanitizeInputs(RegExp(r"[^0-9/]+"), endDateCtrl.text);
      String sanitizedTime = sanitizeInputs(RegExp(r'[^0-9]'), timeCtrl.text);
      DateTime startDate =
          TimeOffHoursController().stringToDate(sanitizedStartDate);
      DateTime endDate =
          TimeOffHoursController().stringToDate(sanitizedEndDate);

      List hoursPerDayList = [];
      var weekdaysInRange =
          TimeOffHoursController().getWeekdaysBetween(startDate, endDate);
      int hours = (int.parse(sanitizedTime) ~/ weekdaysInRange.length).floor();
      if (timeOff.timeUnit == 'days') {
        hours = hours * 8;
      }

      int requestedHrs = 0;
      for (int i = 0; i < weekdaysInRange.length; i++) {
        var hoursPerDAy = {
          'hours': hours,
          'date': weekdaysInRange[i].toString(),
        };
        hoursPerDayList.add(hoursPerDAy);
        requestedHrs = requestedHrs + hours;
      }
      if (timeOff.timeUnit == 'hrs') {
        if (maxHours < requestedHrs) {
          errors['maxTime'] = true;
          notifyListeners();
          return WsResponse(
            success: false,
            data: {},
          );
        }
        if (requestedHrs < weekdaysInRange.length || requestedHrs == 0) {
          errors['minTime'] = true;
          notifyListeners();
          return WsResponse(
            success: false,
            data: {},
          );
        }
      }

      var body = {
        "requestedHours": requestedHrs,
        "hoursPerDayList": hoursPerDayList,
        "startDate": startDate.toString(),
        "endDate": endDate.toString(),
        "approverId": user.manager!.id,
        "employeeId": user.id,
        "benefitId": timeOff.benefitId,
        'comments': sanitizedComments,
      };
      WsResponse wsResponse = await TimeOffService().createTimeOffRequest(body);
      return wsResponse;
    }
  }

  //attachment the photo id with the time off request id
  Future<WsResponse> attachImageToTimeOffRequest(
      String fileName, int timeOffRequestId, int imageFileId) async {
    var body = {
      "type": "image/jpeg",
      "fileName": fileName,
      "path": "image/jpeg/$fileName",
      "timeOffRequestId": timeOffRequestId,
      "attachmentId": imageFileId
    };
    WsResponse response =
        await TimeOffService().attachImageToTimeOffRequest(body);
    notifyListeners();
    return response;
  }
}
