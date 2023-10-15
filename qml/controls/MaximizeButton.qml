import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: btnTopBar
    // CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_icons/minimize_icon.svg"
    property color btnColorDefault: "#161b22"
    property color btnColorMouseOver: "#0d1117"
    property color btnColorClicked: "#00C859"

    QtObject{
        id: internal

        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if(btnTopBar.down){
                                       btnTopBar.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
                                   }

    }

    width: 35
    height: 30
    text: qsTr("")
    hoverEnabled: true
    enabled: true
    autoExclusive: true

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor

        Image {
            id: iconBtn
            anchors.verticalCenter: parent.verticalCenter
            source: "../../images/svg_icons/maximize_icon.svg"
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            height: 20
            width: 20
            visible: false
            fillMode: Image.PreserveAspectFit
            antialiasing: false
        }

        ColorOverlay{
            source: iconBtn
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            cached: false
            color: "#ffffff"
            anchors.left: iconBtn.left
            anchors.right: iconBtn.right
            anchors.top: iconBtn.top
            anchors.bottom: iconBtn.bottom
            antialiasing: false
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:16}
}
##^##*/
