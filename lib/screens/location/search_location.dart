import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_dashbaord_offers/dashboard_offers_bloc.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_dashbaord_offers/dashboard_offers_state.dart';
import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/main.dart';
import 'package:market_place_customer/screens/dashboard/helper_widgets.dart';
import 'package:market_place_customer/screens/dashboard/popular_vendors.dart';
import 'package:market_place_customer/screens/location/location_from_map.dart';
import 'package:market_place_customer/screens/my_offers/offers_details_page.dart';
import 'package:market_place_customer/utils/app_assets.dart';
import 'package:market_place_customer/utils/app_colors.dart';
import 'package:market_place_customer/utils/app_router.dart';
import 'package:market_place_customer/utils/app_styles.dart';
import 'package:market_place_customer/utils/custom_appbar.dart';
import 'package:market_place_customer/utils/custom_text_fields.dart';

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

      print('----->>>>${response.body}');
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() => predictions = result['predictions']);
      }
    } catch (e) {
      debugPrint("Error fetching predictions: $e");
      setState(() => predictions = []);
    }
  }

  /// Get Place Details by Place ID
  Future<void> getPlaceDetail(String placeId) async {
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

        setState(() {
          selectedLatLng = LatLng(location['lat'], location['lng']);
          controller.text = result['result']['name'];
          street = streetLocal;
          locality = localityLocal;
          city = cityName;
          stateName = stateArea;
          country = countryName;
          postalCode = postal;
          predictions = [];
        });
      }
    } catch (e) {
      debugPrint("Error fetching place detail: $e");
    }
  }

  /// Confirm & return selected location
  void confirmLocation() {
    if (selectedLatLng == null) return;
    Navigator.pop(context, {
      "name": controller.text,
      "lat": selectedLatLng!.latitude,
      "lng": selectedLatLng!.longitude,
      "street": street,
      "locality": locality,
      "city": city,
      "state": stateName,
      "country": country,
      "postal": postalCode,
    });
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
          final distanceInMeters = Geolocator.distanceBetween(
            currentPosition!.latitude,
            currentPosition!.longitude,
            lat,
            lng,
          );
          return (distanceInMeters / 1000).toStringAsFixed(1);
        }
      }
    } catch (e) {
      debugPrint("Error calculating distance: $e");
    }
    return "";
  }

  List<NearbyvendorElement> popularVendor = [];

  fetchData() {
    final vendorsState = context.read<FetchDashboardOffersBloc>().state;
    if (vendorsState is FetchDashboardOffersSuccess) {
      var vendorData = vendorsState.dashboardOffersModel.data;
      popularVendor = vendorData!.popularvendor!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true, extendBody: true,
      extendBodyBehindAppBar: false,
      appBar: customAppbar(context: context, title: "Search your location"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.034),
              child: customTextField(
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  hintText: 'Search your location',
                  controller: controller,
                  prefix: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      Assets.searchIcon,
                      height: 10,
                      width: 10,
                      color: AppColors.black20,
                    ),
                  ),
                  suffix: controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            controller.clear();
                            setState(() => predictions = []);
                          },
                        )
                      : null,
                  //     ? IconButton(
                  //   icon: const Icon(Icons.clear),
                  //   onPressed: () {
                  //     controller.clear();
                  //     setState(() => predictions = []);
                  //   },
                  // )
                  //     : null,

                  onChanged: (value) {
                    if (value.length > 9) {
                      FocusScope.of(context).unfocus();
                    }
                  }),
            ),

            // Material(
            //   elevation: 1,
            //   borderRadius: BorderRadius.circular(12),
            //   child: TextField(
            //     controller: controller,
            //     decoration: InputDecoration(
            //       hintText: "Search location",
            //       prefixIcon: Icon(Icons.search, color: AppColors.themeColor),
            //       suffixIcon: controller.text.isNotEmpty
            //           ? IconButton(
            //         icon: const Icon(Icons.clear),
            //         onPressed: () {
            //           controller.clear();
            //           setState(() => predictions = []);
            //         },
            //       )
            //           : null,
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //         borderSide: BorderSide.none,
            //       ),
            //       filled: true,
            //       fillColor: Colors.white,
            //       contentPadding: const EdgeInsets.symmetric(vertical: 16),
            //     ),
            //     onChanged: getPlacePredictions,
            //   ),
            // ),
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.034),
              child: GestureDetector(
                onTap: () =>
                    AppRouter().navigateTo(context, const PickLocationPage()),
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
                    )),
              ),
            ),

            PopularVendors(popularVendor: popularVendor)

            /* // 📍 Predictions List
            Expanded(
              child: ListView.builder(
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  final prediction = predictions[index];
                  final mainText =
                      prediction['structured_formatting']['main_text'];
                  final secondaryText =
                      prediction['structured_formatting']['secondary_text'];

                  return ListTile(
                    leading:
                        Icon(Icons.location_on, color: AppColors.themeColor),
                    title: Text(
                      mainText ?? "",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    subtitle: FutureBuilder<String>(
                      future: _calculateDistance(prediction['place_id']),
                      builder: (context, snapshot) {
                        final distance =
                            snapshot.hasData && snapshot.data!.isNotEmpty
                                ? " • ${snapshot.data} km"
                                : "";
                        return Text(
                          "${secondaryText ?? ''}$distance",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[700]),
                        );
                      },
                    ),
                    trailing: const Icon(Icons.favorite_border,
                        size: 20, color: Colors.grey),
                    onTap: () => getPlaceDetail(prediction['place_id']),
                  );
                },
              ),
            ),

            // ✅ Selected Location Card
            if (selectedLatLng != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Selected Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor)),
                    const SizedBox(height: 6),
                    Text(controller.text,
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w500)),
                    Text(
                      [
                        if (street.isNotEmpty) street,
                        if (locality.isNotEmpty) locality,
                        if (city.isNotEmpty) city,
                        if (stateName.isNotEmpty) stateName,
                        if (country.isNotEmpty) country,
                        if (postalCode.isNotEmpty) postalCode
                      ].join(' '),
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),*/
          ],
        ),
      ),
      // floatingActionButton: selectedLatLng != null
      //     ? FloatingActionButton.extended(
      //         onPressed: confirmLocation,
      //         backgroundColor: AppColors.themeColor,
      //         label: const Text("Confirm Location"),
      //         icon: const Icon(Icons.check),
      //       )
      //     : null,
    );
  }
}

Widget ViewAllWidget({required String title, void Function()? onPressed}) =>
    Padding(
      padding:
          EdgeInsets.only(left: size.width * 0.034, right: size.width * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyle.normal_19(AppColors.themeColor)),
          TextButton(
              onPressed: onPressed,
              child: Row(
                children: [
                  Text("View All", style: AppStyle.normal_15(AppColors.orange)),
                  const Icon(Icons.arrow_forward_ios_outlined,
                      size: 15, color: AppColors.orange)
                ],
              ))
        ],
      ),
    );

class RestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String distance;
  final String cuisines;
  final String offersCount;
  final String offerText;
  double carWidth;
  double imgHeight;

  RestaurantCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.location,
      required this.distance,
      required this.cuisines,
      required this.offersCount,
      required this.offerText,
      required this.imgHeight,
      required this.carWidth});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouter().navigateTo(context, const OffersDetailsPage()),
      child: Container(
        width: carWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: FadeInImage(
                    height: imgHeight,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: const AssetImage(Assets.dummy),
                    image: imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : const AssetImage(Assets.dummy) as ImageProvider,
                    imageErrorBuilder: (_, child, st) => Image.asset(
                        Assets.dummy,
                        height: size.height * 0.17,
                        fit: BoxFit.cover,
                        width: double.infinity),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.025),
                  child: offersCardChipAndFavoriteWidget(offersCount),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: AppStyle.medium_18(AppColors.themeColor),
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text("$location • $distance",
                      style: AppStyle.normal_13(AppColors.greyColor)),
                  const SizedBox(height: 2),
                  Text(cuisines, style: AppStyle.medium_13(AppColors.black20)),
                ],
              ),
            ),

            const Divider(height: 1),

            // Offer section
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: AppColors.themeColor,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(16))),
              child: Row(
                children: [
                  const Icon(Icons.local_offer,
                      size: 18, color: AppColors.whiteColor),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(offerText,
                        style: AppStyle.medium_14(AppColors.whiteColor)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/// find address and distance


Future<Map<String, String>> getAddressAndDistance(
    double vendorLat, double vendorLng) async {
  // 1️ Get vendor address
  String address = await getExactAddressFromLatLng(vendorLat, vendorLng);

  // Get distance from user to vendor
  double distanceKm = await getDistanceBetweenPoints(vendorLat, vendorLng);

  return {
    "address": address,
    "distance": "${distanceKm.toStringAsFixed(1)} km",
  };
}