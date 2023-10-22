import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: btnLeftMenu
    text: qsTr("Left Menu Text")

    // CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_icons/home_icon.svg"
    property color btnColorDefault: "#0d1117"
    property color btnColorMouseOver: "#161b22"
    property color btnColorClicked: "#003F1C"
    property int iconWidth: 18
    property int iconHeight: 18
    property color activeMenuColor: "#00C859"
    property color activeMenuColorRight: "#00C859"
    property bool isActiveMenu: false
    QtObject{
        id: internal

        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if(btnLeftMenu.down){
                                       btnLeftMenu.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnLeftMenu.hovered ? btnColorMouseOver : btnColorDefault
                                   }

    }

    implicitWidth: 200
    implicitHeight: 60

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor
//        border.color: "#99757575"

        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext('2d');
                ctx.strokeStyle = "#99757575"; // Color del borde
                ctx.lineWidth = 1; // Grosor del borde
                ctx.beginPath();

                // Dibuja el borde superior
                ctx.moveTo(0, 0);
                ctx.lineTo(parent.width, 0);

                // Dibuja el borde inferior
                ctx.moveTo(0, parent.height);
                ctx.lineTo(parent.width, parent.height);

                ctx.stroke();
            }
        }

        Rectangle{
            anchors{
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            color: activeMenuColor
            width: 2
            visible: isActiveMenu
        }

        Rectangle{
            anchors{
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }
            color: activeMenuColorRight
            width: 2
            visible: isActiveMenu
        }

    }

    contentItem: Item{
        anchors.fill: parent
        id: content
        Image {
            id: iconBtn
            source: btnIconSource
            anchors.leftMargin: 26
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            width: iconWidth
            height: iconHeight
            fillMode: Image.PreserveAspectFit
            visible: false
            antialiasing: true
        }

        ColorOverlay{
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            width: iconWidth
            height: iconHeight
        }

        Text{
            color: "#ffffff"
            text: btnLeftMenu.text
            font: btnLeftMenu.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 75
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:60;width:250}
}
##^##*/
