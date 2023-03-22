

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dio/common/app_env.dart';
import 'package:flutter_dio/user.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.dio) : super(ProfileState(userName: '', email: ''));
 
  final Dio dio;

   Future<void> getUser()async{
      try{
        var result = await dio.get(AppEnv.userData);
        var data = User.fromJson(result.data);
        if(result.statusCode == 200){
          emit(ProfileState(userName: data.username,email: data.email!));
        }
      } on DioError catch(e){
      }
    }

    Future<void> updateUser(User user)async{
    try{
      var result = await dio.post(AppEnv.userData,data: user);
      if(result.statusCode == 200){
        print('Изменил данные пользователя');
        var result = await dio.get(AppEnv.userData);
        var data = User.fromJson(result.data);
        if(result.statusCode == 200){
          emit(ProfileState(userName: data.username,email: data.email!));
        }
      }
    } on DioError catch(e){
      print(e.response!.data['message']);
    }
    }

    Future<void> updateUserPassword(String oldPassword, String newPassword)async{
    try{
      var result = await dio.put(AppEnv.userData+'?newPassword='+newPassword+'&oldPassword='+oldPassword);
      if(result.statusCode == 200){
        print('Изменил данные пользователя');
      }
      else
      {
        print('Старый пароль не тот');
      }
    } on DioError catch(e){
      print(e.response!.data['message']);
    }
    }

  
}