import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constant.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _documentController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  bool showTable = false; // Variable para gestionar la visibilidad de la tabla

  @override
  void initState() {
    super.initState();
    _getTransportAssistances(); // Realiza la consulta al iniciar sesión
  }

  // Método para enviar el número de documento a la ruta de la API y actualizar la tabla
  void _sendNumberToApi() async {
    if (_documentController.text.isNotEmpty) {
      final response = await http.get(
        Uri.parse('$assistenceURL?data=${_documentController.text}'),
      );

      if (response.statusCode == 200) {
        // Éxito, puedes manejar la respuesta si es necesario
        print('Número de documento enviado con éxito');

        // Muestra un cuadro de diálogo de éxito personalizado
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(25.0),
              title: Text(
                'Éxito!',
                style: TextStyle(
                  color: Colors.green, // Color verde
                  fontSize: 25.0, // Tamaño de fuente más grande
                  fontWeight: FontWeight.bold, // Texto en negrita
                ),
                textAlign: TextAlign.center,
              ),
              content: Text(
                'Se ha guardado con éxito la Asistencia',
                style: TextStyle(
                  color: Colors.black, // Puedes ajustar el color según tus preferencias
                  fontSize: 16.0, // Tamaño de fuente
                ),
                textAlign: TextAlign.center,
              ),
            );
          },
        );

        // Agrega un retraso de 2 segundos antes de limpiar el campo de texto y cerrar el cuadro de diálogo
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(); // Cierra el cuadro de diálogo después de 2 segundos
          _documentController.clear(); // Limpia el campo de texto después de 2 segundos
        });
        // Actualiza la visibilidad de la tabla
        setState(() {
          showTable = true;
        });
      } else {
        // Manejar errores aquí
        print('Error al enviar el número de documento');
      }
    }
  }

  // Método para obtener las asistencias de transporte
  Future<void> _getTransportAssistances() async {
    final response = await http.get(
      Uri.parse('$apprenticesURL'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      setState(() {
        searchResults = List<Map<String, dynamic>>.from(data);
      });
    } else {
      // Manejar errores aquí
      print('Error al obtener las asistencias de transporte');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _documentController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Número de Documento',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.green, // Cambia el color según tus preferencias
                    ),
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        _sendNumberToApi(); // Llama a la función para enviar el número a la API
                        _getTransportAssistances(); // Llama a la función para obtener las asistencias de transporte
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              if (showTable)
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Documento')),
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Ruta')),
                        DataColumn(label: Text('Fecha y Hora')),
                      ],
                      rows: searchResults.map((result) {
                        return DataRow(cells: [
                          DataCell(Text(result['document_number'].toString())),
                          DataCell(Text('${result['first_name']} ${result['first_last_name']} ${result['second_last_name']}')),
                          DataCell(Text('${result['route_number']} - ${result['name_route']}')),
                          DataCell(Text(result['date_time'])),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
