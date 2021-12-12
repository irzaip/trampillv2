import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trampillv2/values/fontstyle.dart';

  /// Fungsi menghitung discount dan menampilkan dalam bentuk string
  String hitungharga(harga, discount) {
    var total = harga - (harga * discount / 100);
    if (harga != 0 && discount != 100) {
      total = total.floor();
      return NumberFormat.currency(
              locale: 'id', decimalDigits: 0, symbol: 'Rp ')
          .format(harga)
          .toString();
    } else {
      return "Gratis";
    }
  }

  /// Fungsi menghitung discount dan menampilkan dalam bentuk string
  String hitungdiscount(harga, discount) {
    var total = harga - (harga * discount / 100);
    total = total.floor();
    if (total != 0) {
      total = total.floor();
      return NumberFormat.currency(
              locale: 'id', decimalDigits: 0, symbol: 'Rp ')
          .format(total)
          .toString();
      // return discount.toString();
    } else {
      return "";
    }
  }

  /// menampilkan harga dalam bentuk coret, apabila berlaku discount.
  TextStyle fontharga(harga, discount) {
    if (harga != 0 && discount != 0 && discount != 100) {
      return hargacoret;
    } else {
      return hargafont;
    }
  }

