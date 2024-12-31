import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSuggestion {
  final String address;
  final double lat;
  final double lng;

  LocationSuggestion( {required this.address,required this.lat,required this.lng,});
}