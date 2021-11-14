import 'dart:convert';

class Topic {
  final int materi;
  final int noUrut;
  final String judul;
  final String label;
  final String link;
  final String isiTambahan;
  final int tugas;

  Topic({
    required this.materi,
    required this.noUrut,
    required this.judul,
    required this.label,
    required this.link,
    required this.isiTambahan,
    required this.tugas
    });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      materi: json['materi'],
      noUrut: json['no_urut'],
      judul: json['judul'],
      label: json['label'] ?? "",
      link: json['link'] ?? "",
      isiTambahan: json['isi_tambahan'] ?? "",
      tugas: json['tugas'] ?? 0,
    );
  }
}

// A function that converts a response body into a List<Materi>.
List<Topic> parseTopic(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Topic>((json) => Topic.fromJson(json)).toList();
}

