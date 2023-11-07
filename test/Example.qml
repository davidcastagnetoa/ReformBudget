import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "controls" // Aqui se encuentra LeftMenuBtn.qml

Window {
    id: mainWindow
    width: 1420
    height: 870
    visible: true
    color: "#00000000"
    title: qsTr("Reform Budget")

    QtObject{
        id: internal
        // Create Client LeftMenuButtons
        function createButton(name, address) {
            if (leftMenuBtnComponent.status === Component.Ready) {
                var newButton = leftMenuBtnComponent.createObject(columnBtnClients);
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
            } else if (leftMenuBtnComponent.status === Component.Error) {
                console.error("Error al cargar LeftMenuBtn:", leftMenuBtnComponent.errorString());
            } else {
                console.log("Componente está cargando...");
            }
        }
    }

    property var buttonList: []

    Column {
        id: columnBtnClients
        Component {
            id: leftMenuBtnComponent
            LeftMenuBtn {
                property string tag: ""
                font.weight: Font.Light
                font.family: "Titillium Web Light"
                z: 0
                font.pointSize: 10
                btnIconSource: "../images/svg_icons/icon_users.svg"
            }
        }
    }

    CustomButton{
        id: createCustomer
        onClicked: {
            console.log("userID es: ", userID)
            clientObj.createClient(textName.text, textAddress.text, textEmailCustomer.text, textCity.text, textZip.text, textPhone.text, userID);
        }
        Connections {
            target: clientObj
            function onClientValidated(message){
                warningLabel.visible = true
                if (message === "Rellene todos los campos"){
                    warningLabel.text = message;
                    warningLabel.color = "#ffa0a0"
                } else {
                    warningLabel.text = message;
                    warningLabel.color = "#99f1ff"
                }

                hideWarningTimer.restart()
            }
            function onClientCreated(name, address, mail, city, zip_code, phone, user_id) {
                console.log(name)
                console.log(address)
                console.log(mail)
                console.log(city)
                console.log(zip_code)
                console.log(phone)
                console.log(user_id)
                Qt.callLater(function() {
                    internal.createButton(name, address);
                });
            }
        }
    }

    // Definición de la función que se ejecutará cuando se emita la señal
    function onClientsReceived(clients) {
        for (var i = 0; i < clients.length; i++) {
            var clientName = clients[i].name;
            var clientAddress = clients[i].address;
            internal.createButton(clientName, clientAddress);
        }
    }
    Component.onCompleted: {
        // Conexión de la señal clientsRetrieved a la función onClientsReceived
        loginUser.clientsRetrieved.connect(onClientsReceived);
    }

    Component.onDestruction: {
        // Es una buena práctica desconectar las señales cuando el objeto se destruye
        loginUser.clientsRetrieved.disconnect(onClientsReceived);
    }  
}