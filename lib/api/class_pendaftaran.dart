import 'class_materi.dart';
import 'dart:convert';

class Pendaftaran {
  Materi materi;

  Pendaftaran({required this.materi});

  factory Pendaftaran.fromJson(Map<String, dynamic> parsedJson) {
    return Pendaftaran(materi: Materi.fromJson(parsedJson['materi']));
  }
}

List<Pendaftaran> parseListPendaftaran(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Pendaftaran>((json) => Pendaftaran.fromJson(json)).toList();
}