import 'package:flutter/material.dart';
import 'package:flutter_test_1/pages/jump_details_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JumpLogPage extends StatefulWidget {
  const JumpLogPage({super.key});

  @override
  State<JumpLogPage> createState() => _JumpLogPageState();
}

const jumps = [];
final supabase = Supabase.instance.client;

class _JumpLogPageState extends State<JumpLogPage> {
  final jumpStream =
      supabase.from('sauts').stream(primaryKey: ['id']).order('id');
  final _jumplogFormKey = GlobalKey<FormState>();
  final placeController = TextEditingController();
  final jourController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    placeController.dispose();
    jourController.dispose();
  }

  Future<void> createJump(jump) async {
    await supabase
        .from('sauts')
        .insert({'place': placeController.text, 'jour': jourController.text});
  }

  Future<void> updateJump(jumpId, value) async {
    await supabase
        .from('sauts')
        .update({'place': placeController.text, 'jour': jourController.text})
        .eq('id', jumpId)
        .select();
  }

  Future<void> deleteJump(jumpId) async {
    await supabase.from('sauts').delete().eq('id', jumpId);
  }

  Future<void> detailJump(jumpId) async {
    await supabase.from('sauts').select().eq('id', jumpId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: StreamBuilder(
        stream: jumpStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          }

          final jumps = snapshot.data!;

          return ListView.builder(
            itemCount: jumps.length,
            itemBuilder: ((context, index) {
              final jump = jumps[index];
              final jumpId = jump['id'].toString();

              return Card(
                child: ListTile(
                  leading: const FlutterLogo(),
                  title: Text(jump['place']),
                  subtitle: Text(jump['jour']),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  const JumpDetailsPage()),
                        );
                      },
                    ),
                    // UPDATE // UPDATE // UPDATE // UPDATE // UPDATE // UPDATE // UPDATE // UPDATE
                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            jourController.text = jump['jour'];
                            placeController.text = jump['place'];
                            return SimpleDialog(
                              title: const Text('Edit a jump'),
                              children: [
                                Form(
                                  key: _jumplogFormKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.place),
                                            labelText: 'Place'),
                                        onFieldSubmitted: (value) {
                                          if (_jumplogFormKey.currentState!
                                              .validate()) {
                                            if (mounted) Navigator.pop(context);
                                          }
                                        },
                                        controller: placeController,
                                        validator: (value) {
                                          if (value == null || value == "") {
                                            return "remplir ce champ";
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: jourController,
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.calendar_today),
                                            labelText: 'Jour'),
                                        onFieldSubmitted: (value) {
                                          if (_jumplogFormKey.currentState!
                                              .validate()) {
                                            if (mounted) Navigator.pop(context);
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value == "") {
                                            jourController.text = jump['jour'];
                                            return "remplir ce champ";
                                          }
                                          return null;
                                        },
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_jumplogFormKey.currentState!
                                              .validate()) {
                                            final place = placeController.text;
                                            final jour = jourController.text;
                                            updateJump(jumpId,
                                                {'place': place, 'jour': jour});
                                            if (mounted) Navigator.pop(context);
                                          }
                                        },
                                        child: const Text('valider',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ); //showDialog
                        detailJump(jumpId);
                      },
                    ),
                    // DELETE // DELETE // DELETE // DELETE
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () {
                        deleteJump(jumpId);
                      },
                    ),
                  ]),
                ),
              );
            }),
          );
        },
      ),
      // FAB // FAB // FAB // FAB // FAB // FAB // FAB // FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 20,
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              jourController.text = '';
              placeController.text = '';
              return SimpleDialog(
                title: const Text('Add a jump'),
                children: [
                  Form(
                    key: _jumplogFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              icon: Icon(Icons.place), labelText: 'Place'),
                          onFieldSubmitted: (value) {
                            if (_jumplogFormKey.currentState!.validate()) {
                              if (mounted) Navigator.pop(context);
                            }
                          },
                          controller: placeController,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "remplir ce champ";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              labelText: 'Jour'),
                          onFieldSubmitted: (value) {
                            if (_jumplogFormKey.currentState!.validate()) {
                              if (mounted) Navigator.pop(context);
                            }
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return "remplir ce champ";
                            }
                            return null;
                          },
                          controller: jourController,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          onPressed: () {
                            if (_jumplogFormKey.currentState!.validate()) {
                              final place = placeController;
                              final jour = jourController;
                              createJump({'place': place, 'jour': jour});
                              if (mounted) Navigator.pop(context);
                            }
                          },
                          child: const Text('valider',
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
