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
  final _nombreController = TextEditingController();
  final _edadController = TextEditingController();
  final _posicionController = TextEditingController();
  final _piernaController = TextEditingController();
  final _equipoController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _edadController.dispose();
    _posicionController.dispose();
    _piernaController.dispose();
    _equipoController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Provider.of<PlayersProvider>(context, listen: false).addPlayer(
        nombre: _nombreController.text,
        edad: int.parse(_edadController.text),
        posicion: _posicionController.text,
        piernaAbil: _piernaController.text,
        equipo: _equipoController.text,
      ).then((_) {
        // Si el widget todavía está montado, vuelve a la pantalla anterior.
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
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _edadController,
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _posicionController,
                decoration: const InputDecoration(labelText: 'Posición'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _piernaController,
                decoration: const InputDecoration(labelText: 'Pierna Hábil'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _equipoController,
                decoration: const InputDecoration(labelText: 'Equipo'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child: const Text('GUARDAR JUGADOR', style: TextStyle(color: Colors.black)),
              )
            ],
          ),
        ),
      ),
    );
  }
}