import 'class_materi.dart';
import 'dart:convert';

class Pembayaran {
  final String noOrder;
  final int harga;
  final String status;
  final Materi materi;

  Pembayaran({
    required this.noOrder,
    required this.harga,
    required this.status,
    required this.materi
    });

  factory Pembayaran.fromJson(Map<String, dynamic> parsedJson) {
    return Pembayaran(
      noOrder: parsedJson['no_order'],
      status:  parsedJson['status'],
      harga: parsedJson['harga'],
      materi: Materi.fromJson(parsedJson['materi']));
  }
}

List<Pembayaran> parseListPembayaran(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Pembayaran>((json) => Pembayaran.fromJson(json)).toList();
}
