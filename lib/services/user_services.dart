import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:koperasi_undiksha/models/user_model.dart';
import 'package:koperasi_undiksha/references/user_references.dart';

class UserServices extends ChangeNotifier {
  UserReferences userReferences = UserReferences();
  ChangeNotifier changeNotifier = ChangeNotifier();

  String baseUrl = 'http://apikoperasi.rey1024.com/';

  // get single user dari api
  Future<List<UserModel?>> getUser({required String userId}) async {
    Dio dio = Dio();
    String url = '${baseUrl}getsingleuser';

    final Response response;

    try {
      response = await dio.post(
        url,
        data: {
          "user_id": userId,
        },
      );

      // mengecek apakah berhasil dengan mengecek status code
      if (response.statusCode == 200) {
        var json = response.data;
        var data = json;

        if (data[0]['nama'] != null && data[0]['nama'] != '') {
          if (data is List) {
            List<UserModel> user =
                data.map<UserModel>((u) => UserModel.fromJson(u)).toList();

            // print(user[0].nama);
            notifyListeners();

            return user;
          }
        } else {
          return [null];
        }
      }
      return [null];
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  // get all user dari api
  Future<List<UserModel?>> getAllUser() async {
    Dio dio = Dio();
    String url = '${baseUrl}users';

    final Response response;

    try {
      response = await dio.get(url);

      // mengecek apakah berhasil dengan mengecek status code
      if (response.statusCode == 200) {
        var json = response.data;
        var data = json;

        if (data[0]['nama'] != null && data[0]['nama'] != '') {
          if (data is List) {
            dynamic user =
                data.map<UserModel>((u) => UserModel.fromJson(u)).toList();

            // print(data);
            notifyListeners();
            return user;
          }
        } else {
          return [null];
        }
      }
      return [null];
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  // login user
  Future<List<UserModel?>> loginUser(
      {required String username, required String password}) async {
    Dio dio = Dio();
    String url = baseUrl;

    final Response response;

    try {
      response = await dio.post(
        url,
        data: {
          "username": username,
          "password": password,
        },
      );

      // mengecek apakah berhasil dengan mengecek status code
      if (response.statusCode == 200) {
        var json = response.data;
        var data = json;

        if (data[0]['nama'] != null && data[0]['nama'] != '') {
          if (data is List) {
            dynamic user =
                data.map<UserModel>((u) => UserModel.fromJson(u)).toList();

            // simpan data user ke shared preferences
            userReferences.setUserId(user[0].userId);
            userReferences.setUserName(user[0].username);
            userReferences.setNama(user[0].nama);
            userReferences.setSaldo(user[0].saldo);
            userReferences.setNomorRekening(user[0].nomorRekening);

            // print(data);

            notifyListeners();
            return user;
          }
        } else {
          return [null];
        }
      }
      return [null];
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  // register user
  Future<bool?> registerUser(
      {required String username,
      required String nim,
      required String password,
      required String nama}) async {
    Dio dio = Dio();
    String url = '${baseUrl}register';

    final Response response;

    try {
      response = await dio.post(
        url,
        data: {
          "username": username,
          "password": password,
          "nama": nama,
          "nim": nim,
        },
      );

      // mengecek apakah berhasil dengan mengecek status code
      if (response.statusCode == 200) {
        var json = response.data;
        var data = json;

        if (data['nama'] != null && data['nama'] != '') {
          // UserModel user = UserModel.fromJson(data);

          // simpan data user ke shared preferences
          // userReferences.setUserId(user.userId);
          // userReferences.setUserName(user.username);
          // userReferences.setNama(user.nama);
          // userReferences.setSaldo(user.saldo);
          // userReferences.setNomorRekening(user.nomorRekening);

          notifyListeners();
          return true;
        } else {
          return false;
        }
      }
      return false;
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }
}
