import 'dart:convert';

List<String> cityListFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));
