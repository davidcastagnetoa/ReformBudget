import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
// import QtGraphicalEffects 1.15

Window {
    id: mainWindow
    width: 1420
    height: 870
    visible: true
    color: "#717171"
    title: qsTr("Reform Budget")

    Timer {
        id: retryTimer
        interval: 100  // 100 ms
        running: false

        onTriggered: {
            // Intenta crear los botones nuevamente.
            internal.createRandomButtons();
        }
    }

    signal clientButtonClicked(var clientData)
    property var userID : 1
    property int buttonCount: 2
    property var buttonList: []

    Timer {
        id: hideWarningTimer
        interval: 2500  // 2 segundos
        onTriggered: warningLabel.visible = FramelessWindowHint
    }

    QtObject{
        id: internal
        // Create Client LeftMenuButtons
        function createButton(name, address, mail, city, zip_code, phone) {
            if (leftMenuBtnComponent.status === Component.Ready) {
                console.log("componente listo")
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
                        // user_id: user_id
                    };
                    clientButtonClicked(clientData); // Emitir la señal
                    
                    // Agrega el nuevo botón a la lista buttonList
                    buttonList.push(newButton);
                });
            } else if (leftMenuBtnComponent.status === Component.Error) {
                console.error("Error al cargar LeftMenuBtn:", leftMenuBtnComponent.errorString());
                retryTimer.start();
            } else {
                console.log("Componente aun no cargado, reintentar...");
                retryTimer.start();
            }
        }
        function createRandomButtons() {
            for (var i = 0; i < 5; i++) {
                createButton("Cliente " + (i + 1), 
                            "Dirección " + (i + 1), 
                            "email" + (i + 1) + "@example.com",
                            "Ciudad " + (i + 1),
                            "2800" + i,
                            "60000000" + i);
            }
        }
    }


    Column {
        id: columnBtnClients
        Component {
            id: leftMenuBtnComponent

            Button{
                id: btnLeftMenu
                text: qsTr("Left Menu Text")

                // CUSTOM PROPERTIES
                property string tag: ""
                
                property url btnIconSource: "../images/svg_icons/icon_users.svg"
                property color btnColorDefault: "#0d1117"
                property color btnColorMouseOver: "#161b22"
                property color btnColorClicked: "#6dacb6"
                property int iconWidth: 18
                property int iconHeight: 18
                property color activeMenuColorLeft: "#99f1ff"
                property color activeMenuColorRight: "#99f1ff"
                property bool isActiveMenu: false
                property string secondaryTextContent: "Texto Secundario"
                property color textAndOverlayColorDefault: "#1F2328"
                property color textAndOverlayColorMouseOver: "#000000"
                property color textAndOverlayColorClicked: "#FFFFFF"
                property color textSecondaryColorDefault: "#C9D1D9"
                property color textSecondaryColorMouseOver: "#6E7681"
                property color textSecondaryColorClicked: "#a1a1a1"

                QtObject{
                    id: internal

                    // MOUSE OVER AND CLICK CHANGE COLOR
                    property var dynamicColor: if(btnLeftMenu.down){
                                                btnLeftMenu.down ? btnColorClicked : btnColorDefault
                                            } else {
                                                btnLeftMenu.hovered ? btnColorMouseOver : btnColorDefault
                                            }

                }

                implicitWidth: 200
                implicitHeight: 60

                background: Rectangle{
                    id: bgBtn
                    color: isActiveMenu ? btnColorClicked : internal.dynamicColor

                    Canvas {
                        anchors.fill: parent
                        onPaint: {
                            var ctx = getContext('2d');
                            ctx.strokeStyle = "#99757575"; // Color del borde
                            ctx.lineWidth = 1; // Grosor del borde
                            ctx.beginPath();

                            // Dibuja el borde superior
                            ctx.moveTo(0, 0);
                            ctx.lineTo(parent.width, 0);

                            // Dibuja el borde inferior
                            ctx.moveTo(0, parent.height);
                            ctx.lineTo(parent.width, parent.height);

                            ctx.stroke();
                        }
                    }

                    Rectangle{
                        anchors{
                            top: parent.top
                            left: parent.left
                            bottom: parent.bottom
                        }
                        width: 2
                        visible: isActiveMenu
                        color: activeMenuColorLeft
                    }

                    Rectangle{
                        anchors{
                            top: parent.top
                            right: parent.right
                            bottom: parent.bottom
                        }
                        color: activeMenuColorRight
                        width: 2
                        visible: isActiveMenu
                    }

                }

                contentItem: Item{
                    anchors.fill: parent
                    id: content
                    Image {
                        id: iconBtn
                        source: Qt.resolvedUrl(btnIconSource)
                        anchors.leftMargin: 26
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        sourceSize.width: iconWidth
                        sourceSize.height: iconHeight
                        width: iconWidth
                        height: iconHeight
                        fillMode: Image.PreserveAspectFit
                        visible: false
                        antialiasing: true
                    }

                    ColorOverlay{
                        anchors.fill: iconBtn
                        source: Qt.resolvedUrl(iconBtn)
                        color: isActiveMenu ? textAndOverlayColorClicked : btnLeftMenu.down ? textAndOverlayColorClicked : btnLeftMenu.hovered ? textAndOverlayColorMouseOver : textAndOverlayColorDefault
                        anchors.verticalCenter: parent.verticalCenter
                        antialiasing: true
                        width: iconWidth
                        height: iconHeight
                    }
                    Item{
                        id: item1
                        width: 175
                        height: 60
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 75
                        Text{
                            color: isActiveMenu ? textAndOverlayColorClicked : btnLeftMenu.down ? textAndOverlayColorClicked : btnLeftMenu.hovered ? textAndOverlayColorMouseOver : textAndOverlayColorDefault
                            text: btnLeftMenu.text
                            font: btnLeftMenu.font
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            verticalAlignment: Text.AlignVCenter
                            anchors.rightMargin: 15
                            anchors.topMargin: 12
                            anchors.leftMargin: 0
                        }
                        Text{
                            y: 8
                            color: isActiveMenu ? textSecondaryColorClicked : btnLeftMenu.down ? textSecondaryColorClicked : btnLeftMenu.hovered ? textSecondaryColorMouseOver : textSecondaryColorDefault
                            text: secondaryTextContent
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.weight: Font.Light
                            font.family: "Titillium Web Light"
                            font.pointSize: 10
                            anchors.rightMargin: 15
                            anchors.bottomMargin: 12
                            anchors.leftMargin: 0
                        }
                    }

                }
                Component.onCompleted: {
                    console.log("LeftMenuBtn componente cargado correctamente.")
                }
            }
        }
    }

    TextField{
        id: textName
        x: 361
        y: 116
        width: 100
        font.family: "Titillium Web Light"
        font.pointSize: 9
        placeholderText: "Name"
    }

    TextField{
        id: textAddress
        x: 467
        y: 116
        width: 100
        font.family: "Titillium Web Light"
        font.pointSize: 9
        placeholderText: "Address"
    }

    TextField{
        id: textPhone
        x: 573
        y: 116
        width: 100
        font.family: "Titillium Web Light"
        font.pointSize: 9
        placeholderText: "Phone number"
    }

    TextField{
        id: textEmailCustomer
        x: 361
        y: 163
        width: 100
        font.family: "Titillium Web Light"
        font.pointSize: 9
        placeholderText: "Email"
    }

    TextField{
        id: textCity
        x: 467
        y: 163
        width: 100
        font.family: "Titillium Web Light"
        font.pointSize: 9
        placeholderText: "City"
    }

    TextField{
        id: textZip
        x: 573
        y: 163
        width: 100
        font.family: "Titillium Web Light"
        font.pointSize: 9
        placeholderText: "Zip"
    }

    Label {
        id: warningLabel
        x: 679
        y: 134
        color: "#FFFFFF"
        text: qsTr("mensaje de advertencia")
        font.bold: true
        font.family: "Titillium Web Light"
        font.pointSize: 11
        visible: false
    }

    Button{
        id: createCustomer
        x: 679
        y: 163
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
            function onClientCreated(name, address, mail, city, zip_code, phone, userID) {
                console.log(name)
                console.log(address)
                console.log(mail)
                console.log(city)
                console.log(zip_code)
                console.log(phone)
                Qt.callLater(function() {
                    internal.createButton(name, address, mail, city, zip_code, phone);
                });
            }
        }
    }

    Component.onCompleted: {
        internal.createRandomButtons();
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
