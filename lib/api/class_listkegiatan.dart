import 'package:trampillv2/api/class_kegiatan.dart';
import 'dart:convert';

class ListKegiatan {
  final Kegiatan kegiatan;

  ListKegiatan({
    required this.kegiatan,
  });

  factory ListKegiatan.fromJson(Map<String, dynamic> json) {
    return ListKegiatan(
      kegiatan: json['kegiatan']);
  }
}

List<Kegiatan> parseListKegiatan(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Kegiatan>((json) => Kegiatan.fromJson(json)).toList();
}
