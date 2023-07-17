Map<String, Map<String, dynamic>> convertListToMap(List data) {
  Map<String, Map<String, dynamic>> map = {};

  for (var element in data) {
    map[element.id!] = element.toMap();
  }
  return map;
}
