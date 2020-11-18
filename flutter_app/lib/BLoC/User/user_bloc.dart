import 'package:app/Models/user_model.dart';
import 'package:app/Networking/api_responses.dart';
import 'package:app/Models/paginate_model.dart';
import 'package:app/Repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import '../bloc.dart';

class UserBloc implements Bloc {
  UserRepository _userRepository;
  StreamController _userController;
  String token;

  StreamSink<ApiResponse<UserModel>> get userSink => _userController.sink;

  Stream<ApiResponse<UserModel>> get userDetailStream => _userController.stream;

  UserBloc() {
    _userController = StreamController<ApiResponse<UserModel>>();
    _userRepository = UserRepository();
  }

  fetchUserDetail() async {
    userSink.add(ApiResponse.loading('Đang lấy dữ liệu người dùng'));
    try {
      UserModel userDetailStream = await _userRepository.fetchUserDetail();
      userSink.add(ApiResponse.completed(userDetailStream));
    } catch (e) {
      userSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  @override
  void dispose() {
    _userController.close();
  }
}