import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant/features/my_location/cubit/location_cubit/location_state.dart';
import 'package:restaurant/features/my_location/data/repo/location_repo.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  static LocationCubit get(context) => BlocProvider.of(context);
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  Set<Marker> markers = {};

  changeLocation(LatLng newLocation) {
    markers.clear();
    markers.add(
      Marker(markerId: MarkerId('New Location'), position: newLocation),
    );
    emit(LocationSuccess(newLocation));
  }

  getLocation() async {
    LocationRepo repo = LocationRepo();
    emit(LocationLoading());
    var response = await repo.getLocation();
    response.fold((String error) => emit(LocationError(error)), (position) {
      LatLng latLng = LatLng(position.latitude, position.longitude);
      markers.add(
        Marker(markerId: MarkerId('current location'), position: latLng),
      );
      emit(LocationSuccess(latLng));
    }); 
  }
}
