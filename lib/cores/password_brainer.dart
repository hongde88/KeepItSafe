import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:keep_it_safe/constants.dart' as Constants;

class PasswordBrainer {
  static String generateHashedPassword(password) {
    final raw = utf8.encode(password);
    final digest = sha256.convert(raw);
    return digest.toString();
  }

  static String generateARandomPassword(securityLevel) {
    if (securityLevel == Constants.SecurityLevel['low']) {
    } else if (securityLevel == Constants.SecurityLevel['medium']) {
    } else if (securityLevel == Constants.SecurityLevel['high']) {}

    return null;
  }
}
