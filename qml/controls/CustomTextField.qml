import QtQuick
import QtQuick.Controls

TextField {
    id: textField

    // Custom Properties
    property color colorDefault: "#161b22"
    property color colorOnFocus: "#202833"
    property color colorMouseOver: "#293341"

    QtObject{
        id: internal

        property var dynamicColor: if(textField.focus){
                                        textField.focus ? colorOnFocus : colorDefault
                                   }else{
                                       textField.hovered ? colorMouseOver : colorDefault
                                   }
    }

    implicitWidth: 300
    implicitHeight: 40
    placeholderText: qsTr("Type something")
    color: "#ffffff" // Establece el color del texto aquí
    background: Rectangle {
        color: internal.dynamicColor
        radius: 10
    }

    selectByMouse: true
    selectedTextColor: "#FFFFFF" // Establece el color del texto resaltado
    selectionColor: "#00FF7B" // Establece el color del fondo texto resaltado
    placeholderTextColor: "#b1b4bf" // Establece el color del texto de fondo
    leftPadding: 10
}