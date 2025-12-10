import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/players_provider.dart';

class AddPlayerPage extends StatefulWidget {
  const AddPlayerPage({super.key});

  @override
  State<AddPlayerPage> createState() => _AddPlayerPageState();
}

class _AddPlayerPageState extends State<AddPlayerPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores solo para los campos de texto libre
  final _nombreController = TextEditingController();
  final _edadController = TextEditingController();

  // Variables para almacenar la selección de los Dropdowns
  String? _selectedPosition;
  String? _selectedLeg;
  String? _selectedTeam;

  // --- Listas de Datos Predefinidos ---

  // Las 12 franquicias originales de la Kings League España
  final List<String> _teamsList = [
    'Porcinos FC',
    'Saiyans FC',
    'Aniquiladores FC',
    'Kunisports',
    'Ultimate Móstoles',
    '1K FC',
    'El Barrio',
    'Los Troncos FC',
    'Pio FC',
    'Rayo de Barcelona',
    'Jijantes FC',
    'xBuyer Team',
  ];

  // Posiciones habituales en fútbol 7
  final List<String> _positionsList = [
    'Portero',
    'Defensa',
    'Medio',
    'Delantero',
  ];

  // Pierna hábil
  final List<String> _legsList = [
    'Diestro',
    'Zurdo',
    'Ambidiestro',
  ];

  @override
  void dispose() {
    _nombreController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Enviamos los datos al Provider
      Provider.of<PlayersProvider>(context, listen: false).addPlayer(
        nombre: _nombreController.text,
        edad: int.parse(_edadController.text),
        // Usamos las variables seleccionadas, asegurando con ! que no son nulas
        // (el validador del formulario ya garantiza que no sean null aquí)
        posicion: _selectedPosition!,
        piernaAbil: _selectedLeg!,
        equipo: _selectedTeam!,
      ).then((_) {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir Nuevo Jugador')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- CAMPO NOMBRE ---
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre Completo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => value!.isEmpty ? 'El nombre es requerido' : null,
              ),
              const SizedBox(height: 16),

              // --- CAMPO EDAD ---
              TextFormField(
                controller: _edadController,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La edad es requerida';
                  }
                  final age = int.tryParse(value);
                  if (age == null) {
                    return 'Ingresa un número válido';
                  }
                  if (age < 18) {
                    return 'El jugador debe ser mayor de edad (18+)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- DROPDOWN POSICIÓN ---
              DropdownButtonFormField<String>(
                value: _selectedPosition,
                decoration: const InputDecoration(
                  labelText: 'Posición',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.sports_soccer),
                ),
                items: _positionsList.map((pos) {
                  return DropdownMenuItem(value: pos, child: Text(pos));
                }).toList(),
                onChanged: (value) => setState(() => _selectedPosition = value),
                validator: (value) => value == null ? 'Selecciona una posición' : null,
              ),
              const SizedBox(height: 16),

              // --- DROPDOWN PIERNA HÁBIL ---
              DropdownButtonFormField<String>(
                value: _selectedLeg,
                decoration: const InputDecoration(
                  labelText: 'Pierna Hábil',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_walk),
                ),
                items: _legsList.map((leg) {
                  return DropdownMenuItem(value: leg, child: Text(leg));
                }).toList(),
                onChanged: (value) => setState(() => _selectedLeg = value),
                validator: (value) => value == null ? 'Selecciona la pierna hábil' : null,
              ),
              const SizedBox(height: 16),

              // --- DROPDOWN EQUIPO ---
              DropdownButtonFormField<String>(
                value: _selectedTeam,
                decoration: const InputDecoration(
                  labelText: 'Equipo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shield),
                ),
                items: _teamsList.map((team) {
                  return DropdownMenuItem(value: team, child: Text(team));
                }).toList(),
                onChanged: (value) => setState(() => _selectedTeam = value),
                validator: (value) => value == null ? 'Selecciona un equipo' : null,
              ),
              const SizedBox(height: 32),

              // --- BOTÓN GUARDAR ---
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'GUARDAR JUGADOR',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}