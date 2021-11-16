import 'package:intl/intl.dart';

abstract class Validators {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) return 'Campo requerido';
    email = email.trim();
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern as String);
    if (email == null || email.isEmpty)
      return 'Campo requerido';
    else if (!regExp.hasMatch(email)) return 'Correo inválido';
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) return 'Campo requerido';
    password = password.trim();
    Pattern pattern = r'^(?=.{8,}$)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])\S*$';
    RegExp regExp = RegExp(pattern as String);
    if (password == null || password.isEmpty) return 'Campo requerido';
    if (password.length < 8) return "La contraseña debe contener 8 caracteres";
    // if (!regExp.hasMatch(password))
    //   return 'Tu contraseña debe contener al menos una mayúscula y un número';
    return null;
  }

  static String? notEmptyValidator(String? text) {
    if (text == null || text.isEmpty) return 'Campo requerido';
    return null;
  }

  static String? passwordConfirmationValidator(
          String password, String passwordConfirmation) =>
      password == passwordConfirmation ? null : 'Las contraseñas no coinciden';

  static String? newPasswordValidator(String oldPassword, String newPassword) {
    if (oldPassword == newPassword)
      return 'La nueva contraseña no puede ser igual';
    return passwordValidator(newPassword);
  }
}
