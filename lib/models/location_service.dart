import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  /// Returns the locality (e.g., city) as a string.
  static Future<String> getCurrentAddress() async {
    try {
      Position position = await _determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        return placemarks[0].locality ?? "Unknown location";
      } else {
        return "No placemarks found.";
      }
    } catch (e) {
      return "Failed to get location: $e";
    }
  }

  /// Returns the current Position (latitude & longitude), only if specifically requested.
  static Future<Position?> getCoordinates() async {
    try {
      return await _determinePosition();
    } catch (e) {
      return null;
    }
  }

  /// Internal method to handle permissions and get current position
  static Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception("Location services disabled.");

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permission denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Permission permanently denied.");
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
