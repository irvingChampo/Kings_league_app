// Esta es la entidad pura de negocio. No contiene lógica de serialización.
class Player {
  final String id;
  final String nombre;
  final int edad;
  final String posicion;
  final String piernaAbil;
  final String equipo;

  Player({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.posicion,
    required this.piernaAbil,
    required this.equipo,
  });
}