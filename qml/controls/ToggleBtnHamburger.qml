import QtQuick
import QtQuick.Controls

Button {
    id: btnToggle
    //CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_icons/menu_icon.svg"
    property url btnIconSourceClicked: "../../images/svg_icons/menu_icon.svg"

    property color btnColorDefault: "#161b22"
    property color btnColorMouseOver: "#0d1117"
    property color btnColorClicked: "#00C859"
    property color btnIconColor: "#FFFFFF"

    QtObject {
        id: internal

        // MOUSE OVER AND CLICK COLOR
        property var dynamicColor: btnToggle.down ? btnColorClicked : (btnToggle.hovered ? btnColorMouseOver : btnColorDefault)
    }

    implicitWidth: 70
    implicitHeight: 60

    background: Rectangle {
        id: bgBtn
        width: 70
        height: 60
        color: internal.dynamicColor
        border.color: "#80000000"

        Image {
            id: iconBtn
            source: Qt.resolvedUrl(btnIconSource)
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
        }
    }
}
