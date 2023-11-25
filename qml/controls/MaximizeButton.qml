import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: btnTopBar
    // CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_icons/minimize_icon.svg"
    property color btnColorDefault: "#161b22"
    property color btnColorMouseOver: "#0d1117"
    property color btnColorClicked: "#00C859"
    property color btnIconColor: "#ffffff"

    QtObject {
        id: internal

        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: btnTopBar.down ? btnColorClicked : (btnTopBar.hovered ? btnColorMouseOver : btnColorDefault)
    }

    width: 35
    height: 30
    text: qsTr("")
    hoverEnabled: true
    enabled: true
    autoExclusive: true

    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor

        Image {
            id: iconBtn
            source: Qt.resolvedUrl(btnIconSource)
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 20
            width: 20
            fillMode: Image.PreserveAspectFit
        }
    }
}
