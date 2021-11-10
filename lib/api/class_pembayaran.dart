import 'class_materi.dart';
import 'dart:convert';

class Pembayaran {
  final String no_order;
  final int harga;
  final String status;
  final Materi materi;

  Pembayaran({
    required this.no_order,
    required this.harga,
    required this.status,
    required this.materi
    });

  factory Pembayaran.fromJson(Map<String, dynamic> parsedJson) {
    return Pembayaran(
      no_order: parsedJson['no_order'],
      status:  parsedJson['status'],
      harga: parsedJson['harga'],
      materi: Materi.fromJson(parsedJson['materi']));
  }
}

List<Pembayaran> parseListPembayaran(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Pembayaran>((json) => Pembayaran.fromJson(json)).toList();
}
