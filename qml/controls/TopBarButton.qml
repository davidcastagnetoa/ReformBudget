import QtQuick
import QtQuick.Controls

Button {
    id: topBarButton
    //CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_icons/lock-rounded-svgrepo-com.svg"
    property color btnColorDefault : "#00c859"
    property color btnColorMouseOver : "#008337"
    property color btnColorClicked : "#00ef68"
    width: 35
    height: 35
    autoRepeat: false
    autoExclusive: false
    checked: true
    checkable: false


    QtObject{
        id: internal

        //MOUSE OVER AND CLICKED COLOR
        property var dinamicColor: topBarButton.down ? btnColorClicked : (topBarButton.hovered ? btnColorMouseOver : btnColorDefault)
    }

    implicitWidth: 35
    implicitHeight: 35
    background: Rectangle{
        id: bgBtn
        color: internal.dinamicColor
        radius: 5

        Image {
            id: iconBtn
            source: Qt.resolvedUrl(btnIconSource)
            sourceSize.height: 35
            sourceSize.width: 35
            autoTransform: false
            asynchronous: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
        }
    }
}