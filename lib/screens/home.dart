import 'package:flutter/material.dart';

import 'apprentice_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Text(
          'REGISTRON',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Agency FB',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Acción del botón 1
              },
              child: Text('Ruleta'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApprenticeScreen()),
                );
              },
              child: Text('Attendance'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción del botón 3
              },
              child: Text('Botón 3'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción del botón 4
              },
              child: Text('Botón 4'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción del botón 5
              },
              child: Text('Botón 5'),
            ),
          ],
        ),
      ),
    );
  }
}
