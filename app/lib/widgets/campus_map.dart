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
          17.592286196097042,
          78.12429645734447,
        ), // Center the map over London
        initialZoom: 15.2,
        minZoom: 15,
        initialRotation: 0,
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

        PolylineLayer(
          polylines: [
            Polyline(
              strokeWidth: 3.0,
              points: [
                LatLng(17.58092443358038, 78.12104254415985),
                LatLng(17.581531316774782, 78.12102231592158),
                LatLng(17.58162847962672, 78.12109741777229),
                LatLng(17.58246203249073, 78.12107596009751),
                LatLng(17.583766049204343, 78.12030884832389),
                LatLng(17.58556874203362, 78.12030087138045),
                LatLng(17.58573293635653, 78.12021155972523),
                LatLng(17.586639043085682, 78.120237077341),
                LatLng(17.586809317668767, 78.12031363018835),
                LatLng(17.587334094938583, 78.1203436508748),
                LatLng(17.587717619897987, 78.12090691475517),
                LatLng(17.58776364283843, 78.12090691475517),
                LatLng(17.587881256966345, 78.12094446568052),
                LatLng(17.58792216621027, 78.12102493194915),
                LatLng(17.58794262082877, 78.1211268558894),
                LatLng(17.58791193890016, 78.12123414424757),
                LatLng(17.587804552108995, 78.12130388168038),
                LatLng(17.587697165254028, 78.12126633075502),
                LatLng(17.587630687645188, 78.12119122890431),
                LatLng(17.5871448889922, 78.12148627188925),
                LatLng(17.58706818382238, 78.12175985720259),
                LatLng(17.587154316228652, 78.12547471660402),
                LatLng(17.588593810469895, 78.12545325893238),
                LatLng(17.588670514992295, 78.12556054729053),
                LatLng(17.588706310424936, 78.12658515111103),
                LatLng(17.588859719341695, 78.12676754131991),
                LatLng(17.589414578385714, 78.12676063281175),
                LatLng(17.59195854429179, 78.12604620348077),
                LatLng(17.59483949329584, 78.12602815982592),
                LatLng(17.596628238493754, 78.12642512077622),
                LatLng(17.596591384277524, 78.12543296420128),
                LatLng(17.59675693808377, 78.12537882759288),
                LatLng(17.596799936517225, 78.12521868994037),
                LatLng(17.596713939640104, 78.12506306320763),
                LatLng(17.59658924409556, 78.12501344308997),
                LatLng(17.59644734906086, 78.1250878732665),
                LatLng(17.59639145098628, 78.1252434999992),
                LatLng(17.59644734906086, 78.1254058931116),
                LatLng(17.596591384277524, 78.12543296420128),
              ],
              color: const Color.fromARGB(255, 33, 150, 243),
            ),
          ],
        ),

        PolylineLayer(
          polylines: [
            Polyline(
              strokeWidth: 3.0,
              points: [
                LatLng(17.587630687645188, 78.12119122890431),
                LatLng(17.587582078175267, 78.1210859035947),
                LatLng(17.587627687216376, 78.12093917730397),
                LatLng(17.58741788553197, 78.1205468439614),
                LatLng(17.587287139431584, 78.12040649707463),
                LatLng(17.58715943384687, 78.12035865154503),
                LatLng(17.586666854317837, 78.12040649707463),
                LatLng(17.586499620221925, 78.12047348081605),
                LatLng(17.58575324627241, 78.12045787013751),
                LatLng(17.585418776204484, 78.12038769669176),
                LatLng(17.583796866299227, 78.12041373282047),
                LatLng(17.582487875865855, 78.12117996250905),
                LatLng(17.581674108921586, 78.12118248011954),
                LatLng(17.581473422445875, 78.12125265356293),
                LatLng(17.580938257421725, 78.12125265356293),
                LatLng(17.58092443358038, 78.12104254415985),
              ],
              color: Colors.blue,
            ),
          ],
        ),

        PolygonLayer(
          polygons: [
            Polygon(
              points: [
                LatLng(17.59767114622033, 78.12786657192251),
                LatLng(17.59770472031797, 78.12864586763429),
                LatLng(17.59676884000891, 78.1287603404507),
                LatLng(17.59676884000891, 78.12790179432757),
              ],
              color: const Color.fromARGB(255, 166, 253, 191),
            ),
          ],
        ),

        PolygonLayer(
          polygons: [
            Polygon(
              points: [
                LatLng(17.59741934028912, 78.12902891128923),
                LatLng(17.59655900070918, 78.1290113000867),
                LatLng(17.596567394285845, 78.12999312462752),
                LatLng(17.59741934028912, 78.12998431902626),
              ],
              color: const Color.fromARGB(255, 224, 253, 166),
            ),
          ],
        ),

        PolygonLayer(
          polygons: [
            Polygon(
              points: [
                LatLng(17.602826621168937, 78.1254917118931),
                LatLng(17.602814751270202, 78.12644436644902),
                LatLng(17.60160995249028, 78.12648172545121),
                LatLng(17.601716782263484, 78.12556020339713),
              ],
              color: const Color.fromARGB(255, 224, 253, 166),
            ),
          ],
        ),
        CircleLayer(
          circles: [
            CircleMarker(
              point: LatLng(17.595958858966572, 78.12976858179532),
              radius: 65,
              useRadiusInMeter: true,
              color: const Color.fromARGB(255, 253, 218, 166),
            ),
          ],
        ),

        CircleLayer(
          circles: [
            CircleMarker(
              point: LatLng(17.60190076672477, 78.12474453184925),
              radius: 45,
              useRadiusInMeter: true,
              color: const Color.fromARGB(255, 195, 195, 195),
            ),
          ],
        ),

        CircleLayer(
          circles: [
            CircleMarker(
              point: LatLng(17.603099628624484, 78.1244643393328),
              radius: 65,
              useRadiusInMeter: true,
              color: const Color.fromARGB(255, 253, 218, 166),
            ),
          ],
        ),
        PopupMarkerLayer(
          options: PopupMarkerLayerOptions(
            markers: [
              _makeMarker(
                "Main Gate",
                LatLng(17.580308417961902, 78.12116149522082),
                icon: Icon(
                  Icons.door_sliding_outlined,
                  color: Color.fromARGB(255, 20, 20, 20),
                ),
              ),
              _makeMarker(
                "Sampoorna Supermarket",
                LatLng(17.58531303808576, 78.11985971834777),
                icon: Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(255, 20, 128, 47),
                ),
              ),
              _makeMarker(
                "International Guesthouse",
                LatLng(17.586801792846263, 78.11872048665707),
                icon: Icon(
                  Icons.hotel,
                  color: Color.fromARGB(255, 197, 16, 16),
                ),
              ),
              _makeMarker(
                "Convention Centre",
                LatLng(17.587751897857114, 78.11980592365502),
                icon: Icon(
                  Icons.other_houses_rounded,
                  color: Color.fromARGB(255, 130, 162, 184),
                ),
              ),
              _makeMarker(
                "Hospital",
                LatLng(17.587514999989512, 78.12400301343388),
                icon: Icon(
                  Icons.local_hospital_outlined,
                  color: Color.fromARGB(255, 178, 22, 48),
                ),
              ),
              _makeMarker(
                "Admin Block",
                LatLng(17.591483741759255, 78.12452280503238),
                icon: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 171, 112, 63),
                ),
              ),
              _makeMarker(
                "Library",
                LatLng(17.592219550370686, 78.12450047712865),
                icon: Icon(
                  Icons.menu_book,
                  color: Color.fromARGB(255, 38, 114, 164),
                ),
              ),
              _makeMarker(
                "Hostel Circle",
                LatLng(17.596588732288232, 78.1252213498873),
              ),
              _makeMarker(
                "Canteen",
                LatLng(17.5964549111452, 78.1271512853331),
                icon: Icon(
                  Icons.local_cafe,
                  color: Color.fromARGB(255, 223, 133, 7),
                ),
              ),
              _makeMarker(
                "Food Court",
                LatLng(17.596771475356828, 78.1271598008156),
                icon: Icon(
                  Icons.local_pizza,
                  color: Color.fromARGB(255, 223, 7, 7),
                ),
              ),
              _makeMarker(
                "Old badminton&\nTT court",
                LatLng(17.596428530767604, 78.12796877173534),
                icon: Icon(
                  Icons.grid_4x4,
                  color: Color.fromARGB(255, 71, 0, 185),
                ),
              ),
              _makeMarker(
                "Tennis court",
                LatLng(17.596444764854123, 78.12830726220345),
                icon: Icon(
                  Icons.sports_tennis,
                  color: Color.fromARGB(255, 20, 20, 176),
                ),
              ),
              _makeMarker(
                "Old Basketball Court",
                LatLng(17.596460998930674, 78.1287521961641),
                icon: Icon(
                  Icons.sports_basketball,
                  color: Color.fromARGB(255, 176, 75, 20),
                ),
              ),
              _makeMarker(
                "Old football ground",
                LatLng(17.597130653316718, 78.12841796347595),
                icon: Icon(
                  Icons.sports_soccer,
                  color: Color.fromARGB(255, 27, 27, 27),
                ),
              ),
              _makeMarker(
                "Mess B",
                LatLng(17.59782217450822, 78.12278460738594),
                icon: Icon(
                  Icons.table_bar,
                  color: Color.fromARGB(255, 176, 20, 137),
                ),
              ),
              _makeMarker(
                "New Canteen",
                LatLng(17.597883051823246, 78.12338920666186),
                icon: Icon(
                  Icons.local_pizza,
                  color: Color.fromARGB(255, 223, 7, 7),
                ),
              ),
              _makeMarker(
                "Mess A",
                LatLng(17.59834897166455, 78.12575693113902),
                icon: Icon(
                  Icons.table_bar,
                  color: Color.fromARGB(255, 176, 20, 137),
                ),
              ),
              _makeMarker(
                "Sports Circle",
                LatLng(17.601513718782257, 78.12224042619691),
              ),
              _makeMarker(
                "SNCC",
                LatLng(17.601722452297714, 78.12362023474597),
                icon: Icon(
                  Icons.circle,
                  color: Color.fromARGB(255, 27, 27, 27),
                ),
              ),
              _makeMarker(
                "Gym & Running track",
                LatLng(17.601850321658933, 78.12297480214356),
                icon: Icon(
                  Icons.fitness_center,
                  color: Color.fromARGB(255, 48, 74, 103),
                ),
              ),
              _makeMarker(
                "Basketball Court",
                LatLng(17.602236447392148, 78.12415180225523),
                icon: Icon(
                  Icons.sports_basketball,
                  color: Color.fromARGB(255, 176, 75, 20),
                ),
              ),
              _makeMarker(
                "Volleyball Court",
                LatLng(17.602467514358484, 78.12366377783742),
                icon: Icon(
                  Icons.sports_volleyball,
                  color: Color.fromARGB(255, 189, 220, 14),
                ),
              ),
              _makeMarker(
                "Swimming Pool",
                LatLng(17.602872190550347, 78.12333282734694),
                icon: Icon(
                  Icons.water,
                  color: Color.fromARGB(255, 20, 176, 176),
                ),
              ),
              _makeMarker(
                "Football Ground",
                LatLng(17.60359649325292, 78.12325397128419),
                icon: Icon(
                  Icons.sports_soccer,
                  color: Color.fromARGB(255, 27, 27, 27),
                ),
              ),
              _makeMarker(
                "OAT (Open Air Theatre)",
                LatLng(17.601797119552856, 78.12480958568324),
                icon: Icon(
                  Icons.theater_comedy_rounded,
                  color: Color.fromARGB(255, 27, 27, 27),
                ),
              ),
              _makeMarker(
                "Cricket",
                LatLng(17.603079459861465, 78.12449655120521),
                icon: Icon(
                  Icons.sports_cricket,
                  color: Color.fromARGB(255, 70, 30, 5),
                ),
              ),
              _makeMarker(
                "Athletics & Running Track",
                LatLng(17.601871933021673, 78.12582928775421),
                icon: Icon(
                  Icons.run_circle_outlined,
                  color: Color.fromARGB(255, 165, 17, 17),
                ),
              ),
              _makeMarker(
                "Tihaan",
                LatLng(17.601669217732983, 78.12699301154129),
                icon: Icon(
                  Icons.sports_score,
                  color: Color.fromARGB(255, 27, 27, 27),
                ),
              ),
              _makeMarker(
                "Old Hockey Ground",
                LatLng(17.597159140458114, 78.12964530337764),
                icon: Icon(
                  Icons.sports_hockey,
                  color: Color.fromARGB(255, 27, 27, 27),
                ),
              ),
              _makeMarker(
                "Old Cricket Ground",
                LatLng(17.596000826985435, 78.12978179019721),
                icon: Icon(
                  Icons.sports_cricket,
                  color: Color.fromARGB(255, 70, 30, 5),
                ),
              ),
              _makeMarker(
                "Tennis Ground",
                LatLng(17.604444913138828, 78.12437308068611),
                icon: Icon(
                  Icons.sports_tennis,
                  color: Color.fromARGB(255, 20, 20, 176),
                ),
              ),
              _makeMarker(
                "Bus Stop",
                LatLng(17.58186066047013, 78.12073983819361),
                icon: Icon(
                  Icons.bus_alert_rounded,
                  color: Color.fromARGB(255, 33, 150, 243),
                ),
              ),

              _makeMarker(
                "Bus Stop",
                LatLng(17.58521182903549, 78.12017351904146),
                icon: Icon(
                  Icons.bus_alert_rounded,
                  color: Color.fromARGB(255, 33, 150, 243),
                ),
              ),

              _makeMarker(
                "Bus Stop",
                LatLng(17.58802449719666, 78.12114836592535),
                icon: Icon(
                  Icons.bus_alert_rounded,
                  color: Color.fromARGB(255, 33, 150, 243),
                ),
              ),

              _makeMarker(
                "Bus Stop",
                LatLng(17.58698607477936, 78.12404499397857),
                icon: Icon(
                  Icons.bus_alert_rounded,
                  color: Color.fromARGB(255, 33, 150, 243),
                ),
              ),

              _makeMarker(
                "Bus Stop",
                LatLng(17.59090123702369, 78.12649892009188),
                icon: Icon(
                  Icons.bus_alert_rounded,
                  color: Color.fromARGB(255, 33, 150, 243),
                ),
              ),
              _makeMarker(
                "Bus Stop",
                LatLng(17.596848559421673, 78.12549962532232),
                icon: Icon(
                  Icons.bus_alert_rounded,
                  color: Color.fromARGB(255, 33, 150, 243),
                ),
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

VenueMarker _makeMarker(String name, LatLng point, {Widget? icon}) {
  return VenueMarker(
    name: name,
    point: point,
    rotate: true,

    child:
        icon ?? Icon(Icons.room, color: CustomColors.orange, opticalSize: 1.5),
    //child: Text(name),
  );
}
