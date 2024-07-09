abstract class AuthState {}

class InitialState extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String errors;

  RegisterFailure(this.errors);
}

class RegisterLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String errors;

  LoginFailure(this.errors);
}

class LoginLoading extends AuthState {}

class ForgetSuccess extends AuthState {}

class ForgetFailure extends AuthState {
  final String errors;

  ForgetFailure(this.errors);
}

class ForgetLoading extends AuthState {}
