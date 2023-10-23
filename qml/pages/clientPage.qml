import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"


Item {
    //PROPERTIES
    property var buttonList: []
    implicitWidth: 1200
    implicitHeight: 775

    Timer {
        id: hideWarningTimer
        interval: 2000  // 2 segundos
        onTriggered: warningLabel.visible = false
    }

    // INTERNAL FUNCTIONS
    QtObject{
        id: internal
        function createButton(name, address) {
            var newButton = leftMenuBtnComponent.createObject(columnBtnClients);
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
            text: qsTr("Customer Data")
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
            width: bgPage.width * 1/5
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.left: parent.left;
            anchors.top: label.bottom;
            anchors.leftMargin: 15
            anchors.topMargin: 10;
            placeholderText: "Name"
        }
        CustomTextField{
            id: textAddress
            width: bgPage.width * 1/5
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.left: textName.right
            anchors.top: parent.top
            anchors.leftMargin: 6
            anchors.topMargin: 44
            placeholderText: "Address"
        }
        CustomTextField{
            id: textPhone
            width: bgPage.width * 1/5
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.left: textAddress.right
            anchors.top: parent.top
            anchors.leftMargin: 6
            anchors.topMargin: 44
            placeholderText: "Phone number"
        }

        CustomTextField{
            id: textEmailCustomer
            width: bgPage.width * 1/5
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.left: parent.left
            anchors.top: textName.bottom
            anchors.topMargin: 7
            anchors.leftMargin: 15
            placeholderText: "Email"
        }
        CustomTextField{
            id: textCity
            width: bgPage.width * 1/5
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.left: textEmailCustomer.right
            anchors.top: textAddress.bottom
            anchors.leftMargin: 6
            anchors.topMargin: 7
            placeholderText: "City"
        }
        CustomTextField{
            id: textZip
            width: bgPage.width * 1/5
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.left: textCity.right
            anchors.top: textPhone.bottom
            anchors.leftMargin: 6
            anchors.topMargin: 7
            placeholderText: "Zip"
        }

        CustomButton{
            id: createCustomer
            width: 150
            height: 35
            text: "Add customer"
            anchors.left: parent.left
            anchors.top: textEmailCustomer.bottom
            anchors.leftMargin: 15
            anchors.topMargin: 15
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
            anchors.left: createCustomer.right
            anchors.top: createCustomer.top
            anchors.bottom: createCustomer.bottom
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 11
            anchors.topMargin: 11
            font.pointSize: 8
            anchors.leftMargin: 20
            visible: false
        }
    }

}





