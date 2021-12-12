

class Materi {
  final int id;
  final String judul;
  final String kode;
  final String rating;
  final String pendek;
  final String deskripsi;
  final String gambar;
  final String kategori;
  final String copywrite;
  final List<dynamic> tags;
  final int harga;
  final int discount;
  final String pengajar;
  final String tentangPengajar;
  final bool hidden;
  final bool featured;
  final bool frontpage;
  final bool playlist;
  final bool password;

  Materi({
    required this.id,
    required this.kode,
    required this.judul,
    required this.rating,
    required this.pendek,
    required this.deskripsi,
    required this.gambar,
    required this.kategori,
    required this.copywrite,
    required this.tags,
    required this.harga,
    required this.discount,
    required this.pengajar,
    required this.tentangPengajar,
    required this.hidden,
    required this.featured,
    required this.frontpage,
    required this.playlist,
    required this.password,
  });

  factory Materi.fromJson(Map<String, dynamic> json) {
      return Materi(
        id: json['id'], 
        kode: json['kode'], 
        judul: json['judul'],
        rating: json['rating'], 
        pendek: json['pendek'], 
        deskripsi: json['deskripsi'] ?? '.', 
        gambar: json['gambar'] ?? '.', 
        kategori: json['kategori'], 
        copywrite: json['copywrite'] ?? '.', 
        tags: json['tags'] ?? ['.'], 
        harga: json['harga'], 
        discount: json['discount'], 
        pengajar: json['pengajar'].toString(), 
        tentangPengajar: json['tentang_pengajar'] ?? '.', 
        hidden: json['hidden'] ?? false, 
        featured: json['featured'] ?? false, 
        frontpage: json['frontpage'] ?? false, 
        playlist: json['playlist'] ?? false,
        password: json['password'] ?? false,
        );
    }
}
