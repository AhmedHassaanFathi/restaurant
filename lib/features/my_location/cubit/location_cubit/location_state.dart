import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationState{}

class LocationInitial extends LocationState{}

class LocationLoading extends LocationState{}
class LocationSuccess extends LocationState
{
  final LatLng latLng;
  LocationSuccess(this.latLng);
}

class LocationError extends LocationState
{
  final String message;
  LocationError(this.message);
}