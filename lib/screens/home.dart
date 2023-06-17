import 'package:blogapp/screens/login.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> apprenticeList = [];

  @override
  void initState() {
    super.initState();
    fetchApprentices();
  }

  void fetchApprentices() async {
    try {
      List<String> fetchedApprentices = await UserService.fetchApprentices();

      setState(() {
        apprenticeList = fetchedApprentices;
      });
    } catch (error) {
      print('Error al obtener los aprendices: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Has iniciado sesión!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: apprenticeList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(apprenticeList[index]),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                logout().then((value) => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Login()),
                          (route) => false)
                });
              },
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
