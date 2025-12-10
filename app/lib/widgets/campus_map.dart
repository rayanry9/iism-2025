import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:latlong2/latlong.dart';

class CampusMap extends StatefulWidget {
  const CampusMap({super.key});
  @override
  State<CampusMap> createState() => _CampusMapState();
}

class _CampusMapState extends State<CampusMap> {
  late final PopupController _popupController;

  @override
  void initState() {
    _popupController = PopupController();
    super.initState();
  }

  @override
  void dispose() {
    _popupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(
          17.59138137639814,
          78.1215568328114,
        ), // Center the map over London
        initialZoom: 16,
        minZoom: 15,
        initialRotation: 90,
        cameraConstraint: CameraConstraint.contain(
          bounds: LatLngBounds(
            LatLng(17.573406912213027, 78.10866922433385),
            LatLng(17.613562198115403, 78.13363068521748),
          ),
        ),
        onTap: (_, _) {
          _popupController.hideAllPopups();
        },
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c', 'd'],
        ),
        PopupMarkerLayer(
          options: PopupMarkerLayerOptions(
            markers: [
              _makeMarker(
                "Main Gate",
                LatLng(17.580308417961902, 78.12116149522082),
              ),
              _makeMarker(
                "Sampoorna Supermarket",
                LatLng(17.58531303808576, 78.11985971834777),
              ),
              _makeMarker(
                "International Guesthouse",
                LatLng(17.586801792846263, 78.11872048665707),
              ),
              _makeMarker(
                "Convention Centre",
                LatLng(17.587751897857114, 78.11980592365502),
              ),
              _makeMarker(
                "Hospital",
                LatLng(17.587514999989512, 78.12400301343388),
              ),
              _makeMarker(
                "Admin Block",
                LatLng(17.591483741759255, 78.12452280503238),
              ),
              _makeMarker(
                "Library",
                LatLng(17.592219550370686, 78.12450047712865),
              ),
              _makeMarker(
                "Hostel Circle",
                LatLng(17.596588732288232, 78.1252213498873),
              ),
              _makeMarker(
                "Canteen",
                LatLng(17.5964549111452, 78.1271512853331),
              ),
              _makeMarker(
                "Food Court",
                LatLng(17.596771475356828, 78.1271598008156),
              ),
              _makeMarker(
                "Old badminton&\nTT court",
                LatLng(17.596428530767604, 78.12796877173534),
              ),
              _makeMarker(
                "Tennis court",
                LatLng(17.596444764854123, 78.12830726220345),
              ),
              _makeMarker(
                "Old Basketball Court",
                LatLng(17.596460998930674, 78.1287521961641),
              ),
              _makeMarker(
                "Old sport ground",
                LatLng(17.597130653316718, 78.12841796347595),
              ),
              _makeMarker(
                "Mess B",
                LatLng(17.59782217450822, 78.12278460738594),
              ),
              _makeMarker(
                "New Canteen",
                LatLng(17.597883051823246, 78.12338920666186),
              ),
              _makeMarker(
                "Mess A",
                LatLng(17.59834897166455, 78.12575693113902),
              ),
              _makeMarker(
                "Sports Circle",
                LatLng(17.601513718782257, 78.12224042619691),
              ),
              _makeMarker(
                "SNCC",
                LatLng(17.601722452297714, 78.12362023474597),
              ),
              _makeMarker(
                "Gym & Running track",
                LatLng(17.601850321658933, 78.12297480214356),
              ),
              _makeMarker(
                "Basketball Court",
                LatLng(17.602236447392148, 78.12415180225523),
              ),
              _makeMarker(
                "Volleyball Court",
                LatLng(17.602467514358484, 78.12366377783742),
              ),
              _makeMarker(
                "Swimming Pool",
                LatLng(17.602872190550347, 78.12333282734694),
              ),
              _makeMarker(
                "Football Ground",
                LatLng(17.60359649325292, 78.12325397128419),
              ),
              _makeMarker(
                "OAT (Open Air Theatre)",
                LatLng(17.601797119552856, 78.12480958568324),
              ),
              _makeMarker(
                "Cricket",
                LatLng(17.603079459861465, 78.12449655120521),
              ),
              _makeMarker(
                "Athletics & Running Track",
                LatLng(17.601871933021673, 78.12582928775421),
              ),
              _makeMarker(
                "Tihaan",
                LatLng(17.601669217732983, 78.12699301154129),
              ),
              _makeMarker(
                "Hockey Ground",
                LatLng(17.596445277763234, 78.12958432831304),
              ),
              _makeMarker(
                "Tennis Ground",
                LatLng(17.604444913138828, 78.12437308068611),
              ),
            ],
            popupController: _popupController,
            markerTapBehavior: MarkerTapBehavior.togglePopupAndHideRest(),
            popupDisplayOptions: PopupDisplayOptions(
              builder: (context, marker) {
                return Text((marker as VenueMarker).name);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class VenueMarker extends Marker {
  final String name;
  const VenueMarker({
    required super.point,
    required super.child,
    required super.rotate,
    required this.name,
  });
}

VenueMarker _makeMarker(String name, LatLng point) {
  return VenueMarker(
    name: name,
    point: point,
    rotate: true,
    child: Icon(Icons.pin_drop, color: CustomColors.orange, opticalSize: 1.5),
  );
}
