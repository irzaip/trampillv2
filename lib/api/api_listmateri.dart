import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<List<ListMateri>> ApiListMateri() async {
  const String api = '/api/listmateri';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String access = prefs.getString("access").toString();
  String fulltoken = 'Bearer '+ access; 
  String mainhome = prefs.getString("mainhome").toString();

  final request = await http.get(Uri.parse(mainhome + api), headers: {HttpHeaders.authorizationHeader : fulltoken});
  if (request.statusCode == 200) {
    return compute(parseListMateri, request.body);
  } else if (request.statusCode == 401) {
    throw Exception('Token Expired or Failed Login');
  } else {
    throw Exception('Failed to load List Materi');
  }  
}

// A function that converts a response body into a List<ListMateri>.
List<ListMateri> parseListMateri(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<ListMateri>((json) => ListMateri.fromJson(json)).toList();
}


class ListMateri {
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

  ListMateri({
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
  });

  factory ListMateri.fromJson(Map<String, dynamic> json) {
      return ListMateri(
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
        pengajar: json['pengajar'], 
        tentangPengajar: json['tentang_pengajar'] ?? '.', 
        hidden: json['hidden'] ?? false, 
        featured: json['featured'] ?? false, 
        frontpage: json['frontpage'] ?? false, 
        playlist: json['playlist'] ?? false,
        );
    }
}
