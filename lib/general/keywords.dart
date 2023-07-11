List<String> getKeywords(String value) {
  List<String> keywords = [];
  String spString = "";
  List<String> splitedStringList = value.split('');
  for (var element in splitedStringList) {
    keywords.add(spString += element.replaceAll(" ", "").toLowerCase());
  }
  return keywords;
}
