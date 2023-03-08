// ignore_for_file: unnecessary_string_escapes, non_constant_identifier_names

class Constants {
  final String endpointUrl =
      'https://dev-portalapi.theksquaregroup.com/api/v1/';
  final String microsoftAuth = 'microsoftauth/login';
  final String tokenUrl = 'https://devportal.theksquaregroup.com/login?token=';
  final String authExchangeToken = 'auth/exchange';
  final String authValidateToken = 'auth/validate-token';
  static final EMAIL_REG_EXP = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-=?^_`{|}~]+@([a-zA-Z0-9-]{1,99})\.([a-zA-Z]{2,99})+");
  static final NUMBER_REG_EXP = RegExp(r'\((\d{3})\)\s(\d{3})\-(\d{4})');
  static final SEARCH_STRING_EXP =
      RegExp('^(?:[A-Za-z0-9]+)(?:[A-Za-z0-9-\'\‘\’\&()/|\:, ]*)');

  static final DATE_REG_EXP =
      RegExp(r'^(0[1-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])\/([0-9]{4})$');
  static final NUMBER_ONE_DECIMAL_REG_EXP = RegExp(r'^\d+(\.\d)?$');
  static final NOT_ALLOWED_CHARS_REG_EXP = RegExp(r"[^\w\s&()|\-\:',/]");
  //Home Endpoints
  static const String employeeInfo =
      "employees/self?include=[%22Region%22,%22manager%22,%22position%22]";
  static const String employeeProjects =
      "employees/self/projects?where=%7B%22isActive%22:true,%22projectFilters%22:%7B%22creationStep%22:%22approved%22,%22isGeneral%22:false%7D%7D";
  static const String employeeTimeOff = "time-off-balance/self";
}
