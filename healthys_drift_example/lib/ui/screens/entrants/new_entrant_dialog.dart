import 'package:flutter/material.dart';

// Diàleg per introduir un nou entrant

class AddEntrantDialog extends StatefulWidget {
  const AddEntrantDialog({super.key});

  @override
  State<AddEntrantDialog> createState() => _AddEntrantDialogState();
}

class _AddEntrantDialogState extends State<AddEntrantDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _idCtrl;
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _caloriesCtrl;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _idCtrl = TextEditingController();
    _nameCtrl = TextEditingController();
    _descCtrl = TextEditingController();
    _priceCtrl = TextEditingController();
    _caloriesCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _idCtrl.dispose();
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _caloriesCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _saving = true);

    final id = _idCtrl.text.trim();
    final name = _nameCtrl.text.trim();
    final desc = _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim();
    final price = double.parse(_priceCtrl.text.trim().replaceAll(',', '.'));
    final calories = int.parse(_caloriesCtrl.text.trim());

    Navigator.of(context).pop((
      id: id,
      name: name,
      description: desc,
      price: price,
      calories: calories,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nou entrant'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _idCtrl,
                decoration: const InputDecoration(labelText: 'ID (1-5)'),
                maxLength: 5,
                enabled: !_saving,
                validator: (v) {
                  final s = (v ?? '').trim();
                  if (s.isEmpty) return 'Introdueix un id';
                  if (s.length > 5) return 'Màxim 5 caràcters';
                  return null;
                },
              ),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Nom'),
                enabled: !_saving,
                validator: (v) {
                  final s = (v ?? '').trim();
                  if (s.isEmpty) return 'Introdueix un nom';
                  return null;
                },
              ),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(
                  labelText: 'Descripció (opcional)',
                ),
                enabled: !_saving,
                maxLines: 2,
              ),
              TextFormField(
                controller: _priceCtrl,
                decoration: const InputDecoration(labelText: 'Preu'),
                enabled: !_saving,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (v) {
                  final s = (v ?? '').trim().replaceAll(',', '.');
                  if (s.isEmpty) return 'Introdueix un preu';
                  final d = double.tryParse(s);
                  if (d == null) return 'Preu no vàlid';
                  if (d < 0) return 'No pot ser negatiu';
                  return null;
                },
              ),
              TextFormField(
                controller: _caloriesCtrl,
                decoration: const InputDecoration(labelText: 'Calories'),
                enabled: !_saving,
                keyboardType: TextInputType.number,
                validator: (v) {
                  final s = (v ?? '').trim();
                  if (s.isEmpty) return 'Introdueix calories';
                  final n = int.tryParse(s);
                  if (n == null) return 'Calories no vàlides';
                  if (n < 0) return 'No pot ser negatiu';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel·lar'),
        ),
        FilledButton(
          onPressed: _saving ? null : _submit,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
