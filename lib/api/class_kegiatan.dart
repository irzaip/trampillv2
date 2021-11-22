import 'dart:convert';

class Kegiatan {
  final int id;
  final String judulAcara;
  final String statusAcara;
  final String judulMateri;
  final String deskripsi;
  final int rating;
  final String tanggalMulai;
  final String tanggalSelesai;
  final String urlDonasi;

  Kegiatan({
  required this.id,
  required this.judulAcara,
  required this.statusAcara,
  required this.judulMateri,
  required this.deskripsi,
  required this.rating,
  required this.tanggalMulai,
  required this.tanggalSelesai,
  required this.urlDonasi,
});

  factory Kegiatan.fromJson(Map<String, dynamic> json) {
    return Kegiatan(
      id: json['id'],
      judulAcara: json['judul_acara'] ?? "",
      statusAcara: json['status_acara'] ?? "",
      judulMateri: json['judul_materi'] ?? "",
      deskripsi: json['deskripsi'] ?? "",
      rating: json['rating'] ?? 0,
      tanggalMulai: json['tanggal_mulai'] ?? "",
      tanggalSelesai: json['tanggal_selesai'] ?? "",
      urlDonasi: json['url_donasi'] ?? "",

    );
  }
}

// A function that converts a response body into a List<Materi>.
Kegiatan parseKegiatan(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return Kegiatan.fromJson(parsed);
}