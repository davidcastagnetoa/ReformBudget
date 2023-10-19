import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: topBarButton
    //CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_icons/up_icon.svg"
    property color btnColorDefault : "#1c1d20"
    property color btnColorMouseOver : "#23272E"
    property color btnColorClicked : "#00a1f1"
    autoRepeat: false
    autoExclusive: false
    checked: true
    checkable: false


    QtObject{
        id: internal

        //MOUSE OVER AND CLICKED COLOR
        property var dinamicColor: if(topBarButton.down){
                                       topBarButton.down ? btnColorClicked : btnColorDefault
                                   }else {
                                       topBarButton.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    implicitWidth: 35
    implicitHeight: 35
    background: Rectangle{
        id: bgBtn
        color: internal.dinamicColor

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 16
            width: 16
            fillMode: Image.PreserveAspectFit
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            antialiasing: false

        }
    }
}
