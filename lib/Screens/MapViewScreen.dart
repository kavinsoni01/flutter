


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/generated/i18n.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_map_location_picker/generated/i18n.dart'
    as location_picker;
import 'package:google_map_location_picker/google_map_location_picker.dart';
// import 'package:google_map_location_picker_example/keys.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'generated/i18n.dart';



class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  LocationResult _pickedLocation;

  GoogleMapController _controller;
  String _mapStyle;
  BitmapDescriptor bitmapImage;
  final Set<Marker> _markers = {};


// showGoogleMap() async {


//  LocationResult result = await showLocationPicker(
//                       context,
//                       'AIzaSyB73WfgoTy0WEkuWFvCe3Kfb7Y8Rpp9J0Y',
//                       initialCenter: LatLng(31.1975844, 29.9598339),
// //                      automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//                       myLocationButtonEnabled: true,
//                       layersButtonEnabled: true,
// //                      resultCardAlignment: Alignment.bottomCenter,
//                     );
//                     print("result = $result");
//                     setState(() => _pickedLocation = result);
//                   }


  @override
  Widget build(BuildContext context) {


                  
    return MaterialApp(
//      theme: ThemeData.dark(),
      // title: 'location picker',
      // localizationsDelegates: const [
      //   location_picker.S.delegate,
      //   S.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const <Locale>[
      //   Locale('en', ''),
      //   // Locale('ar', ''),
      //   // Locale('pt', ''),
      //   // Locale('tr', ''),
      // ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('location picker'),
        ),
        body: Builder(builder: (context) {
          return Center(
            child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[


               Container(
                 height: 229,
                 child:// showGoogleMap(),

                    Container(
                                    height: 229,
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(top: 17, right: 0),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 229,
                                          child:GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          initialCameraPosition: CameraPosition(
           target: LatLng(0, 0),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
            _controller.setMapStyle(_mapStyle);
          },
          // markers: _markers,
        )
                                        ),
                                      ]
                                    ),
                                ),
                                ),
                              ],
                             ),
                             

                           );
                         }),
                       ),
                     );
                   }
                 

}
