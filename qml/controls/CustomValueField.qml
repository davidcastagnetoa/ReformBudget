// import QtQuick
// import QtQuick.Controls

//// For Qt Creator
import QtQuick 2.10
import QtQuick.Controls 2.12

TextField {
    id: valueField

    // Custom Properties
    property color colorDefault: "#161b22"
    property color colorOnFocus: "#202833"
    property color colorMouseOver: "#293341"
    property color textFieldBorderColor: "#cc121212"
    property string textWithCurrency: "€ " + valueField.text // Añade el símbolo del euro

    // Text color SpinBox
    property color textColorSpinbox : "#ffffff"
    property color selectedTextColorSpinbox : "#000000"
    property color selectionColorSpinbox : "#00FF7B"

    QtObject{
        id: internal
        property var dynamicColor: if(valueField.focus){
                                        valueField.focus ? colorOnFocus : colorDefault
                                   }else{
                                       valueField.hovered ? colorMouseOver : colorDefault
                                   }
    }

    implicitWidth: 300
    implicitHeight: 40
    placeholderText: qsTr("Type something")
    color: "#ffffff" // Establece el color del texto aquí
    background: Rectangle {
        color: internal.dynamicColor
        radius: 10
        border.color: textFieldBorderColor
        border.width: 1
    }

    selectByMouse: true
    selectedTextColor: "#FFFFFF" // Establece el color del texto resaltado
    selectionColor: "#00FF7B" // Establece el color del fondo texto resaltado
    placeholderTextColor: "#b1b4bf" // Establece el color del texto de fondo

    leftPadding: 30
    inputMethodHints: Qt.ImhFormattedNumbersOnly

    validator: DoubleValidator {
        notation: DoubleValidator.StandardNotation
        bottom: 0.0
        decimals: 2
    }

    // Sobreescritura del componente para incluir el símbolo de euro
    // contentItem: Text {
    //     text: valueField.textWithCurrency
    //     font: valueField.font

    //     color: textColorSpinbox // Establece el color del texto aquí
    //     selectedTextColor: selectedTextColorSpinbox // Establece el color del texto resaltado
    //     selectionColor: selectionColorSpinbox // Establece el color del fondo texto resaltado
    //     horizontalAlignment: Text.AlignLeft
    //     verticalAlignment: Text.AlignVCenter
    //     elide: Text.ElideRight
    //     leftPadding: valueField.leftPadding
    //     rightPadding: valueField.rightPadding
    // }

    // Evento para manejar la eliminación del símbolo de euro al editar
    onTextChanged: {
        if (!text.startsWith("€ ")) {
            text = "€ " + text.replace("€ ", "");
        }
    }

    // Evento para posicionar correctamente el cursor
    // onCursorPositionChanged: {
    //     if (cursorPosition < 2) {
    //         cursorPosition = 2;
    //     }
    // }
}


// A REVISAR
// import QtQuick 2.10
// import QtQuick.Controls 2.12

// TextField {
//     id: textField

//     // Custom Properties
//     property color colorDefault: "#161b22"
//     property color colorOnFocus: "#202833"
//     property color colorMouseOver: "#293341"
//     property color textFieldBorderColor: "#cc121212"

//     // Esta propiedad contendrá el valor numérico real sin el símbolo de euro.
//     property real numericValue: 0.0

//     QtObject {
//         id: internal
//         property var dynamicColor: textField.focus ? colorOnFocus : (textField.hovered ? colorMouseOver : colorDefault)
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

//     // Añadir el símbolo de euro al displayText
//     displayText: "€ " + text

//     onTextChanged: {
//         // Actualizar el valor numérico real cada vez que cambie el texto.
//         numericValue = parseFloat(text);
//     }

//     // Ajustar el cursor para no permitir que se coloque antes del símbolo de euro
//     onCursorPositionChanged: {
//         if (cursorPosition < 2) {
//             cursorPosition = 2;
//         }
//     }
// }


/*##^##
Designer {
    D{i:0;formeditorZoom:4}
}
##^##*/