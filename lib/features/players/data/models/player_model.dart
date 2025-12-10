import '../../domain/entities/player.dart';

// El modelo extiende la entidad y añade la lógica para convertir desde y hacia JSON.
class PlayerModel extends Player {
  PlayerModel({
    required String id,
    required String nombre,
    required int edad,
    required String posicion,
    required String piernaAbil,
    required String equipo,
  }) : super(
      id: id,
      nombre: nombre,
      edad: edad,
      posicion: posicion,
      piernaAbil: piernaAbil,
      equipo: equipo);

  // Factory para crear una instancia desde un mapa JSON.
  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['_id'],
      nombre: json['nombre'],
      edad: json['edad'],
      posicion: json['posicion'],
      piernaAbil: json['piernaAbil'],
      equipo: json['equipo'],
    );
  }

  // Método para convertir la instancia a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'edad': edad,
      'posicion': posicion,
      'piernaAbil': piernaAbil,
      'equipo': equipo,
    };
  }
}