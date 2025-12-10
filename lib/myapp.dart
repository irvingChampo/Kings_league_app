import 'package:flutter/material.dart';
import 'package:kings_league_app/features/players/domain/usecase/create_player.dart';
import 'package:kings_league_app/features/players/domain/usecase/delete_player.dart';
import 'package:kings_league_app/features/players/domain/usecase/get_players.dart';
import 'package:kings_league_app/features/players/presentation/pages/players_screen.dart';
import 'package:kings_league_app/features/players/presentation/providers/players_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final GetPlayers getPlayersUseCase;
  final CreatePlayer createPlayerUseCase;
  final DeletePlayer deletePlayerUseCase;

  const MyApp({
    super.key,
    required this.getPlayersUseCase,
    required this.createPlayerUseCase,
    required this.deletePlayerUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Se crea una instancia del Provider que estará disponible en todo el árbol de widgets.
      create: (_) => PlayersProvider(
        getPlayersUseCase: getPlayersUseCase,
        createPlayerUseCase: createPlayerUseCase,
        deletePlayerUseCase: deletePlayerUseCase,
      ),
      child: MaterialApp(
        title: 'Kings League App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.amber,
          scaffoldBackgroundColor: const Color(0xFF121212),
          cardColor: const Color(0xFF1E1E1E),
        ),
        home: const PlayersScreen(),
      ),
    );
  }
}