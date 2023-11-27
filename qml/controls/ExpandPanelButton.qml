import QtQuick
import QtQuick.Controls

Button {
    id: expandBtnToggle
    // CUSTOM PROPERTIES

    property url btnIconSource: "../../images/svg_icons/icon_arrow_right.svg"
    
    property bool btnIconMirror: false
    property color btnColorDefault: "#161b22"
    property color btnColorMouseOver: "#0d1117"
    property color btnColorClicked: "#00C859"
    property color btnColorIconDefault: "#b0b0b0"
    property color btnColorIconMouseOver: "#FFFFFF"
    property color btnColorIconClicked: "#000000"
    width: 30
    height: 40

    QtObject {
        id: internal

        // MOUSE OVER AND CLICK COLOR
        property var dynamicColor: expandBtnToggle.down ? btnColorClicked : (expandBtnToggle.hovered ? btnColorMouseOver : btnColorDefault)
    }

    implicitWidth: 30
    implicitHeight: 40

    background: Rectangle {
        id: bgBtn
        width: 30
        height: 40
        color: internal.dynamicColor
        radius: 8
        border.color: "#0b0e11"

        Image {
            id:iconBtn
            source: Qt.resolvedUrl(btnIconSource)
            mirror: btnIconMirror
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            width: 15
            fillMode: Image.PreserveAspectFit
            }
    }
}
