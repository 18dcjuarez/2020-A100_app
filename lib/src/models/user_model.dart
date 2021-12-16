import 'dart:convert';

class UserModel {
  final String? email;
  final String? nombre;
  final String? apPaterno;
  final String? apMaterno;
  final String? idIpn;
  final String? tarjetaAsistencia;
  final String? rol;
  final int? departamento;

  const UserModel(
      {this.email,
      this.nombre,
      this.apPaterno,
      this.apMaterno,
      this.idIpn,
      this.tarjetaAsistencia,
      this.rol,
      this.departamento});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nombre': nombre,
      'apPaterno': apPaterno,
      'apMaterno': apMaterno,
      'idIpn': idIpn,
      'tarjetaAsistencia': tarjetaAsistencia,
      'rol': rol,
      'departamento': departamento
    };
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      email: map['email'],
      nombre: map['nombre'],
      apPaterno: map['ap_paterno'],
      apMaterno: map['ap_materno'],
      idIpn: map['id_ipn'],
      tarjetaAsistencia: map['tarjeta_asistencia'],
      rol: map['rol'],
      departamento: map['departamento'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'USERMODEL(email: $email nombre: $nombre apPaterno: $apPaterno apMaterno: $apMaterno idIpn: $idIpn tarjetaAsistencia: $tarjetaAsistencia rol: $rol departamentoId: $departamento)';
  }

  UserModel copyWith({
    String? email,
    String? nombre,
    String? apPaterno,
    String? apMaterno,
    String? idIpn,
    String? tarjetaAsistencia,
    String? rol,
    int? departamento,
  }) {
    return UserModel(
        email: email ?? this.email,
        nombre: nombre ?? this.nombre,
        apPaterno: apPaterno ?? this.apPaterno,
        apMaterno: apMaterno ?? this.apMaterno,
        idIpn: idIpn ?? this.idIpn,
        tarjetaAsistencia: tarjetaAsistencia ?? this.tarjetaAsistencia,
        rol: rol ?? this.rol,
        departamento: departamento ?? this.departamento);
  }
}
