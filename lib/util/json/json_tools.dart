List<String> fromListString(String input) {
  return splitAndTrim(input, ',');
}

String toListString(List<String> input) {
  return input.join(', ');
}

List<String> splitAndTrim(String input, String separator) {
  return input.split(separator).map((e) => e.trim()).toList();
}
