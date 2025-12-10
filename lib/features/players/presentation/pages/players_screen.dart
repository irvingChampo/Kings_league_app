import 'package:flutter/material.dart';
import 'package:kings_league_app/features/players/presentation/pages/add_player_page.dart';
import 'package:kings_league_app/features/players/presentation/providers/players_provider.dart';
import 'package:kings_league_app/features/players/presentation/widgets/card_player.dart';
import 'package:provider/provider.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {

  @override
  void initState() {
    super.initState();
    // Carga inicial de los datos cuando la pantalla se construye por primera vez.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlayersProvider>(context, listen: false).fetchPlayers();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Escucha los cambios en el PlayersProvider.
    final provider = Provider.of<PlayersProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Jugadores de la Kings League')),
      body: RefreshIndicator(
        onRefresh: () => provider.fetchPlayers(),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.error != null
            ? Center(child: Text(provider.error!))
            : ListView.builder(
          itemCount: provider.players.length,
          itemBuilder: (_, index) {
            final player = provider.players[index];
            return CardPlayer(player: player);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddPlayerPage()),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}