enum SharedPreferencesKey {
  TOKEN,
}

extension SharedPreferencesKeyExtension on SharedPreferencesKey {
  String get key {
    switch (this) {
      case SharedPreferencesKey.TOKEN:
        return 'gestionToken';
      default:
        return 'gestionToken';
    }
  }
}
