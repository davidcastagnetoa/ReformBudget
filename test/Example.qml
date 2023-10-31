Item {
    CustomTextField {
        id: textName
        x: 43
        y: 343
        opacity: 0
        anchors.bottom: textPassword.top
        colorDefault: "#161b22"
        font.family: "Titillium Web Light"
        font.pointSize: 9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 6
        placeholderText: "Username"
    }
    CustomTextField {
        id: textAddress
        x: 43
        y: 343
        opacity: 0
        anchors.bottom: textPassword.top
        colorDefault: "#161b22"
        font.family: "Titillium Web Light"
        font.pointSize: 9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 6
        placeholderText: "Username"
    }
    CustomTextField {
        id: textEmailCustomer
        x: 43
        y: 343
        opacity: 0
        anchors.bottom: textPassword.top
        colorDefault: "#161b22"
        font.family: "Titillium Web Light"
        font.pointSize: 9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 6
        placeholderText: "Username"
    }
    CustomTextField {
        id: textCity
        x: 43
        y: 343
        opacity: 0
        anchors.bottom: textPassword.top
        colorDefault: "#161b22"
        font.family: "Titillium Web Light"
        font.pointSize: 9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 6
        placeholderText: "Username"
    }
    CustomTextField {
        id: textZip
        x: 43
        y: 343
        opacity: 0
        anchors.bottom: textPassword.top
        colorDefault: "#161b22"
        font.family: "Titillium Web Light"
        font.pointSize: 9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 6
        placeholderText: "Username"
    }
    CustomTextField {
        id: textPhone
        x: 43
        y: 343
        opacity: 0
        anchors.bottom: textPassword.top
        colorDefault: "#161b22"
        font.family: "Titillium Web Light"
        font.pointSize: 9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 6
        placeholderText: "Username"
    }

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

    property var buttonList: []

    CustomButton{
        id: createCustomer
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
                    createButton(name, address);
                });
            }
        }
    }
}
property var userID = (signupUser && signupUser.userId) ? signupUser.userId : loginUser.userId

CustomButton{
    id: createCustomer
    onClicked: {
        clientObj.createClient(textName.text, textAddress.text, textEmailCustomer.text, textCity.text, textZip.text, textPhone.tex, userID);
    }
    Connections {
        target: clientObj
        function onClientValidated(message){
            warningLabel.visible = true
            if (message == "Rellene todos los campos"){
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