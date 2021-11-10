import 'class_materi.dart';
import 'dart:convert';

class Favorit {
  Materi materi;

  Favorit({required this.materi});

  factory Favorit.fromJson(Map<String, dynamic> parsedJson) {
    return Favorit(materi: Materi.fromJson(parsedJson['materi']));
  }
}

List<Favorit> parseListFavorit(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Favorit>((json) => Favorit.fromJson(json)).toList();
}
