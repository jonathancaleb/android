import 'package:flutter/material.dart';
import 'package:location/location.dart';

class GetLocationPage extends StatefulWidget {
  const GetLocationPage({super.key});

  @override
  _GetLocationPageState createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  final _location = Location();
  LocationData? _currentLocation;

  Future<void> _getLocation() async {
    var permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
    }
    if (permissionStatus == PermissionStatus.granted) {
      final locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permission denied.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Your Location'),
        backgroundColor: Colors.teal, // Use a visually appealing color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Location icon with rounded background
            Container(
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1), // Semi-transparent teal
                borderRadius: BorderRadius.circular(70.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.location_on,
                  size: 80.0,
                  color: Colors.teal,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            // Get Location button with rounded corners
            ElevatedButton(
              onPressed: _getLocation,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200.0, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Get My Location',
                style: TextStyle(fontSize: 18.0),
              ),
            ),

            const SizedBox(height: 20.0),
            // Display location details (if available)
            if (_currentLocation != null)
              Text(
                'Latitude: ${_currentLocation!.latitude!.toStringAsFixed(4)}',
                style: const TextStyle(fontSize: 16.0),
              ),
            if (_currentLocation != null) const SizedBox(height: 5.0),
            if (_currentLocation != null)
              Text(
                'Longitude: ${_currentLocation!.longitude!.toStringAsFixed(4)}',
                style: const TextStyle(fontSize: 16.0),
              ),
          ],
        ),
      ),
    );
  }
}
