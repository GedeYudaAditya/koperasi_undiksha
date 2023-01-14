class UserModel {
  final String userId;
  final String username; // email
  final String nama;
  late double saldo;
  final String password;
  final String nomorRekening;

  UserModel({
    required this.userId,
    required this.username,
    required this.nama,
    required this.saldo,
    required this.password,
    required this.nomorRekening,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      username: json['username'],
      nama: json['nama'],
      saldo: double.parse(json['saldo']),
      password: json['password'],
      nomorRekening: json['nomor_rekening'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'nama': nama,
      'saldo': saldo,
      'password': password,
      'nomor_rekening': nomorRekening,
    };
  }
}
