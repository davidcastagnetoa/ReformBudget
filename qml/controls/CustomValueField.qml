// import QtQuick
// import QtQuick.Controls

//// For Qt Creator
import QtQuick 2.10
import QtQuick.Controls 2.12

TextField {
    id: numberValueField

    // Custom Properties
    property color colorDefault: "#161b22"
    property color colorOnFocus: "#202833"
    property color colorMouseOver: "#293341"
    property color textFieldBorderColor: "#cc121212"

    QtObject{
        id: internal

        property var dynamicColor: if(numberValueField.focus){
                                        numberValueField.focus ? colorOnFocus : colorDefault
                                   }else{
                                       numberValueField.hovered ? colorMouseOver : colorDefault
                                   }
    }   

    implicitWidth: 300
    implicitHeight: 40
    placeholderText: qsTr("Type something")
    color: "#ffffff" // Establece el color del texto aquí
    background: Rectangle {
        id: bgTextField
        color: internal.dynamicColor
        radius: 10
        border.color: textFieldBorderColor
        border.width: 1

        Label {
            id: euroSymbol
            text: "€"
            font.pointSize: 10
            font.family: numberValueField.font.family
            color: numberValueField.color
            anchors.left: parent.left
            anchors.leftMargin: 10
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    selectByMouse: true
    selectedTextColor: "#FFFFFF" // Establece el color del texto resaltado
    selectionColor: "#00FF7B" // Establece el color del fondo texto resaltado
    placeholderTextColor: "#b1b4bf" // Establece el color del texto de fondo
    leftPadding: 25
    rightPadding: 10

    horizontalAlignment: Text.AlignRight

    // Asegurarse de que el texto ingresado es un flotante
    validator: DoubleValidator {
        bottom: 0.0
        decimals: 2
    }
}



// // A REVISAR
// import QtQuick 2.10
// import QtQuick.Controls 2.12

// TextField {
//     id: valueField

//     // Custom Properties
//     property color colorDefault: "#161b22"
//     property color colorOnFocus: "#202833"
//     property color colorMouseOver: "#293341"
//     property color textFieldBorderColor: "#cc121212"

//     // Esta propiedad contendrá el valor numérico real sin el símbolo de euro.
//     property real numericValue: 0.0

//     QtObject{
//     id: internal
//     property var dynamicColor: if(valueField.focus){
//                                     valueField.focus ? colorOnFocus : colorDefault
//                                 }else{
//                                     valueField.hovered ? colorMouseOver : colorDefault
//                                 }
//     }

//     implicitWidth: 300
//     implicitHeight: 40
//     placeholderText: qsTr("Type something")
//     color: "#ffffff"
//     background: Rectangle {
//         color: internal.dynamicColor
//         radius: 10
//         border.color: textFieldBorderColor
//         border.width: 1
//     }

//     selectByMouse: true
//     selectedTextColor: "#FFFFFF"
//     selectionColor: "#00FF7B"
//     placeholderTextColor: "#b1b4bf"
//     leftPadding: 10
//     inputMethodHints: Qt.ImhFormattedNumbersOnly

//     validator: DoubleValidator {
//         notation: DoubleValidator.StandardNotation
//         bottom: 0.0
//         decimals: 2
//     }

//     // Usamos un Texto en un Row para poner el símbolo del euro delante
//     Row {
//         anchors.left: parent.left
//         anchors.leftMargin: 10
//         anchors.verticalCenter: parent.verticalCenter
//         spacing: 0

//         Label {
//             id: euroSymbol
//             text: "€"
//             verticalAlignment: Text.AlignVCenter
//         }

//         TextField {
//             id: innerInput
//             width: valueField.width - euroSymbol.width
//             anchors.verticalCenter: euroSymbol.verticalCenter
//             text: valueField.text
//             font: valueField.font

//             // Asegurarse de que el texto ingresado es un flotante
//             validator: DoubleValidator {
//                 bottom: 0.0
//                 decimals: 2
//             }

//             // Asegurarse de que el valor cambia al modificar el texto
//             onTextChanged: valueField.text = text
//         }
//     }

//     // Asegurarse de que el cursor del texto se coloca correctamente
//     onCursorPositionChanged: {
//         innerInput.cursorPosition = cursorPosition - 1
//     }
// }




/*##^##
Designer {
    D{i:0;formeditorZoom:4}
}
##^##*/