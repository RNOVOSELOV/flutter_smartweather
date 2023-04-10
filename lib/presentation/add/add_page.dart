import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/geolocation/geo.dart';
import 'package:weather/data/geolocation/geo_error.dart';
import 'package:weather/data/geolocation/geo_repository.dart';
import 'package:weather/di/service_locator.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/resources/app_images.dart';
import 'package:weather/theme/theme_extensions.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AddNewLocationPage extends StatefulWidget {
  const AddNewLocationPage({Key? key}) : super(key: key);

  @override
  State<AddNewLocationPage> createState() => _AddNewLocationPageState();
}

class _AddNewLocationPageState extends State<AddNewLocationPage> {
  late YandexMapController controller;
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);
  final List<MapObject> mapObjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            mapType: MapType.vector,
            mapObjects: mapObjects,
            onMapCreated: (YandexMapController yandexMapController) {
              controller = yandexMapController;

              // TODO move to bloc
              LocationDto location = const LocationDto.initial();
              _createPlaceMarkMapObject(Point(
                  latitude: location.latitude, longitude: location.longitude));
              _moveToCurrentLocation(location);
            },
            onMapTap: (point) async {
              _createPlaceMarkMapObject(point);
              FocusManager.instance.primaryFocus?.unfocus();

              final geo = sl.get<GeoRepository>();
              try {
                final addres = await geo.getLocationAddress(
                    location: LocationDto(
                        latitude: point.latitude,
                        longitude: point.longitude,
                        location: ''));
                print('!!! $addres');
              } catch (err) {


                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    GeoError.geoNoAddressError.description,
                    textAlign: TextAlign.center,
                    style: context.theme.b2,
                  ),
                  backgroundColor: AppColors.gunMetalColor,
                  duration: const Duration(seconds: 5),
                  elevation: 4,
                  behavior: SnackBarBehavior.floating,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                ));


              }
            },
          ),
          const _TextFieldWidget(),
          _ZoomPanel(
            zoomInCallback: () async {
              await controller.moveCamera(CameraUpdate.zoomIn(),
                  animation: animation);
            },
            zoomOutCallback: () async {
              await controller.moveCamera(CameraUpdate.zoomOut(),
                  animation: animation);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _moveToCurrentLocation(
    LocationDto appLatLong,
  ) async {
    await controller.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: Point(
                latitude: appLatLong.latitude,
                longitude: appLatLong.longitude,
              ),
              zoom: 3),
        ),
        animation: animation);
  }

  void _createPlaceMarkMapObject(Point point) {
    mapObjects.clear();
    mapObjects.add(PlacemarkMapObject(
        mapId: const MapObjectId('target_place_mark'),
        point: point,
        opacity: 0.6,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
                AppImages.mapPlaceMarkImage)))));
    setState(() {});
  }
}

class _TextFieldWidget extends StatefulWidget {
  const _TextFieldWidget({Key? key}) : super(key: key);

  @override
  State<_TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<_TextFieldWidget> {
  bool placesListIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              cursorColor: AppColors.cursorColor,
              textInputAction: TextInputAction.search,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.backgroundTextEditColor,
                isDense: true,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.backgroundActiveCartColor,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColors.backgroundActiveCartColor,
                  ),
                ),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.backgroundCardColor,
                  size: 24,
                ),
                suffixIcon: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.arrow_forward_outlined,
                      color: AppColors.backgroundCardColor,
                      size: 24,
                    )),
              ),
              cursorWidth: 3,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: AppColors.backgroundCardColor,
              ),
            ),
            if (placesListIsVisible)
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      color: AppColors.backgroundTextEditColor,
                      child: Text('$index',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: AppColors.backgroundCardColor,
                          )),
                    );
                  },
                  separatorBuilder: (_, __) {
                    return Container(
                      color: AppColors.backgroundTextEditColor,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          color: AppColors.backgroundCardColor,
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                    );
                  },
                  itemCount: 5),
          ],
        ),
      ),
    );
  }
}

class _ZoomPanel extends StatelessWidget {
  const _ZoomPanel(
      {Key? key, required this.zoomInCallback, required this.zoomOutCallback})
      : super(key: key);

  final AsyncCallback zoomInCallback;
  final AsyncCallback zoomOutCallback;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: zoomInCallback,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Icon(
                Icons.zoom_in_map,
                size: 24,
                color: AppColors.backgroundCardColor,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: zoomOutCallback,
            child: const Padding(
              padding: EdgeInsets.only(right: 24, left: 24, bottom: 48),
              child: Icon(
                Icons.zoom_out_map_outlined,
                size: 24,
                color: AppColors.backgroundCardColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
