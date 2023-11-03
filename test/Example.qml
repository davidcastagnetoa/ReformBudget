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
            } else {
                console.error("Componente no listo:", leftMenuBtnComponent.errorString());
            }
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

    onClientsRetrieved: {
        for (var i = 0; i < clientsList.length; i++) {
            var clientName = clientsList[i].name;
            var clientAddress = clientsList[i].address;
            createButton(clientName, clientAddress);
        }
    }

    property var buttonList: []

    Column {
        id: columnBtnClients
        Component {
            id: leftMenuBtnComponent
            LeftMenuBtn {
                property string tag: ""
                isActiveMenu: false
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
                Qt.callLater(function() {
                    internal.createButton(name, address);
                });
            }
        }
    }
}


















# Supongamos que 'loginInstance' es una instancia de tu clase 'Login'
loginUser.clientsRetrieved.connect(self.processClients) //instancia del contexto Login.Señal del metodo.connect(self.funcionEjecutora)

def processClients(self, clients):
    for client in clients:
        # Aquí puedes crear botones u otros elementos gráficos usando los datos del cliente.









onClientsRetrieved: {
    for (var i = 0; i < clientsList.length; i++) {
        var clientName = clientsList[i].name;
        var clientAddress = clientsList[i].address;
        createButton(clientName, clientAddress);
    }
}


Component.onCompleted: {
    initializeButtons();
}

function initializeButtons() {
    // Asumiendo que tienes un objeto 'database' que te permite hacer consultas a la DB
    var clients = database.getAllClients();
    for (var i = 0; i < clients.length; i++) {
        createButton(clients[i].name, clients[i].address);
    }
}
