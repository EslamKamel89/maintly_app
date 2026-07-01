List<T> getUniqueListByProperty<T>(List<T> list, Function(T) getProperty) {
  final seen = <T>{};
  return list.where((x) => seen.add(getProperty(x))).toList();
}
