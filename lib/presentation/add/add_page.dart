import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/di/service_locator.dart';
import 'package:weather/presentation/add/bloc/add_bloc.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/resources/app_images.dart';
import 'package:weather/theme/theme_extensions.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

@RoutePage()
class AddNewLocationPage extends StatelessWidget {
  final LocationDto? location;

  const AddNewLocationPage({Key? key, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<AddBloc>()
        ..add(AddPageLoadedEvent(
            location: location ??
                LocationDto(
                    latitude: 32, longitude: 55, location: 'location'))),
      child: const _AddPageBaseWidget(),
    );
  }
}

class _AddPageBaseWidget extends StatefulWidget {
  const _AddPageBaseWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_AddPageBaseWidget> createState() => _AddPageBaseWidgetState();
}

class _AddPageBaseWidgetState extends State<_AddPageBaseWidget> {
  bool isPointSelected = false;
  String placeName = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddBloc, AddState>(
      listener: (context, state) {
        if (state is AddShowGeoErrorState) {
          state.error.handleGeoError(context, null);
        }
        if (state is AddSetPlaceNameState) {
          placeName = state.address;
          isPointSelected = true;
          setState(() {});
        }
        if (state is AddReturnPlaceNameState) {
          context.router.pop(state.location);
        }
      },
      child: Stack(
        children: [
          const _AddNewLocationPage(),
          if (isPointSelected)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.coolGreyColor.withOpacity(0.8),
                ),
                child: Column(
                  children: [
                    Text(
                      placeName,
                      textAlign: TextAlign.center,
                      style: context.theme.h2,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () => context
                            .read<AddBloc>()
                            .add(const AddPageSelectPoint()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(AppColors
                              .backgroundEndGradientColor
                              .withOpacity(0.6)),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 48, vertical: 12)),
                        ),
                        child: Text(
                          'Выбрать',
                          style: context.theme.b1,
                        )),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddNewLocationPage extends StatefulWidget {
  const _AddNewLocationPage({Key? key}) : super(key: key);

  @override
  State<_AddNewLocationPage> createState() => _AddNewLocationPageState();
}

class _AddNewLocationPageState extends State<_AddNewLocationPage> {
  late YandexMapController controller;
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 0.5);
  final List<MapObject> mapObjects = [];
  LocationDto? location;

  @override
  Widget build(BuildContext context) {
    bool inProgress = false;
    return Scaffold(
      body: BlocBuilder<AddBloc, AddState>(
        builder: (context, state) {
          if (state is AddInitialState || state is AddLongOperationState) {
            inProgress = state.inProgress;
          }
          if (state is AddPlaceholderChangedState) {
            inProgress = state.inProgress;
            location = state.location;
          }
          return Stack(
            children: [
              YandexMap(
                mapType: MapType.vector,
                mapObjects: mapObjects,
                onMapCreated: (YandexMapController yandexMapController) {
                  controller = yandexMapController;
                  if (location != null) {
                    _createPlaceMarkMapObject(Point(
                        latitude: location!.latitude,
                        longitude: location!.longitude));
                    _moveToCurrentLocation(
                        latitude: location!.latitude,
                        longitude: location!.longitude);
                  }
                },
                onMapTap: (point) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  _createPlaceMarkMapObject(point);
                  _moveToCurrentLocation(
                      latitude: point.latitude, longitude: point.longitude);
                  context
                      .read<AddBloc>()
                      .add(AddPageMapPlaceholderSetEvent(point: point));
                },
              ),
              const _TextFieldWidget(),
              // _ZoomPanel(
              //   zoomInCallback: () async {
              //     await controller.moveCamera(CameraUpdate.zoomIn(),
              //         animation: animation);
              //   },
              //   zoomOutCallback: () async {
              //     await controller.moveCamera(CameraUpdate.zoomOut(),
              //         animation: animation);
              //   },
              // ),
              if (inProgress)
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.lightPink,
                  ),
                ),
              if (inProgress)
                ListView(physics: const NeverScrollableScrollPhysics()),
            ],
          );
        },
      ),
    );
  }

  Future<void> _moveToCurrentLocation(
      {required double latitude, required double longitude}) async {
    await controller.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: Point(
                latitude: latitude,
                longitude: longitude,
              ),
              zoom: 8),
        ),
        animation: animation);
  }

  void _createPlaceMarkMapObject(Point point) {
    mapObjects.clear();
    mapObjects.add(PlacemarkMapObject(
        mapId: const MapObjectId('target_place_mark'),
        point: point,
        opacity: 0.7,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            scale: 1.5,
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
  bool textFieldsIsFilled = false;
  bool placesListIsVisible = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AddBloc, AddState>(
          listener: (context, state) {
            if (state is AddSetPlaceNameState) {
              _controller.text = state.address;
              textFieldsIsFilled = true;
              setState(() {});
            }
          },
          child: Column(
            children: [
              TextField(
                controller: _controller,
                cursorWidth: 2,
                cursorColor: AppColors.cursorColor,
                textInputAction: TextInputAction.search,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.whiteColor,
                    size: 24,
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        _controller.text = '';
                        textFieldsIsFilled = false;
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.clear_outlined,
                        color: AppColors.whiteColor,
                        size: 24,
                      )),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
                onChanged: (value) => context
                    .read<AddBloc>()
                    .add(AddPageTextEditChanged(value: value)),
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
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     TextButton(
              //         onPressed: textFieldsIsFilled ? () {} : null,
              //         child: Text(
              //           'Добавить',
              //           style: TextStyle(
              //               color: textFieldsIsFilled
              //                   ? AppColors.backgroundCardColor
              //                   : AppColors.coolGreyColor),
              //         )),
              //     TextButton(
              //         onPressed: () => Navigator.of(context).pop(),
              //         child: const Text(
              //           'Отмена',
              //           style: TextStyle(color: AppColors.backgroundCardColor),
              //         )),
              //   ],
              // )
            ],
          ),
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
