extension Captialize on String {
  String get toCapitalize {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
