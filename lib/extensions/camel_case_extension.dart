extension CapitalizeExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}