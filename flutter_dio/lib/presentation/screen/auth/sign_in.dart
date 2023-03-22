import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dio/presentation/screen/auth/sign_up.dart';
import 'package:flutter_dio/presentation/screen/main/main_screen.dart';
import 'package:flutter_dio/presentation/widgets/custom_button.dart';
import 'package:flutter_dio/presentation/widgets/text_field_obscure.dart';
import 'package:flutter_dio/state/cubit/auth/auth_cubit.dart';
import 'package:flutter_dio/state/cubit/nodeList/node_list_cubit.dart';
import 'package:flutter_dio/state/cubit/profile/profile_cubit.dart';
import 'package:flutter_dio/user.dart';



class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const routeName = '/signin';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _key = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isObscure = true;
  bool _isValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _key,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if(state is ErrorState){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                }
                if(state is SuccesState){
    //context.read<AuthCubit>().close();

                  Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Expanded(child: SizedBox()),
                    const Text(
                      'Заметки',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 26),
                    ),
                    const Expanded(child: SizedBox()),
                    TextFormField(
                      controller: _loginController,
                      validator: (value) {
                        if (!_isValid) {
                          return null;
                        }
                        if (value!.isEmpty) {
                          return 'Поле логин пустое';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Логин',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (!_isValid) {
                          return null;
                        }
                        if (value!.isEmpty) {
                          return 'Поле пароль пустое';
                        }
                        return null;
                      },
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        suffixIcon: TextFieldObscure(isObscure: (value) {
                          setState(() {
                            isObscure = value;
                          });
                        }),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      content: 'Войти',
                      onPressed: () {
                        _isValid = true;
                        if (_key.currentState!.validate()) {
                          signIn();
                        } else {}
                      },
                    ),
                    const Expanded(flex: 3, child: SizedBox()),
                    InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: () {
                        _loginController.clear();
                        _passwordController.clear();
                        _isValid = false;
                        _key.currentState!.validate();
                        Navigator.pushNamed(context, SignUp.routeName);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Регистрация в системе',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
 
  void signIn() async {
    context.read<AuthCubit>().singIn(User(
      username: _loginController.text,
      password: _passwordController.text
    )).then((value) => context.read<NodeListCubit>().getNodeList()).then((value) => context.read<ProfileCubit>().getUser());
    
    //context.read<ListCubit>().MyFinance();
    //context.read<ProfileCubit>().GetUser();
  }
}
