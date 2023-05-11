import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();
    
    _fetchPermissionStatus();
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((value) {
      if(mounted) {
        setState(() {
          _hasPermissions = (status == PermissionStatus.granted);
        });
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compass App | Fachry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        body: Builder(builder: (context) {
          if(_hasPermissions) {
            return _buildCompass();
          } else {
            return _buildPermissionSheet();
          }
        }),
      ),
    );
  }
}

// Widget to build the compass
Widget _buildCompass() {
  return Container(
    child: const Text('Hello Hadron!'),
  )
}

// Widget to build the permission sheet
Widget _buildPermissionSheet() {
  return Center(
    child: ElevatedButton(
      child: const Text('Requesting Permission')),
      onPressed: () {
      Permission.locationWhenInUse.request().then((value) {
        _fetchPermissionStatus();
      });
    },
  );
}
