import QtQuick 2.6
import Sailfish.Silica 1.0

import QtPositioning 5.3
import QtLocation 5.0
import "../assets"


Page {
//=====================*******==========================================*******=====================
    PositionSource {
        id: mapsource
        updateInterval: 1000

        nmeaSource: "/usr/share/ru.auroraos.PositioningAndLocation/nmea/path.nmea"


        active: true
    }


//=====================*******==========================================*******=====================
       Rectangle {
          id: topRect
          anchors.top: parent.top
          color: "lightblue";
          width: parent.width
          height: parent.height * 0.2

          Text {
             id:  ttimestamp
             anchors.top:   parent.top
             anchors.right: parent.right
             font.pointSize: 24
             text: mapsource.position.timestamp
          }

          ValueDisplay {
              id:    vdcoordinate
              anchors.top: ttimestamp.bottom
              anchors.left: parent.left
              label: qsTr("Coordinate")
              value: mapsource.position.coordinate
              valid: mapsource.position.coordinate.isValid
              width: parent.width
          }

          ValueDisplay {
              id:    vdspeed
              anchors.top: ttimestamp.bottom
              anchors.right: parent.right
              label: qsTr("Speed")
              value: qsTr("%1 meters / second").arg(mapsource.position.speed)
              valid: mapsource.position.speedValid
              width: parent.width * 0.25
          }

          ValueDisplay {
              id:    vdlatitude
              anchors.top:  vdcoordinate.bottom
              anchors.left: parent.left
              label: qsTr("Latitude")
              value: mapsource.position.coordinate.latitude.toFixed(6)
              valid: mapsource.position.latitudeValid
              width: parent.width/3
          }

          ValueDisplay {
              id:    vdlongitude
              anchors.top:   vdcoordinate.bottom
              anchors.left:  vdlatitude.right
              anchors.right: vdaltitude.left
              label: qsTr("Longitude")
              value: mapsource.position.coordinate.longitude.toFixed(6)
              valid: mapsource.position.longitudeValid
              width: parent.width/3
          }

          ValueDisplay {
              id:    vdaltitude
              anchors.top: vdcoordinate.bottom
              anchors.right: parent.right
              label: qsTr("Altitude")
              value: mapsource.position.coordinate.altitude.toFixed(6)
              valid: mapsource.position.altitudeValid
              width: parent.width/3
          }

       }
//=====================*******==========================================*******=====================
       Rectangle {
          id: mapRect
          width: parent.width
          height: parent.height * 0.8


          anchors.top: topRect.bottom
          anchors.bottom: parent.bottom

          Map {
             id: map
             anchors.fill: parent
             plugin: mapPlugin

             gesture.enabled: true
             gesture.activeGestures: MapGestureArea.PinchGesture | MapGestureArea.PanGesture
             //gesture.acceptedGestures: MapGestureArea.PinchGesture | MapGestureArea.PanGesture

             Plugin {
                id: mapPlugin
                name: "webtiles"
                allowExperimental: false
                PluginParameter { name: "webtiles.scheme"; value: "http" }
                PluginParameter { name: "webtiles.host"; value: "a.tile.openstreetmap.fr" }
                PluginParameter { name: "webtiles.path"; value: "/hot/${z}/${x}/${y}.png" }
             }

             Binding {
                target: map
                property: "center"
                value: mapsource.position.coordinate
                when:  mapsource.position.coordinate.isValid
             }

             Footprints {
                 id: mifoot
                 coordinate: mapsource.position.coordinate
                 visible:    mapsource.position.coordinate.isValid
                 diameter: Math.min(map.width, map.height) / 8
             }

             Component.onCompleted: {

                 center = QtPositioning.coordinate(55.751244, 37.618423)
                 map.addMapItem(mifoot)

                 /*var circle = Qt.createQmlObject("import QtLocation 5.0; MapCircle{}", map);
                 circle.center = mapsource.position.coordinate;
                 circle.radius = 500000.0;
                 circle.color = "red";
                 circle.border.width = 3;
                 circle.visible = true
                 map.addMapItem(circle);*/

                 console.log("map completed")
             }

          }

       }
//=====================*******==========================================*******=====================
       Rectangle {
          id: bottomRect
          anchors.bottom:  parent.bottom
          color: "lightblue";
          width: parent.width
          height: parent.height * 0.08


          Slider {
             id: scaleslider
             anchors.fill: parent
             label : qsTr("scale")

             minimumValue: map.minimumZoomLevel
             maximumValue: map.maximumZoomLevel
             value: (map.maximumZoomLevel-map.minimumZoomLevel)/2

             onMouseXChanged: {map.zoomLevel = scaleslider.value}
          }

       }
//=====================*******==========================================*******=====================

       // acceptedGestures: MapGestureArea.PinchGesture | MapGestureArea.PanGesture
     //   gesture.PinchGesture : true //| MapGestureArea.PanGesture
       // ToDo: define plugin to work with OSM
        // ToDo: enable gesture recognition
        // ToDo: bind zoomLevel property to slider value

        // ToDo: add binding of the map center to the position coordinate

        // ToDo: create MouseArea to handle clicks and holds

    // ToDo: add a slider to control zoom level

    // ToDo: add a component corresponding to MapQuickCircle

    // ToDo: add item at the current position
}
