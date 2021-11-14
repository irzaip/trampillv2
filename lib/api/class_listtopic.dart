import 'dart:convert';

class ListTopic {
  final int materi;
  final int noUrut;
  final String judul;
  final String label;

  ListTopic({
    required this.materi,
    required this.noUrut,
    required this.judul,
    required this.label,
    });

  factory ListTopic.fromJson(Map<String, dynamic> json) {
    return ListTopic(
      materi: json['materi'],
      noUrut: json['no_urut'],
      judul: json['judul'],
      label: json['label'] ?? "",
    );
  }
}

// A function that converts a response body into a List<Materi>.
List<ListTopic> parseListTopic(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<ListTopic>((json) => ListTopic.fromJson(json)).toList();
}

