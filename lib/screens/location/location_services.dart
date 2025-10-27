import 'package:http/http.dart' as http;
import 'package:market_place_customer/utils/exports.dart';

class LocationService {
  final String googleAPIKey = dotenv.env['GOOGLE_MAP_API_KEY'] ?? '';

  /// Fetch current lat/lng + address via Google Maps API
  Future<Map<String, dynamic>?> fetchAndSaveCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Step 1: Check location services
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Step 2: Permission check
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Step 3: Get user position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double lat = position.latitude;
    double lng = position.longitude;

    // Step 4: Fetch address from Google Geocoding API
    final String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleAPIKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return Future.error("Failed to get address from Google API");
    }

    final data = jsonDecode(response.body);

    if (data["status"] != "OK" || data["results"].isEmpty) {
      return Future.error("No address found for this location.");
    }

    String formattedAddress = data["results"][0]["formatted_address"];

    // Step 5: Save all in local storage
    await LocalStorage.setDouble(Pref.userLat, lat);
    await LocalStorage.setDouble(Pref.userLng, lng);
    await LocalStorage.setString(Pref.location, formattedAddress);

    print("✅ Location Saved Successfully");
    print("Latitude: $lat");
    print("Longitude: $lng");
    print("Address: $formattedAddress");

    return {
      "latitude": lat,
      "longitude": lng,
      "address": formattedAddress,
    };
  }

  /// Fetch saved location data
  Future<Map<String, dynamic>?> getSavedLocationData() async {
    String? address = LocalStorage.getString(Pref.location);

    if (address != null) {
      return {'address': address};
    }
    return null;
  }

  /// Fetch saved location data
  Future<Map<String, dynamic>?> getSavedLatLngData() async {
    double? lat = LocalStorage.getDouble(Pref.userLat);
    double? lng = LocalStorage.getDouble(Pref.userLng);
    if (lat != null && lng != null) {
      return {"latitude": lat, "longitude": lng};
    }
    return null;
  }
}
