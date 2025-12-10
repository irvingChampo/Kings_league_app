import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kings_league_app/features/players/data/datasource/service_players.dart';
import 'package:kings_league_app/features/players/data/repository/players_repository_impl.dart';
import 'package:kings_league_app/features/players/domain/usecase/create_player.dart';
import 'package:kings_league_app/features/players/domain/usecase/delete_player.dart';
import 'package:kings_league_app/features/players/domain/usecase/get_players.dart';
import 'package:kings_league_app/myapp.dart';

Future<void> main() async {
  // Asegura que los bindings de Flutter estén inicializados.
  WidgetsFlutterBinding.ensureInitialized();
  // Carga las variables de entorno del archivo .env
  await dotenv.load(fileName: ".env");

  // --- Inyección de Dependencias Manual ---
  // Se crea una única instancia del servicio que maneja las llamadas HTTP.
  final servicePlayers = ServicePlayersImpl();

  // El repositorio depende del servicio para obtener los datos.
  final repository = PlayersRepositoryImpl(servicePlayers: servicePlayers);

  // Los casos de uso dependen del contrato (repositorio abstracto) para ejecutar la lógica de negocio.
  final getPlayersUseCase = GetPlayers(repository);
  final createPlayerUseCase = CreatePlayer(repository);
  final deletePlayerUseCase = DeletePlayer(repository);

  // Se pasa la instancia de los casos de uso a la aplicación principal.
  runApp(MyApp(
    getPlayersUseCase: getPlayersUseCase,
    createPlayerUseCase: createPlayerUseCase,
    deletePlayerUseCase: deletePlayerUseCase,
  ));
}