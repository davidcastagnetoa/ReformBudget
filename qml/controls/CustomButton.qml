import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: button

    // Custom Properties
    property color colorDefault: "#00C859"
    property color colorMouseOver: "#55FFA7"
    property color colorPressed: "#3FBD7E"
    property color textBtnColor: "#000000"

    QtObject{
        id: internal

        property var dynamicColor: if(button.down){
                                       button.down ? colorPressed : colorDefault
                                   }else{
                                       button.hovered ? colorMouseOver : colorDefault
                                   }
    }

    text: qsTr("Button")
    font.pointSize: 11
    font.family: "Titillium Web Regular"
    padding: 6
    contentItem: Item{
        Text {
            id: name
            text: button.text
            font: button.font
            color: textBtnColor
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    background: Rectangle{
        color: internal.dynamicColor
        radius: 10
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:40;width:200}
}
##^##*/
