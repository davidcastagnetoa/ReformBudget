// import QtQuick
// import QtQuick.Controls

//// For Qt Creator
import QtQuick 2.10
import QtQuick.Controls 2.12

Control {
    id: labelField

    // Custom Properties
    property color colorDefault: "#161b22"
    property color colorOnFocus: "#202833"
    property color colorMouseOver: "#293341"
    property color labelFieldBorderColor: "#cc121212"
    property string customText: "Random Text"

    property string customStyleName: "Light"
    property string customFamily: "My Custom Font Family"
    property int customPointSize: 10

    QtObject{
        id: internal

        property var dynamicColor: if(labelField.focus){
                                        labelField.focus ? colorOnFocus : colorDefault
                                   }else{
                                       labelField.hovered ? colorMouseOver : colorDefault
                                   }
    }   


    width: 300
    height: 40

    background: Rectangle {
        color: internal.dynamicColor
        radius: 10
        border.color: labelFieldBorderColor
        border.width: 1
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#ffffff" // Establece el color del texto aquí
            text: customText

            font.weight: Font.Light
            font.styleName: customStyleName
            font.pointSize: customPointSize
            font.family: customFamily
        }
    }
    leftPadding: 10

    // selectByMouse: true
    // selectedTextColor: "#FFFFFF" // Establece el color del texto resaltado
    // selectionColor: "#00FF7B" // Establece el color del fondo texto resaltado

    // placeholderTextColor: "#b1b4bf" // Establece el color del texto de fondo
    // placeholderText: qsTr("Type something")
}

/*##^##
Designer {
    D{i:0;formeditorZoom:4}
}
##^##*/
