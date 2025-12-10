import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kings_league_app/features/players/data/datasource/service_players.dart';
import 'package:kings_league_app/features/players/data/repository/players_repository_impl.dart';
import 'package:kings_league_app/features/players/domain/usecase/create_player.dart';
import 'package:kings_league_app/features/players/domain/usecase/delete_player.dart';
import 'package:kings_league_app/features/players/domain/usecase/get_players.dart';
import 'package:kings_league_app/features/players/presentation/pages/players_screen.dart';
import 'package:kings_league_app/features/players/presentation/providers/players_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayersProvider>(
          create: (_) {
            final service = ServicePlayersImpl();
            final repository = PlayersRepositoryImpl(servicePlayers: service);
            return PlayersProvider(
              getPlayersUseCase: GetPlayers(repository),
              createPlayerUseCase: CreatePlayer(repository),
              deletePlayerUseCase: DeletePlayer(repository),
            );
          },
        ),
      ],
      child: MaterialApp(
        title: 'Kings League App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.amber,
          scaffoldBackgroundColor: const Color(0xFF121212),
          cardColor: const Color(0xFF1E1E1E),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF121212),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        home: const PlayersScreen(),
      ),
    );
  }
}