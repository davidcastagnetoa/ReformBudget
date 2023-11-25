import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15


Button {
    id: expandBtnToggle

    //CUSTOM PROPERTIES
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

            //MOUSE OVER AND CLICK COLOR
            property var dynamicColor: 
            if(expandBtnToggle.down){
                expandBtnToggle.down ? btnColorClicked : btnColorDefault
            } else {
                expandBtnToggle.hovered ? btnColorMouseOver : btnColorDefault
            }
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

            ColorOverlay {
                anchors.fill: iconBtn
                source: iconBtn
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                color: expandBtnToggle.down ? btnColorIconClicked : expandBtnToggle.hovered ? btnColorIconMouseOver : btnColorIconDefault
                antialiasing: false
            }
        }

}



/*##^##
Designer {
    D{i:0;formeditorZoom:10}
}
##^##*/
