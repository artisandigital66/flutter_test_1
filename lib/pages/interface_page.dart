import 'package:flutter/material.dart';

class InterfacePage extends StatefulWidget {
  const InterfacePage({super.key});

  @override
  State<InterfacePage> createState() => _InterfacePageState();
}

class _InterfacePageState extends State<InterfacePage> {
  final _formKey = GlobalKey<FormState>();
  final alt1Controller = TextEditingController();
  final alt2Controller = TextEditingController();
  final alt3Controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    alt1Controller.dispose();
    alt2Controller.dispose();
    alt3Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "altitude haute",
                hintText: "entre altitude haute",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value == "") {
                  return "remplir ce champ";
                }
                return null;
              },
              controller: alt1Controller,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "altitude mediane",
                hintText: "entre altitude moyenne",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value == "") {
                  return "remplir ce champ";
                }
                return null;
              },
              controller: alt2Controller,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "altitude basse",
                hintText: "entre altitude basse",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value == "") {
                  return "remplir ce champ";
                }
                return null;
              },
              controller: alt3Controller,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final alt1 = alt1Controller.text;
                    final alt2 = alt2Controller.text;
                    final alt3 = alt3Controller.text;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "altitude haute: $alt1\m \n altitude mediane: $alt2\m \n altitude basse: $alt3\m"),
                      ),
                    );
                  }
                },
                child: const Text('Envoyer',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
