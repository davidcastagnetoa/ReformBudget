import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: btnLeftMenu
    text: qsTr("Left Menu Text")

    // CUSTOM PROPERTIES
    property string tag: ""
    property url btnIconSource: "../../images/svg_icons/icon_users.svg"
    property color btnColorDefault: "#0d1117"
    property color btnColorMouseOver: "#161b22"
    property color btnColorClicked: "#6dacb6"
    property int iconWidth: 18
    property int iconHeight: 18
    property color activeMenuColorLeft: "#99f1ff"
    property color activeMenuColorRight: "#99f1ff"
    property bool isActiveMenu: false
    property string secondaryTextContent: "Texto Secundario"
    property color textAndOverlayColorDefault: "#1F2328"
    property color textAndOverlayColorMouseOver: "#000000"
    property color textAndOverlayColorClicked: "#FFFFFF"
    property color textSecondaryColorDefault: "#C9D1D9"
    property color textSecondaryColorMouseOver: "#6E7681"
    property color textSecondaryColorClicked: "#a1a1a1"

    //PROPERTY FONTS
    property string currentFont : gepesteVFont.name
    property string currentFontThin : titillium_Web_Extralight_VFont.name

    FontLoader {
        id: gepesteVFont
        source: "../../myfonts/GepesteV.ttf"
    }

    FontLoader {
        id: titillium_Web_Light_VFont
        source: "../../myfonts/TitilliumWeb-Light.ttf"
    }

    FontLoader {
        id: titillium_Web_Extralight_VFont
        source: "../../myfonts/TitilliumWeb-ExtraLight.ttf"
    }

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
        color: isActiveMenu ? btnColorClicked : internal.dynamicColor

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
            color: activeMenuColorLeft
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
            color: isActiveMenu ? textAndOverlayColorClicked : btnLeftMenu.down ? textAndOverlayColorClicked : btnLeftMenu.hovered ? textAndOverlayColorMouseOver : textAndOverlayColorDefault
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
                color: isActiveMenu ? textAndOverlayColorClicked : btnLeftMenu.down ? textAndOverlayColorClicked : btnLeftMenu.hovered ? textAndOverlayColorMouseOver : textAndOverlayColorDefault
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
                color: isActiveMenu ? textSecondaryColorClicked : btnLeftMenu.down ? textSecondaryColorClicked : btnLeftMenu.hovered ? textSecondaryColorMouseOver : textSecondaryColorDefault
                text: secondaryTextContent
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Light
                font.family: currentFontThin
                font.pointSize: 10
                anchors.rightMargin: 15
                anchors.bottomMargin: 12
                anchors.leftMargin: 0
            }
        }

    }
    
    Component.onCompleted: {
        console.log("LeftMenuBtn componente cargado correctamente.")
    }
}