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
    property color btnColorClicked: "#6dacb6"
    property int iconWidth: 18
    property int iconHeight: 18
    property color activeMenuColor: "#99f1ff"
    property color activeMenuColorRight: "#99f1ff"
    property bool isActiveMenu: false
    property string secondaryTextContent: "Texto Secundario"
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
            width: 2
            visible: isActiveMenu
            color: "#99f1ff"
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
        Item{
            id: item1
            width: 175
            height: 60
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 75
            Text{
                color: "#ffffff"
                text: btnLeftMenu.text
                font: btnLeftMenu.font
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 15
                anchors.topMargin: 12
                anchors.leftMargin: 0
            }
            Text{
                y: 8
                color: "#a1a1a1"
                text: secondaryTextContent
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Thin
                font.pointSize: 8
                anchors.rightMargin: 15
                anchors.bottomMargin: 12
                anchors.leftMargin: 0
            }
        }


    }
}