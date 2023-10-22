import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btnToggle
    //CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_icons/menu_icon.svg"
    property color btnColorDefault: "#161b22"
    property color btnColorMouseOver: "#0d1117"
    property color btnColorClicked: "#00C859"

    QtObject {
        id: internal

        //MOUSE OVER AND CLICK COLOR
        property var dynamicColor: if(btnToggle.down){
            btnToggle.down ? btnColorClicked : btnColorDefault
        } else {
            btnToggle.hovered ? btnColorMouseOver : btnColorDefault
        }
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
            id:iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#FFFFFF"
            antialiasing: false
        }
    }
}

            /*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:10;height:480;width:640}
}
##^##*/
