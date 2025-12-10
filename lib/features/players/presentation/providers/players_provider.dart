import 'package:flutter/material.dart';
import 'package:kings_league_app/features/players/domain/entities/player.dart';
import 'package:kings_league_app/features/players/domain/usecase/create_player.dart';
import 'package:kings_league_app/features/players/domain/usecase/delete_player.dart';
import 'package:kings_league_app/features/players/domain/usecase/get_players.dart';

// El Provider maneja el estado de la UI y la lógica de presentación.
class PlayersProvider with ChangeNotifier {
  final GetPlayers getPlayersUseCase;
  final CreatePlayer createPlayerUseCase;
  final DeletePlayer deletePlayerUseCase;

  PlayersProvider({
    required this.getPlayersUseCase,
    required this.createPlayerUseCase,
    required this.deletePlayerUseCase,
  });

  List<Player> _players = [];
  bool _isLoading = false;
  String? _error;

  List<Player> get players => _players;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Llama al caso de uso para obtener los jugadores y actualiza el estado.
  Future<void> fetchPlayers() async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // Notifica a los widgets que el estado ha cambiado.

    try {
      _players = await getPlayersUseCase();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Llama al caso de uso para crear un jugador y actualiza la lista.
  Future<void> addPlayer({
    required String nombre,
    required int edad,
    required String posicion,
    required String piernaAbil,
    required String equipo,
  }) async {
    try {
      final newPlayer = await createPlayerUseCase(
        nombre: nombre,
        edad: edad,
        posicion: posicion,
        piernaAbil: piernaAbil,
        equipo: equipo,
      );
      _players.insert(0, newPlayer);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Llama al caso de uso para eliminar un jugador.
  Future<void> removePlayer(String id) async {
    try {
      await deletePlayerUseCase(id);
      _players.removeWhere((player) => player.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}