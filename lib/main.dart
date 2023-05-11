import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();
    
    _fetchPermissionStatus();
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
        backgroundColor: Colors.grey[100],
        body: Builder(builder: (context) {
          // if(_hasPermissions) {
            return _buildCompass();
          // } else {
          //  return _buildPermissionSheet();
          //}
        }),
      ),
    );
  }

  // Widget to build the compass
  Widget _buildCompass() {
return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text("No sensors available."),
          );
        }
      },
    );
  }

  // Widget to build the permission sheet
  Widget _buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
        child: const Text('Requesting Permission...'),
        onPressed: () {
          Permission.locationWhenInUse.request().then((ignored) {
            _fetchPermissionStatus();
          });
        },
      ),
    );
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }
}
