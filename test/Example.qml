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

    signal clientButtonClicked(var clientData)

    QtObject{
        id: internal
        // Create Client LeftMenuButtons
        function createButton(user_id, name, address, mail, city, zip_code, phone) {
            if (leftMenuBtnComponent.status === Component.Ready) {
                // Genera los botones con los datos de los clientes DB
                var newButton = leftMenuBtnComponent.createObject(columnBtnClients);
                newButton.text = name;
                newButton.secondaryTextContent = address
                buttonCount++;
                newButton.tag = "leftMenuBtn" + buttonCount;
                newButton.width = newButton.tag.width

                // La funcion de cada boton
                newButton.clicked.connect(function() {
                    // Itera sobre todos los botones y establece su propiedad isActiveMenu en false
                    for (var i = 0; i < buttonList.length; i++) {
                        buttonList[i].isActiveMenu = false;
                        console.log(user_id)
                        console.log(name)
                        console.log(address)
                        console.log(mail)
                        console.log(city)
                        console.log(zip_code)
                        console.log(phone)
                    }

                    // Establece el botón presionado en true
                    newButton.isActiveMenu = true;

                    var clientData = {
                        name: name,
                        address: address,
                        mail: mail,
                        city: city,
                        zip_code: zip_code,
                        phone: phone,
                        user_id: user_id
                    };
                    clientButtonClicked(clientData); // Emitir la señal
                    
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

    Loader{
        id: stackView
        anchors.fill: parent
        source: Qt.resolvedUrl("pages/clientPage.qml")
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
            var clientUserID = clients[i].user_id;
            var clientName = clients[i].name;
            var clientAddress = clients[i].address;
            var clientEmail = clients[i].email;
            var clientCity = clients[i].city;
            var clientZipCode = clients[i].zip_code;
            var clientPhone = clients[i].phone;
            internal.createButton(clientUserID, clientName, clientAddress, clientEmail, clientCity, clientZipCode, clientPhone);
        }
    }
    Component.onCompleted: {
        // Conexión de la señal clientsRetrieved a la función onClientsReceived
        loginUser.clientsRetrieved.connect(onClientsReceived);
        // Conexión de la señal a la función onClientButtonClicked
        clientButtonClicked.connect(onClientButtonClicked)
    }

    Component.onDestruction: {
        // Es una buena práctica desconectar las señales cuando el objeto se destruye
        loginUser.clientsRetrieved.disconnect(onClientsReceived);
    }

    // Definición de la función que se ejecutará cuando se emita la señal clientButtonClicked
    function onClientButtonClicked(clientData) {
        // Suponiendo que stackView es tu Loader que carga clientPage.qml
        if (stackView.status === Loader.Ready) {
            var clientPage = stackView.item;

            // Asegúrate de que clientPage tiene una propiedad currentClient o un método para actualizar la UI
            if ("currentClient" in clientPage) {
                clientPage.currentClient = clientData;
            } else {
                console.error("clientPage no tiene la propiedad currentClient.");
            }
        } else {
            console.error("clientPage aún no está listo.");
        }
    }
}


import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"


Item {
    //PROPERTIES
    property var currentClient: ({name: "", address: "", mail: "", city: "", zip_code: "", phone: "", user_id: 0})

    onCurrentClientChanged: {
    if (currentClient !== null) {
        textResponseName.text = currentClient.name;
            // Actualizar otros elementos de la UI con los datos del cliente
        }
    }

    // INTERNAL FUNCTIONS
    QtObject{
        id: internal
    }

    Rectangle {
        id: bgPage
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#001d2b"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }

        Text {
                id: textResponseName
                y: 24
                color: "#ffffff"
                text: qsTr("Name Response")
            }
    }
}

