import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo-infinity.png',
              width: 200, height: 100),
          const Text(
            'HOME',
            style: TextStyle(fontSize: 42),
          ),
          const Text('Valeurs par defaut du .env:'),
          Text('altitude haute: ${dotenv.env['ALT1']}'),
          Text('altitude mediane: ${dotenv.env['ALT2']}'),
          Text('altitude basse: ${dotenv.env['ALT3']}'),
        ],
      ),
    );
  }
}
