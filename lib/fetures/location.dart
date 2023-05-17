import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/core/app_theme.dart';
import 'package:myapp/core/util/ScreenUtil.dart';

class LocationPage extends StatelessWidget {
  static final CameraPosition sanaa = CameraPosition(
    target: LatLng(15.3694, 44.1910),
    zoom: 14.4746,
  );

  Completer<GoogleMapController> _controller = Completer();
  ScreenUtil screenUtil=ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenUtil.screenHeightNoPadding - 150.0,
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),

                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0)),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      GoogleMap(
                        compassEnabled: true,
                        buildingsEnabled: true,
                        myLocationEnabled: true,
                        minMaxZoomPreference:
                        MinMaxZoomPreference(14.0, 22.0),
                        mapToolbarEnabled: false,
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        myLocationButtonEnabled: true,
                        padding: EdgeInsets.only(
                          top: 80.0,
                        ),
                        onCameraMove: (cameraPosition) {

                        },
                        initialCameraPosition: sanaa,
                        onMapCreated:
                            (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
