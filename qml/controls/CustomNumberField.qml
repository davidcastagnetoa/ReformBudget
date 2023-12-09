// import QtQuick
// import QtQuick.Controls
//// For Qt Creator
import QtQuick 2.10
import QtQuick.Controls 2.12

SpinBox {
    id: spinBoxField

    // Custom Properties
    // BG color
    property color colorDefault: "#161b22"
    property color colorOnFocus: "#202833"
    property color colorMouseOver: "#293341"
    property color textFieldBorderColor: "#cc121212"

    // Text color SpinBox
    property color textColorSpinbox : "#ffffff"
    property color selectedTextColorSpinbox : "#000000"
    property color selectionColorSpinbox : "#00FF7B"
    
    // // Indicators btn colors
    // property color indicatorBtnColorDefault : "#202833"
    // property color indicatorBtnColorFocus : "#293341"
    // property color indicatorBtnColorHovered : "#344052"

    QtObject{
        id: internal

        property var dynamicColor: if(spinBoxField.focus){
                                        spinBoxField.focus ? colorOnFocus : colorDefault
                                   }else{
                                       spinBoxField.hovered ? colorMouseOver : colorDefault
                                   }
    }

    implicitWidth: 50
    implicitHeight: 40

    background: Rectangle {
        color: internal.dynamicColor
        border.color: textFieldBorderColor
        radius: 7
    }

    editable: true
    value: 0  // Valor inicial
    from: 1
    to : 100
    stepSize : 1

    contentItem: TextInput {
        text: spinBoxField.textFromValue(spinBoxField.value, spinBoxField.locale)
        font: spinBoxField.font
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        color: textColorSpinbox // Establece el color del texto aquí
        selectedTextColor: selectedTextColorSpinbox // Establece el color del texto resaltado
        selectionColor: selectionColorSpinbox // Establece el color del fondo texto resaltado
    }

     up.indicator: Rectangle {
        id: upBtn
        anchors.right : parent.right
        anchors.top : parent.top
        anchors.rightMargin: 0
        anchors.topMargin: 0
        radius: 5
        width: 18
        height: 18
        z: 10
        // color: upBtn.focus ? indicatorBtnColorFocus : upBtn.hovered ? indicatorBtnColorHovered : indicatorBtnColorDefault
        color: "#00000000"
        Label {
            text: "\u25B2"
            anchors.centerIn: parent
            color: textColorSpinbox // Color de la flecha hacia arriba
            font.pointSize: 6
        }
    }

    down.indicator: Rectangle {
        id: downBtn
        anchors.right : parent.right
        anchors.bottom : parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        radius: 5
        width: 18
        height: 18
        z: 10
        // color: downBtn.focus ? indicatorBtnColorFocus : downBtn.hovered ? indicatorBtnColorHovered : indicatorBtnColorDefault // Color del fondo del botón de flecha hacia abajo
        color: "#00000000"
        Label {
            text: "\u25BC"
            anchors.centerIn: parent
            color: textColorSpinbox // Color de la flecha hacia abajo
            font.pointSize: 6
            
        }
    }

}
