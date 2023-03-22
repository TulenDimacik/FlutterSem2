part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class InitialState extends AuthState{}

class ErrorState extends AuthState{
  final String message;

  ErrorState(this.message);
}

class SuccesState extends AuthState{
  final String token;

  SuccesState(this.token);
}
