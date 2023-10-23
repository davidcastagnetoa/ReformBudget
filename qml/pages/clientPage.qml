import QtQuick 2.15
import QtQuick.Controls 2.15
import "../controls"


Item {
    //PROPERTIES
    property var buttonList: []

    Timer {
        id: hideWarningTimer
        interval: 2000  // 2 segundos
        onTriggered: warningLabel.visible = false
    }

    // INTERNAL FUNCTIONS
    QtObject{
        id: internal
        function createButton(name, address) {
            var newButton = leftMenuBtnComponent.createObject(clientCol);
            if (newButton) {
                newButton.text = name;
                newButton.secondaryTextContent = address
                buttonCount++;
                newButton.tag = "leftMenuBtn" + buttonCount;
                newButton.width = newButton.tag.width
                newButton.clicked.connect(function() {
                    // Itera sobre todos los botones y establece su propiedad isActiveMenu en false
                    for (var i = 0; i < buttonList.length; i++) {
                        buttonList[i].isActiveMenu = false;
                    }
                    // Establece el botón presionado en true
                    newButton.isActiveMenu = true;
                    // Agrega el nuevo botón a la lista buttonList
                    buttonList.push(newButton);
                });
            } else {
                console.error("Error al crear el botón desde leftMenuBtnComponent");
            }
        }
    }
    
    

    Rectangle {
        id: bgPage
        color: "#0d1117"
        anchors.fill: parent

        Label {
            id: label
            color: "#ffffff"
            text: qsTr("Datos del cliente")
            anchors.left: parent.left
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.topMargin: 10
            font.pointSize: 15
        }
        CustomTextField{
            id: textName
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.left: parent.left;
            anchors.top: label.bottom;
            anchors.leftMargin: 20;
            anchors.topMargin: 10;
            placeholderText: "Nombre"
        }
        CustomTextField{
            id: textAddress
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.left: parent.left;
            anchors.top: textName.bottom
            anchors.leftMargin: 20;
            anchors.topMargin: 5
            placeholderText: "Direccion"
        }
        CustomTextField{
            id: textEmailCustomer
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.left: parent.left;
            anchors.top: textAddress.bottom
            anchors.leftMargin: 20;
            anchors.topMargin: 5
            placeholderText: "Email"
        }
        CustomTextField{
            id: textCity
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.left: parent.left;
            anchors.top: textEmailCustomer.bottom
            anchors.leftMargin: 20;
            anchors.topMargin: 5
            placeholderText: "Ciudad"
        }
        CustomTextField{
            id: textZip
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.left: parent.left;
            anchors.top: textCity.bottom
            anchors.leftMargin: 20;
            anchors.topMargin: 5
            placeholderText: "Codigo Postal"
        }
        CustomTextField{
            id: textPhone
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.left: parent.left;
            anchors.top: textZip.bottom
            anchors.leftMargin: 20;
            anchors.topMargin: 5
            placeholderText: "Telefono"
        }

        CustomButton{
            id: createCustomer
            width: 190
            height: 35
            text: "Añadir cliente"
            anchors.left: parent.left
            anchors.top: textPhone.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 10
            font.weight: Font.Light
            font.pointSize: 9
            colorDefault: "#00d15b"
            colorPressed: "#00ef68"
            colorMouseOver: "#008337"
            onClicked: {
                clientObj.createClient(textName.text, textAddress.text, textEmailCustomer.text, textCity.text, textZip.text, textPhone.text);
            }
            Connections {
                target: clientObj
                function onClientValidated(message){
                    warningLabel.visible = true
                    warningLabel.text = message;
                    hideWarningTimer.restart()
                }
                function onClientCreated(name, address, mail, city, zip_code, phone) {
                    console.log(name)
                    console.log(address)
                    console.log(mail)
                    console.log(city)
                    console.log(zip_code)
                    console.log(phone)
                    Qt.callLater(function() {
                        internal.createButton(name, address);
                    });
                }
            }
        }

        Label {
            id: warningLabel
            color: "#ee0000"
            text: qsTr("mensaje de advertencia")
            anchors.left: parent.left
            anchors.top: createCustomer.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 10
            font.pointSize: 8
            anchors.leftMargin: 20
            visible: false
        }
    }

}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
