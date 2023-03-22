import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dio/presentation/screen/auth/sign_in.dart';
import 'package:flutter_dio/presentation/screen/auth/sign_up.dart';
import 'package:flutter_dio/presentation/screen/main/main_screen.dart';
import 'package:get_it/get_it.dart';

import 'locator_service.dart';
import 'state/cubit/auth/auth_cubit.dart';
import 'state/cubit/nodeList/node_list_cubit.dart';
import 'state/cubit/nodeParametrs/node_parametrs_cubit.dart';
import 'state/cubit/profile/profile_cubit.dart';
import 'package:flutter_dio/node.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
  //await Dio().put('http://127.0.0.1:8081/token', data: User(userName: 'qwe', email: 'qwe@mail.ru', password: '123'));
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignIn.routeName: (context) => MultiBlocProvider(
          providers: [
              BlocProvider<AuthCubit>.value(
                  value: sl<AuthCubit>()
              ),
              BlocProvider<NodeListCubit>.value(
                  value: sl<NodeListCubit>()
              ),
              BlocProvider<ProfileCubit>.value(
                  value: sl<ProfileCubit>()
              ),
          ],
          child: const SignIn(),
        ),
        SignUp.routeName: (context) => MultiBlocProvider(
          providers: [
              BlocProvider<AuthCubit>.value(
                  value: sl<AuthCubit>(),
                  child: SignUp(),
              ),
          ],
          child: const SignUp(),
        ),
        MainScreen.routeName: (context) => MultiBlocProvider(
          providers: [
              BlocProvider<NodeListCubit>.value(
                  value: sl<NodeListCubit>()
              ),
              BlocProvider<NodeParametrsCubit>.value(
                  value: sl<NodeParametrsCubit>()
              ),
              BlocProvider<ProfileCubit>.value(
                  value: sl<ProfileCubit>()
              ),
          ],
          child: const MainScreen(),
        ),

        /*FinanceData.routeName: (context) => const FinanceData(),
        SignUp.routeName: (_) => BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: SignUp(),
            ),
        SignIn.routeName: (_) => BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: SignIn(),
            ),*/
      },
    initialRoute: SignIn.routeName,
    );
  }
}
