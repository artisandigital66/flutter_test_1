import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class JumpDetailsPage extends StatefulWidget {
  const JumpDetailsPage({super.key});

  @override
  State<JumpDetailsPage> createState() => _JumpDetailsPageState();
}

class _JumpDetailsPageState extends State<JumpDetailsPage> {
  // String title;

  @override
  Widget build(BuildContext context) {
    // debugShowCheckedModeBanner: false,
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Détails',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      //title: const Text(" Courbe"),
      body: Column(
        children: [
          const Text('Courbe du saut'),
          Row(
            children: [
              CustomPaint(
                painter: CurveCustomPainter(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CurveCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    var points = const [
      Offset(10, 10),
      Offset(20, 30),
      Offset(30, 60),
      Offset(40, 90),
      Offset(60, 120),
      Offset(80, 150),
      Offset(100, 180),
      Offset(120, 200),
      Offset(140, 225),
      Offset(160, 250),
      Offset(180, 275),
      Offset(200, 290),
      Offset(220, 315),
      Offset(240, 350),
      Offset(260, 380),
      Offset(280, 400),
      Offset(300, 420),
    ];

    for (var i = 0; i < points.length - 1; i++) {
      var currentPoint = points[i];
      var nextPoint = points[i + 1];

      canvas.drawLine(currentPoint, nextPoint, paint);
    }

    for (var p in points) {
      canvas.drawCircle(p, 1, paint..color = Colors.black);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
