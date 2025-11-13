import 'package:http/http.dart' as http;
import 'package:market_place_customer/utils/exports.dart';

import '../../data/models/dashbaord_offers_model.dart';

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({super.key});

  @override
  State<SearchLocationPage> createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  final TextEditingController controller = TextEditingController();
  List predictions = [];
  LatLng? selectedLatLng;
  Position? currentPosition;

  // Address details
  String countryCode = "IN";
  String street = "";
  String locality = "";
  String city = "";
  String stateName = "";
  String country = "";
  String postalCode = "";

  final String googleAPIKey = dotenv.env['GOOGLE_MAP_API_KEY'] ?? '';

  @override
  void initState() {
    super.initState();
    _getUserCountry();
    fetchData();
  }

  /// Get current location & user country code
  Future<void> _getUserCountry() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final url =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=${currentPosition!.latitude},${currentPosition!.longitude}&key=$googleAPIKey";

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['results'].isNotEmpty) {
          for (var comp in result['results'][0]['address_components']) {
            if ((comp['types'] as List).contains('country')) {
              setState(() => countryCode = comp['short_name']);
              break;
            }
          }
        }
      }
    } catch (e) {
      debugPrint("Error in _getUserCountry: $e");
    }
  }

  /// Get search predictions
  Future<void> getPlacePredictions(String input) async {
    if (input.isEmpty) {
      setState(() => predictions = []);
      return;
    }
    try {
      final url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:$countryCode&key=$googleAPIKey";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() => predictions = result['predictions']);
        print('---->>$result');
      }
    } catch (e) {
      debugPrint("Error fetching predictions: $e");
      setState(() => predictions = []);
    }
  }

  /// Get Place Details by Place ID
  Future<void> getPlaceDetail(String placeId) async {
    FocusScope.of(context).unfocus();
    EasyLoading.show(status: "Please wait...");
    try {
      final url =
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleAPIKey";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final location = result['result']['geometry']['location'];
        final components = result['result']['address_components'];

        String streetLocal = "";
        String localityLocal = "";
        String cityName = "";
        String stateArea = "";
        String countryName = "";
        String postal = "";

        for (var comp in components) {
          List types = comp['types'];
          if (types.contains('street_number')) streetLocal = comp['long_name'];
          if (types.contains('route')) streetLocal += " ${comp['long_name']}";
          if (types.contains('sublocality') || types.contains('neighborhood')) {
            localityLocal = comp['long_name'];
          }
          if (types.contains('locality')) cityName = comp['long_name'];
          if (types.contains('administrative_area_level_1')) {
            stateArea = comp['long_name'];
          }
          if (types.contains('country')) countryName = comp['long_name'];
          if (types.contains('postal_code')) postal = comp['long_name'];
        }

        final latLng = LatLng(location['lat'], location['lng']);

        // Build address string
        String address = [
          result['result']['name'],
          streetLocal,
          localityLocal,
          cityName,
          stateArea,
          countryName,
          postal
        ].where((e) => e.isNotEmpty).join(', ');

        // Save directly in local storage
        await LocalStorage.setDouble(Pref.userLat, latLng.latitude);
        await LocalStorage.setDouble(Pref.userLng, latLng.longitude);
        await LocalStorage.setString(Pref.location, address);

        controller.clear();
        snackBar(context, 'Location saved successfully');
        Future.delayed(const Duration(seconds: 1), () {
          EasyLoading.dismiss();
          AppRouter().navigateAndClearStack(context, const CustomerDashboard());
        });
        // Navigate immediately
      }
    } catch (e) {
      debugPrint("Error fetching place detail: $e");
    }
  }

  /// Calculate distance from current location to placeId
  Future<String> _calculateDistance(String placeId) async {
    try {
      final url =
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleAPIKey";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final location = result['result']['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];

        if (currentPosition != null) {
          final distanceInMeters = await getDistanceBetweenPoints(lat, lng);
          return distanceInMeters.toString();
        }
      }
    } catch (e) {
      debugPrint("Error calculating distance: $e");
    }
    return "";
  }

  /// Fetch popular vendors data
  List<PopularVendorElement> popularVendor = [];

  fetchData() {
    final vendorsState = context.read<FetchDashboardOffersBloc>().state;
    if (vendorsState is FetchDashboardOffersSuccess) {
      var vendorData = vendorsState.dashboardOffersModel.data;
      popularVendor = vendorData!.popularvendor!;
    }
  }

  /// fetch user's current location services
  final locationService = LocationService();

  void getUserLocationAndNavigate() async {
    EasyLoading.show(status: "Please wait...");
    try {
      final location = await locationService.fetchAndSaveCurrentLocation();

      if (location != null) {
        AppRouter().navigateAndClearStack(context, const CustomerDashboard());
      }

      EasyLoading.dismiss();
      print("📍 Current Location Data: $location");
    } catch (e) {
      print("❌ Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: customAppbar(context: context, title: "Save your location"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.034),
              child: CustomTextField(
                keyboardType: TextInputType.text,
                hintText: 'Search your location',
                controller: controller,
                prefix: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(Assets.searchIcon,
                        height: 10, width: 10, color: AppColors.black20)),
                suffix: controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.clear();
                          setState(() => predictions = []);
                        },
                      )
                    : null,
                onChanged: (value) => getPlacePredictions(value),
              ),
            ),

            /// Predictions List
            ListView.builder(
              itemCount: predictions.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final prediction = predictions[index];
                final mainText =
                    prediction['structured_formatting']['main_text'];
                final secondaryText =
                    prediction['structured_formatting']['secondary_text'];

                return ListTile(
                  dense: true,
                  leading: const Icon(Icons.location_on,
                      color: AppColors.themeColor),
                  title: Text(mainText ?? "",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                  subtitle: FutureBuilder<String>(
                    future: _calculateDistance(prediction['place_id']),
                    builder: (context, snapshot) {
                      final distance =
                          snapshot.hasData && snapshot.data!.isNotEmpty
                              ? " • ${snapshot.data} km"
                              : "";
                      return Text("${secondaryText ?? ''}$distance",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[700]));
                    },
                  ),
                  trailing: const Icon(Icons.favorite_border,
                      size: 20, color: Colors.grey),
                  onTap: () => getPlaceDetail(prediction['place_id']),
                );
              },
            ),

            SizedBox(height: size.height * 0.01),

            /// Current Location Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.034),
              child: GestureDetector(
                onTap: getUserLocationAndNavigate,
                child: Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  height: size.height * 0.075,
                  decoration: BoxDecoration(
                      color: AppColors.theme50.withOpacity(0.6),
                      border: Border.all(color: AppColors.theme20),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    dense: true,
                    leading: const Icon(Icons.location_searching_sharp,
                        color: AppColors.whiteColor, size: 30),
                    title: Text("Allow location access",
                        style: AppStyle.medium_16(AppColors.whiteColor)),
                    subtitle: Text("Click here to get your current location",
                        style: AppStyle.medium_14(AppColors.yellowColor)),
                  ),
                ),
              ),
            ),

            PopularVendors(popularVendor: popularVendor),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
