import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../cubit/location_cubit/location_cubit.dart';
import '../cubit/location_cubit/location_state.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit()..getLocation(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Location'),
        ),
        body: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state)
          {
            if(state is LocationLoading)
            {
              return Center(child: CircularProgressIndicator(),);
            }
            else if(state is LocationSuccess)
            {
              return Column(
                children:
                [
                  Text('${state.latLng.latitude} , ${state.latLng.longitude}'),
                  SizedBox(height: 20,),
                  // ElevatedButton(onPressed: , child: Text('Current')),
                  SizedBox(height: 20,),
                  Expanded(
                    child: GoogleMap(
                      polylines: {
                        Polyline(
                          polylineId: PolylineId('1'),
                          points: [
                            LatLng(state.latLng.latitude, state.latLng.longitude),
                            LatLng(state.latLng.latitude+0.2, state.latLng.longitude+0.2),
                          ]
                        )
                      },
                      onTap: LocationCubit.get(context).changeLocation,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(state.latLng.latitude, state.latLng.longitude),
                        zoom: 5,
                      ),
                      myLocationEnabled: true,
                      markers: LocationCubit.get(context).markers,
                    ),
                  ),
                ],
              );
            }
            else if(state is LocationError)
            {
              return Text(state.message);
            }
            else
            {
              return SizedBox();
            }
          }
        ),
      ));
  }
}
