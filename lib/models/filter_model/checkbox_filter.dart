class CheckboxFilterModel {
  final String filterTitle;
  final String filterTitleQuery;
  bool isExpanded;
  List<dynamic> options;
  List<dynamic> optionsQuery;
  List<bool> optionsValuesTemp;
  List<bool> optionsValues;

  CheckboxFilterModel(
      {required this.filterTitle,
      required this.filterTitleQuery,
      required this.options,
      required this.optionsQuery,
      required this.optionsValuesTemp,
      required this.optionsValues,
      this.isExpanded = false});
}
