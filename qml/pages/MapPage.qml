import QtQuick 2.6
import Sailfish.Silica 1.0

import QtPositioning 5.3
import QtLocation 5.0
import "../assets"

Page {
    PositionSource { id: positionSource }
    Map {
           id: map
           anchors.fill: parent
           plugin: mapPlugin

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
           value: positionSource.position.coordinate
           when: positionSource.position.coordinate.isValid
        }



  /*
        MapGestureArea {
           id: gesture
           enabled: true



        }
*/
       // acceptedGestures: MapGestureArea.PinchGesture | MapGestureArea.PanGesture
     //   gesture.PinchGesture : true //| MapGestureArea.PanGesture





        // ToDo: define plugin to work with OSM
        // ToDo: enable gesture recognition
        // ToDo: bind zoomLevel property to slider value

        // ToDo: add binding of the map center to the position coordinate

        // ToDo: create MouseArea to handle clicks and holds

        Component.onCompleted: center = QtPositioning.coordinate(55.751244, 37.618423)
    }


    /*
    Slider {
    from: map.minimumZoomLevel
    to: map.maximumZoomLevel
    value: 11
    }*/
    // ToDo: add a slider to control zoom level

    // ToDo: add a component corresponding to MapQuickCircle

    // ToDo: add item at the current position
}
