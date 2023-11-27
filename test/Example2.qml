import QtQuick
import QtQuick.Window 2.15
import QtQuick.Controls
// import QtGraphicalEffects 1.0
import QtQuick.Timeline 1.0


Window {
    id: example2
    visible: true
    color: "#00000000"
    title: qsTr("Example")
    // color: "#ffffff" // For Test

    FontLoader {
        id: customFont
        source: Qt.resolvedUrl("../myfonts/GepesteV.ttf")
    }

    Component.onCompleted: {
        console.log("Ruta de la fuente: " + customFont.source)
        console.log("Estado de la fuente: " + (customFont.status == FontLoader.Ready ? "Cargada" : "No cargada"))
    }

    Rectangle {
        id: background
        x: 90
        y: 190
        width: 360
        height: 550
        color: "#FFFFFF"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Label {
            id: lbl1
            width: 133
            height: 25
            color: "#000000"
            text: "Estado de la fuente: " + (customFont.status == FontLoader.Ready ? "Cargada" : "No cargada")
            font.family: customFont.name
            font.pointSize: 12
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text{
            id: text1
            width: 133
            height: 25
            color: "#000000"
            text: "Texto con fuente personalizada"
            visible: customFont.status == FontLoader.Ready
            font.family: customFont.name
            font.pointSize: 14
            anchors.top: lbl1.bottom
            anchors.topMargin: 14
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    
}