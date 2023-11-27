import QtQuick
import QtQuick.Controls

Button {
    id: expandVBtnToggle

    // CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_icons/up_icon.svg"

    property bool btnIconMirror: false
    property color btnColorDefault: "#161b22"
    property color btnColorMouseOver: "#0d1117"
    property color btnColorClicked: "#00C859"
    property color btnColorIconDefault: "#b0b0b0"
    property color btnColorIconMouseOver: "#FFFFFF"
    property color btnColorIconClicked: "#000000"
    width: 40
    height: 30

    QtObject {
        id: internal

        // MOUSE OVER AND CLICK COLOR
        property var dynamicColor: expandVBtnToggle.down ? btnColorClicked : (expandVBtnToggle.hovered ? btnColorMouseOver : btnColorDefault)
    }

    implicitWidth: 40
    implicitHeight: 30

    background: Rectangle {
        id: bgBtn
        width: 40
        height: 30
        color: internal.dynamicColor
        radius: 8
        border.color: "#0b0e11"

        Image {
            id: iconBtn
            source: Qt.resolvedUrl(btnIconSource)
            mirror: btnIconMirror
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 15
            width: 25
            fillMode: Image.PreserveAspectFit
            }
    }
}
