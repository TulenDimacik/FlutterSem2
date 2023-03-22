import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dio/common/app_env.dart';
import 'package:flutter_dio/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';



part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.dio) : super(InitialState());

  final Dio dio;
  
  Future<void> singUp(User user)async{
    try{
      var result = await dio.put(AppEnv.auth,data: user);

      var data = User.fromJson(result.data['data']);
      if(result.statusCode == 200){
        if(data.token == null){
          throw DioError(requestOptions: RequestOptions(path: ''),error: 'Токен равен нулю');
        }
        //emit(SuccesState());
      }
    } on DioError catch(e){
      emit(ErrorState(e.response!.data['message']));
    }
  }

  saveValue(String accessToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('accessToken', accessToken);
  } 

  Future<void> singIn(User user)async{
    try{
      //saveValue('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NzY2NTg3OTYsImlhdCI6MTY3NjU3MjM5NiwiaWQiOjF9.cSDpOaz90VmUc_kOTxpJS82MVptibOFCErhHkC8jdmA');
      var result = await dio.post(AppEnv.auth,data: user);

      var data = User.fromJson(result.data['data']);
      if(result.statusCode == 200){
        emit(SuccesState(data.accessToken.toString()));
        if(data.token == null){
          throw DioError(requestOptions: RequestOptions(path: ''),error: 'Токен равен нулю');
        }
        await saveValue(data.accessToken!);
       // SharedPreferencesUtil.saveData<String>("accessToken", data.accessToken!);
      }
    } on DioError catch(e){
      emit(ErrorState(e.response!.data['message']));
    }
  }

  
}
