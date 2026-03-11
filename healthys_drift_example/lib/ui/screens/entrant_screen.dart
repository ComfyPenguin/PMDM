import 'package:flutter/material.dart';
import 'package:healthys_drift_example/data/entrant_repository.dart';
import 'package:healthys_drift_example/domain/entities/entrant_entity.dart';
import 'package:healthys_drift_example/ui/screens/entrants/new_entrant_dialog.dart';

// Pantalla amb estat per introduir dades
class EntrantsScreen extends StatefulWidget {
  final EntrantRepository repository; // Rebem una referència a la classe DAO

  const EntrantsScreen({super.key, required this.repository});

  @override
  State<EntrantsScreen> createState() => _EntrantsScreenState();
}

class _EntrantsScreenState extends State<EntrantsScreen> {
  Future<void> _onAddPressed() async {
    final result =
        await showDialog<
          ({
            String id,
            String name,
            String? description,
            double price,
            int calories,
          })
        >(context: context, builder: (_) => const AddEntrantDialog());

    if (result == null) return;

    await widget.repository.add(
      EntrantEntity(
        id: result.id,
        name: result.name,
        description: result.description ?? '',
        allergens: const [], // placeholder
        price: result.price,
        calories: result.calories,
        // la resta: null o defaults
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrants')),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<EntrantEntity>>(
        stream: widget.repository.watchAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final entrants = snapshot.data!;
          if (entrants.isEmpty) {
            return const Center(
              child: Text('Encara no hi ha entrants. Afig-ne un amb +'),
            );
          }

          return ListView.builder(
            itemCount: entrants.length,
            itemBuilder: (context, index) {
              final e = entrants[index];

              return ListTile(
                leading: CircleAvatar(child: Text(e.id)),
                title: Text(e.name),
                subtitle: Text(
                  [
                    if (e.description.trim().isNotEmpty)
                      e.description.trim(),
                    '€${e.price.toStringAsFixed(2)} · ${e.calories} kcal',
                  ].join('\n'),
                ),
                isThreeLine:
                    e.description.trim().isNotEmpty,
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    await widget.repository.delete(e.id);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Entrant "${e.name}" esborrat')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
