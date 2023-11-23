import QtQuick 2.6
import QtLocation 5.0

MapQuickItem {
    property alias diameter: ifoot.width
    id: footprints

    sourceItem: Image {
        id: ifoot
        source: Qt.resolvedUrl("/usr/share/ru.auroraos.PositioningAndLocation/qml/graphics/footprints.svg");
        width: sourceSize.width
        height: width
        fillMode: Image.PreserveAspectFit
    }

    anchorPoint {
        x: ifoot.width / 2
        y: ifoot.height / 2
    }

}





