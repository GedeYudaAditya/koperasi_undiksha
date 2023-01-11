class UserModel {
  final String userId;
  final String username; // email
  final String nama;
  final double saldo;
  final String nomorRekening;

  UserModel({
    required this.userId,
    required this.username,
    required this.nama,
    required this.saldo,
    required this.nomorRekening,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      username: json['username'],
      nama: json['nama'],
      saldo: double.parse(json['saldo']),
      nomorRekening: json['no_rekening'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'nama': nama,
      'saldo': saldo,
      'no_rekening': nomorRekening,
    };
  }
}
