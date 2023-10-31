import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "controls"

Window {
    id: mainWindow
    width: 1420
    height: 870
    visible: true
    color: "#00000000"
    title: qsTr("Reform Budget")

    // Custom Properties
    property string username
    property alias mainWindow: mainWindow

    // REMOVE TITLE BAR
    flags: Qt.Window | Qt.FramelessWindowHint

    // // PROPERTIES
    property var buttonList: []
    property int windowStatus: 0
    property int windowMargin: 10
    property bool previewCollapse: false
    property int buttonCount: 2

    property int userID: {
        console.log("loginUser.userId: ", loginUser && loginUser.userId);
        console.log("signupUser.userId: ", signupUser && signupUser.userId);
        if (loginUser && loginUser.userId > 0) {
            return loginUser.userId;
        }
        if (signupUser && signupUser.userId > 0) {
            return signupUser.userId;
        }
    }


    Timer {
        id: hideWarningTimer
        interval: 2500  // 2 segundos
        onTriggered: warningLabel.visible = false
    }

    // INTERNAL FUNCTIONS
    QtObject{
        id: internal

        // Maximize Restore
        function maximizeRestore(){
            if(windowStatus == 0){
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
                bg.anchors.leftMargin = 0
                bg.anchors.rightMargin = 0
                bg.anchors.bottomMargin = 0
                restoreButton.btnIconSource = "../images/svg_icons/restore_icon.svg"
            }
            else{
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                bg.anchors.leftMargin = 10
                bg.anchors.rightMargin = 10
                bg.anchors.bottomMargin = 10
                restoreButton.btnIconSource = "../images/svg_icons/maximize_icon.svg"
            }
        }
        // If Maximized Restore
        function ifMaximizedRestore(){
            if(windowStatus == 1){
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                restoreButton.btnIconSource = "../images/svg_icons/maximize_icon.svg"
            }
        }
        // Restore Margins
        function restoreMargins(){
            windowStatus = 0
            windowMargin = 10
            restoreButton.btnIconSource = "../images/svg_icons/maximize_icon.svg"
        }
        // Toggle Preview right screen
        function collapsePreview(){
            if(previewCollapse == false){
                tooglePreviewBtn.btnIconMirror = true
                animationPreview.running = true
                previewCollapse = true
            }else{
                tooglePreviewBtn.btnIconMirror = false
                animationPreview.running = true
                previewCollapse = false
            }
        }
        // Create Client LeftMenuButtons
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
        id: bg
        width: 1400
        height: 860
        color: "#0d1117"
        anchors.fill: parent
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 0

        Rectangle {
            id: appContainer
            height: 660
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            Rectangle {
                id: topBar
                height: 60
                color: "#161b22"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.rightMargin: 0
                anchors.leftMargin: 0

                ToggleBtnHamburger {
                    btnColorClicked: "#99f1ff"
                    onClicked: animationMenu.running = true
                }


                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 70
                    anchors.topMargin: 0

                    Rectangle {
                        id: mouse_area
                        opacity: 1
                        border.color: "#00000000"
                        border.width: 1
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        z: 0
                        gradient: Gradient {
                            GradientStop {
                                position: 0
                                color: "#00000000"
                            }

                            GradientStop {
                                position: 1
                                color: "#070a0d"
                            }
                        }
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        anchors.topMargin: 0
                        anchors.leftMargin: 0

                        MouseArea{
                            id: mouseArea
                            anchors.fill: parent
                            onDoubleClicked: {
                                internal.maximizeRestore()
                            }
                        }
                        DragHandler{
                            onActiveChanged: if(active){
                                                 mainWindow.startSystemMove()
                                             }
                        }
                    }

                    Image {
                        id: iconApp
                        width: 46
                        height: 30
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../images/Logo.png"
                        smooth: true
                        sourceSize.height: 30
                        sourceSize.width: 46
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 5
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: labelTitle
                        width: 110
                        height: 35
                        color: "#ffffff"
                        text: qsTr("Reform Budget -")
                        anchors.left: iconApp.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 12
                        font.bold: false
                        font.family: "Titillium Web Extralight"
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 5
                    }
                    Label {
                        id: labelWelcome
                        width: 65
                        color: "#ffffff"
                        text: qsTr("Welcome: ")
                        anchors.left: labelTitle.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 12
                        font.bold: false
                        font.family: "Titillium Web Extralight"
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 5
                    }
                    Label {
                        id: labelUsername
                        width: 350
                        color: "#ffffff"
                        text: (signupUser && signupUser.loggedUsername) ? signupUser.loggedUsername : loginUser.loggedUsername
                        anchors.left: labelWelcome.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 12
                        font.bold: false
                        font.family: "Titillium Web Extralight"
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 5
                    }

                }

                Row {
                    id: rowMaxMinBtn
                    x: 906
                    width: 105
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                    MinimizeButton {
                        id: minimizeButton
                        height: 35
                        btnColorClicked: "#6dacb6"
                        btnIconSource: "../images/svg_icons/minimize_icon.svg"
                        onClicked: {
                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }
                    }

                    RestoreButton {
                        id: restoreButton
                        height: 35
                        btnColorClicked: "#6dacb6"
                        btnIconSource: "../images/svg_icons/maximize_icon.svg"
                        onClicked: {
                            internal.maximizeRestore()
                        }
                    }

                    CloseButton {
                        id: closeButton
                        height: 35
                        btnColorClicked: "#ff5555"
                        btnIconSource: "../images/svg_icons/close_icon.svg"
                        onClicked: {
                            mainWindow.close()
                        }
                    }


                }



                Rectangle {
                    id: topBarDescription
                    color: "#0d1117"
                    border.color: "#f2000000"
                    border.width: 1
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 35
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                    anchors.bottomMargin: 0

                    Label {
                        id: labelTopInfoLeft
                        color: "#a1a1a1"
                        text: qsTr("Create budgets for your enterprise")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Titillium Web Light"
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 300
                        anchors.leftMargin: 10
                        anchors.topMargin: 0
                        font.pointSize: 10
                    }

                    Label {
                        id: labelTopInfoRight
                        color: "#a1a1a1"
                        text: qsTr("v.0.1.0")
                        anchors.left: labelTopInfoLeft.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Titillium Web Light"
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 6
                        anchors.leftMargin: 0
                        font.pointSize: 10
                    }
                }

            }

            Rectangle {
                id: content
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.rightMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: "#161b22"
                    border.width: 0
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0

                    PropertyAnimation{
                        id: animationMenu
                        target: leftMenu
                        property: "width"
                        to: if(leftMenu.width == 200) return 70; else return 200
                        duration: 250
                        easing.type: Easing.InOutQuint
                    }


                    Column {
                        id: clientCol
                        height: leftMenu.height * 0.65
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.rightMargin: 0
                        z: 0
                        spacing: -1


                        Item {
                            id: separator01
                            width: clientCol.width
                            height: 20  // Añade un espacio de 15px en la parte superior de la columna.
                        }

                        Image {
                            id: image
                            width: 190
                            height: 50
                            horizontalAlignment: Image.AlignHCenter
                            verticalAlignment: Image.AlignVCenter
                            source: "../images/ReformBudget_Logo.png"
                            z: 0
                            mirror: false
                            sourceSize.height: 50
                            sourceSize.width: 190
                            fillMode: Image.PreserveAspectFit
                        }
                        Item {
                            id: separator02
                            width: clientCol.width
                            height: 20  // Añade un espacio de 15px en la parte superior de la columna.
                        }
                        Label {
                            id: labelClients
                            width: clientCol.width
                            color: "#efefef"
                            text: qsTr("Clients")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.weight: Font.ExtraLight
                            font.pointSize: 10
                            font.family: "Titillium Web Light"
                        }
                        Item {
                            id: separator03
                            width: clientCol.width
                            height: 10  // Añade un espacio de 15px en la parte superior de la columna.
                        }

                        ScrollView {
                            id: scrollViewClients
                            y: 90
                            width: clientCol.width
                            height: clientCol.height - 115
                            contentWidth: -1
                            focusPolicy: Qt.ClickFocus
                            wheelEnabled: true
                            hoverEnabled: true
                            spacing: 2
                            contentHeight: columnBtnClients.height
                            clip: true
                            ScrollBar.vertical.interactive: true
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff


                            Column {
                                id: columnBtnClients
                                width: clientCol.width
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                spacing: -1

                                Component {
                                    id: leftMenuBtnComponent
                                    LeftMenuBtn {
                                        property string tag: ""
                                        font.weight: Font.Light
                                        font.family: "Titillium Web Light"
                                        isActiveMenu: false
                                        z: 0
                                        font.pointSize: 10
                                        btnIconSource: "../images/svg_icons/icon_users.svg"
                                    }
                                }
                            }

                        }



                    }

                    Rectangle {
                        id: bgBudgetCol
                        x: 0
                        y: 520
                        color: "#161b22"
                        border.color: "#00000000"
                        border.width: 0
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: clientCol.bottom
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 0

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
                                ctx.stroke();
                            }
                        }
                        Label {
                            id: labelBudgets
                            width: clientCol.width
                            color: "#efefef"
                            text: qsTr("Budgets")
                            anchors.top: parent.top
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.weight: Font.ExtraLight
                            anchors.topMargin: 5
                            font.pointSize: 10
                            font.family: "Titillium Web Light"
                        }


                        Column {
                            id: budgetCol
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: labelBudgets.bottom
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 5
                        }
                    }


                }

                Rectangle {
                    id: contentArea
                    color: "#0d1117"
                    border.width: 0
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    z: 0
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0
                    anchors.leftMargin: 0

                    Rectangle {
                        id: customerDataContent
                        height: 196
                        color: "#00000000"
                        anchors.left: parent.left
                        anchors.right: contentPreview.left
                        anchors.top: parent.top
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0

                        Label {
                            id: customerDataLbl
                            color: "#ededed"
                            text: qsTr("Customer Data")
                            anchors.left: parent.left
                            anchors.top: parent.top
                            font.family: "Titillium Web Extralight"
                            font.pointSize: 16
                            anchors.leftMargin: 15
                            anchors.topMargin: 10
                        }

                        Grid {
                            id: customerData
                            x: 0
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: customerDataLbl.bottom
                            anchors.topMargin: 10
                            anchors.rightMargin: 10
                            anchors.leftMargin: 10
                            spacing: 5
                            rows: 2
                            columns: 3


                            CustomTextField{
                                id: textName
                                x: 0
                                y: 0
                                width: (customerData.width * 1/3) - 5
                                font.family: "Titillium Web Light"
                                font.pointSize: 9
                                placeholderText: "Name"
                            }

                            CustomTextField{
                                id: textAddress
                                x: 246
                                y: 0
                                width: (customerData.width * 1/3) - 5
                                font.family: "Titillium Web Light"
                                font.pointSize: 9
                                placeholderText: "Address"
                            }

                            CustomTextField{
                                id: textPhone
                                x: 492
                                y: 0
                                width: (customerData.width * 1/3) - 5
                                font.family: "Titillium Web Light"
                                font.pointSize: 9
                                placeholderText: "Phone number"
                            }

                            CustomTextField{
                                id: textEmailCustomer
                                x: 0
                                y: 47
                                width: (customerData.width * 1/3) - 5
                                font.family: "Titillium Web Light"
                                font.pointSize: 9
                                placeholderText: "Email"
                            }

                            CustomTextField{
                                id: textCity
                                x: 246
                                y: 47
                                width: (customerData.width * 1/3) - 5
                                font.family: "Titillium Web Light"
                                font.pointSize: 9
                                placeholderText: "City"
                            }

                            CustomTextField{
                                id: textZip
                                x: 492
                                y: 47
                                width: (customerData.width * 1/3) - 5
                                font.family: "Titillium Web Light"
                                font.pointSize: 9
                                placeholderText: "Zip"
                            }


                        }

                        CustomButton{
                            id: createCustomer
                            y: 160
                            width: 150
                            height: 35
                            text: "Add customer"
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 10
                            anchors.bottomMargin: 10
                            font.weight: Font.Light
                            font.pointSize: 9
                            colorDefault: "#6dacb6"
                            colorPressed: "#99f1ff"
                            colorMouseOver: "#5f969e"
                            onClicked: {
                                console.log("userID es: ", userID)
                                clientObj.createClient(textName.text, textAddress.text, textEmailCustomer.text, textCity.text, textZip.text, textPhone.text, userID);
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

                        Label {
                            id: warningLabel
                            color: "#ffa0a0"
                            text: qsTr("mensaje de advertencia")
                            anchors.left: createCustomer.right
                            anchors.top: createCustomer.top
                            anchors.bottom: createCustomer.bottom
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                            font.family: "Titillium Web Light"
                            anchors.leftMargin: 15
                            anchors.bottomMargin: 10
                            anchors.topMargin: 10
                            font.pointSize: 11
                            visible: false
                        }





                    }

                    // Separator
                    Rectangle{
                        id: separator
                        height: 1
                        color: "#bf2c333a"
                        anchors.left: parent.left
                        anchors.right: contentPreview.left
                        anchors.top: customerDataContent.bottom
                        anchors.topMargin: 0
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                    }

                    Rectangle {
                        id: contentPages
                        color: "#00000000"
                        border.width: 0
                        anchors.left: parent.left
                        anchors.right: contentPreview.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 201

                        // StackView {
                        //     id: stackView
                        //     anchors.fill: parent
                        //     initialItem: Qt.resolvedUrl("pages/clientPage.qml")
                        // }
                        Loader{
                            id: stackView
                            anchors.fill: parent
                            source: Qt.resolvedUrl("pages/clientPage.qml")
                        }
                    }

                    onWidthChanged: {
                        if (previewCollapse) {
                            contentPreview.width = 5;
                        } else {
                            contentPreview.width = contentArea.width * 2/5;
                        }
                    }

                    Rectangle {
                        id: contentPreview
                        x: 639
                        width: contentArea.width * 2/5
                        color: "#00000000"
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0

                        PropertyAnimation{
                            id: animationPreview
                            target: contentPreview
                            property: "width"
                            // to: if(contentPreview.width == contentArea.width * 2/5) return 35; else return contentArea.width * 2/5
                            to: if(previewCollapse == false) return 5; else return (contentArea.width * 2/5)
                            duration: 450
                            easing.type: Easing.InOutCirc
                        }

                        ExpandPanelButton {
                            id: tooglePreviewBtn
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: rightSide.left
                            btnColorClicked: "#99f1ff"
                            btnColorMouseOver: "#0f141b"
                            clip: true
                            anchors.rightMargin: -5
                            btnIconMirror: false
                            onClicked: {
                                internal.collapsePreview()
                            }
                        }

                        Rectangle {
                            id: rightSide
                            y: 5
                            color: "#161b22"
                            radius: 5
                            border.color: "#59000000"
                            border.width: 1
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 0
                            layer.wrapMode: ShaderEffectSource.ClampToEdge
                            scale: 1
                            transformOrigin: Item.Center
                            z: 1
                            anchors.topMargin: 5
                            clip: true
                            anchors.bottomMargin: 5
                            anchors.rightMargin: 0

                            Label {
                                id: previewLbl
                                width: 65
                                color: "#ffffff"
                                text: qsTr("Preview")
                                anchors.left: parent.left
                                anchors.top: parent.top
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                font.weight: Font.Normal
                                font.family: "Titillium Web ExtraLight"
                                anchors.topMargin: 5
                                anchors.leftMargin: 20
                                font.pointSize: 11
                            }
                        }


                    }






                }

                Rectangle {
                    id: bottomArea
                    color: "#0d1117"
                    border.color: "#f2000000"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentArea.bottom
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.leftMargin: 0

                    Label {
                        id: labelTopInfoLeft1
                        color: "#a1a1a1"
                        text: qsTr("Developed by David Castagneto - 2023")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Titillium Web Light"
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 30
                        anchors.topMargin: 0
                        anchors.leftMargin: 10
                        font.pointSize: 9
                    }

                    MouseArea {
                        id: resizeWindow
                        x: 884
                        y: 1
                        width: 25
                        height: 25
                        opacity: 0.5
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        cursorShape: Qt.SizeFDiagCursor

                        DragHandler{
                            target: null
                            onActiveChanged: if(active){
                                                 mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                                             }
                        }

                        Image {
                            id: resizeImage
                            width: 16
                            height: 16
                            anchors.fill: parent
                            source: "../images/svg_icons/resize_icon.svg"
                            anchors.leftMargin: 5
                            anchors.topMargin: 5
                            sourceSize.height: 16
                            sourceSize.width: 16
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }
                    }
                }


            }


        }
    }


    MouseArea {
        id: resizeLeft
        x: 990
        y: 20
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 0
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){ mainWindow.startSystemResize(Qt.LeftEdge) }
        }
    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 35
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){ mainWindow.startSystemResize(Qt.RightEdge) }
        }

    }

    MouseArea {
        id: resizeBottom
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){ mainWindow.startSystemResize(Qt.BottomEdge) }
        }
    }

}






















