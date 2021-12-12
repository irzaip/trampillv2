import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trampillv2/api/class_user.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:trampillv2/values/fontstyle.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const String routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User> profil;

@override
  void initState() {
    profil = getProfile();
    super.initState();
  }

  Future<User> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String api = '/api/userprofile/';
    String access = prefs.getString("access").toString();
    String fulltoken = 'Bearer ' + access;
    String mainhome = prefs.getString("mainhome").toString();


    final request = await http.get(
      Uri.parse(mainhome + api),
      headers: {HttpHeaders.authorizationHeader: fulltoken}
    );

    if (request.statusCode == 200) {
      var parsed = compute(parseUser, request.body);
      return parsed;
    } else {
      throw("Error get profile");
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"),),
      body: FutureBuilder(
        future: profil,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return ProfileCard(snapshot);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }

        },),
    );
  }

  SafeArea ProfileCard(AsyncSnapshot<dynamic> snapshot) {
    return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    infoText("username :",snapshot.data.username),
                    infoText("Nama :", snapshot.data.firstName + " " + snapshot.data.lastName),
                    infoText("eMail :",snapshot.data.email),
                    infoText("data Joined :",snapshot.data.dateJoined),
                    infoText("Phone :", snapshot.data.phone),
                    infoText("Kota :",snapshot.data.kota),
                    infoText("Kupon Account :" ,snapshot.data.kuponAccount),
                    infoText("Last Balance : ", snapshot.data.lastBalance),
                    infoText("Last Balance Created :", snapshot.data.lastBalanceCreated),
                    infoText("Date Created :",snapshot.data.dateCreated),
                  ],
                ),
              ),
            ),
          );
  }

  Widget infoText(judul, isi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(judul, style: titlefont),
      SizedBox(height: 6,),
      Text(isi, style: mediumfont),
      SizedBox(height: 8,),
      Divider(),
    ],);
  }

}
