import 'dart:convert';



class User {
  final int id;
  final String password;
  final String username;
  final String firstName;
  final String? lastName;
  final String? email;
  final String? dateJoined;
  final String? phone;
  final String? kota;
  final String? kuponAccount;
  final String? lastBalance;
  final String? lastBalanceCreated;
  final String? dateCreated;

  User({
    required this.id,
    required this.password,
    required this.username,
    required this.firstName,
    this.lastName,
    this.email,
    this.dateJoined,
    this.phone,
    this.kota,
    this.kuponAccount,
    this.lastBalance,
    this.lastBalanceCreated,
    this.dateCreated,
  });


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      password: json['password'] ?? "",
      username: json['username'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      email: json['email'] ?? "",
      dateJoined: json['dateJoined'] ?? "",
      phone: json['phone'] ?? "",
      kota: json['kota'] ?? "",
      kuponAccount: json['kupon_account'] ?? "",
      lastBalance: json['last_balance'] ?? "",
      lastBalanceCreated: json['last_balance_created'] ?? "",
      dateCreated: json['date_created'] ?? "",
    );
  }
}

User parseUser(String responseBody) {
  //final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  final parsed = User.fromJson(jsonDecode(responseBody));
  // return parsed.map<User>((json) => User.fromJson(json));
  return parsed;
}

