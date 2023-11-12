import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./controls"

Window {
    id: mainWindow
    width: 1420
    height: 870
    visible: true
    color: "#00000000"
    title: qsTr("Reform Budget")

    // REMOVE TITLE BAR
    flags: Qt.Window | Qt.FramelessWindowHint

    // Signals
    signal clientButtonClicked(var clientData)

    // Custom Properties
    property string username
    property alias mainWindow: mainWindow

    // // PROPERTIES
    property var buttonList: []
    property int windowStatus: 0
    property int windowMargin: 10
    property bool previewCollapse: false
    property bool budgetBarCollapse: false
    property bool isDarkMode: true
    property int buttonCount: 2
    
    // IMAGES
    property url toggleDarkModelogoSourceW: "../images/svg_icons/png_icons_wanderson/bluedaynight.png"
    property url toggleDarkModelogoSourceB: "../images/svg_icons/png_icons_wanderson/blackdaynight.png"
    property url resizeImageSourceNight: "../images/svg_icons/png_icons_wanderson/resize_icon_Dark.png"
    property url resizeImageSourceDay: "../images/svg_icons/png_icons_wanderson/resize_icon_Light.png"
    property url leftImageSourceNight: "../images/ReformBudgetLogoNight.png"
    property url leftImageSourceDay: "../images/ReformBudgetLogoDay.png"
    property url iconAppNight: "../images/LogoNight.png"
    property url iconAppDay: "../images/LogoDay.png"
    property color warningLabelNight: "#ffa0a0"
    property color warningLabelDay: "#A60000"

    // COLORS
    // mouse_area
    property color gradientStartNight : "#00000000"
    property color gradientEndNight : "#070a0d"
    property color gradientStartDay : "#ffffff"
    property color gradientEndDay : "#d1d1d1"

    // topBar
    property color topBarBgNight : "#161b22"
    property color topBarBgDay : "#d1d1d1"

    // contentArea
    property color contentAreaNight : "#0d1117"
    property color contentAreaDay : "#dbdcdf"

    // contentPages
    property color contentPagesNight : "#0d1117"
    property color contentPagesDay : "#dbdcdf"

    // separator
    property color separatorNight : "#bf2c333a"
    property color separatorDay : "#66657686"

    // topBarDescription
    property color topBarDescriptionBgNight: "#0d1117"
    property color topBarDescriptionBgDay: "#dbdcdf"
    property color topBarDescriptionLineNight: "#f2000000"
    property color topBarDescriptionLineDay: "#b9b7b7b7"

    // bottomArea
    property color bottomAreaBgNight: "#0d1117"
    property color bottomAreaBgDay: "#dbdcdf"
    property color bottomAreaLineNight: "#f2000000"
    property color bottomAreaLineDay: "#b9b7b7b7"

    // rightSide
    property color rightSideBgNight: "#161b22"
    property color rightSideLineNight: "#59000000"
    property color rightSideBgDay: "#d0d1d5"
    property color rightSideLineDay: "#bf242424"

    // ToggleBtnHamburger
    property color toggleBtnHamburgerColorDefaultNight: "#161b22"
    property color toggleBtnHamburgerColorMouseOverNight: "#0d1117"
    property color toggleBtnHamburgerColorClickedNight: "#99f1ff"
    property color toggleBtnHamburgerColorDefaultDay: "#d0d1d5"
    property color toggleBtnHamburgerColorMouseOverDay: "#aeb3b4"
    property color toggleBtnHamburgerColorClickedDay: "#5f969e"

    // minimizeButton, restoreButton, closeButton
    property color btnColorDefaultNight: "#161b22"
    property color btnColorMouseOverNight: "#0d1117"
    property color btnColorClickedNight: "#6dacb6"
    property color closeBtnColorClickedNight: "#ff5555"

    property color btnColorDefaultDay: "#d0d1d5"
    property color btnColorMouseOverDay: "#aeb3b4"
    property color btnColorClickedDay: "#3a5b61"
    property color closeBtnColorClickedDay: "#ad2424"

    // leftMenu
    property color leftMenuBgNight : "#161b22"
    property color leftMenuBgDay : "#d0d1d5"

    //leftMenuBtn
    property color leftMenuBtnColorDefaultNight: "#0d1117"
    property color leftMenuBtnColorMouseOverNight: "#161b22"
    property color leftMenuBtnColorClickedNight: "#6dacb6"
    property color textAndOverlayColorDefaultNight: "#C9D1D9"
    property color textAndOverlayColorMouseOverNight: "#FFFFFF"
    property color textAndOverlayColorClickedNight: "#000000"
    property color textSecondaryColorDefaultNight: "#6E7681"
    property color textSecondaryColorMouseOverNight: "#C9D1D9"
    property color textSecondaryColorClickedNight: "#1F2328"
    property color leftMenuBtnColorDefaultDay: "#dbdcdf"
    property color leftMenuBtnColorMouseOverDay: "#bcbdc1"
    property color leftMenuBtnColorClickedDay: "#000000"
    property color textAndOverlayColorDefaultDay: "#1F2328"
    property color textAndOverlayColorMouseOverDay: "#000000"
    property color textAndOverlayColorClickedDay: "#FFFFFF"
    property color textSecondaryColorDefaultDay: "#656D76"
    property color textSecondaryColorMouseOverDay: "#1F2328"
    property color textSecondaryColorClickedDay: "#a1a1a1"
    property color activeMenuColorLeftNight: "#99f1ff"
    property color activeMenuColorRightNight: "#99f1ff"
    property color activeMenuColorLeftDay: "#ec733a"
    property color activeMenuColorRightDay: "#ec733a"

    // bgBudgetCol
    property color bgBudgetColBgNight : "#161b22"
    property color bgBudgetColBgDay : "#d0d1d5"

    // InputField Dark
    property color colorOnFocusNight: "#202833"
    property color colorMouseOverNight: "#293341"
    property color colorDefaultNight: "#161b22"
    property color placeholderTextColorNight: "#b1b4bf"
    property color textColorInputNight: "#ffffff"
    property color selectionColorInputNight: "#99f1ff"
    property color selectedTextColorInputNight: "#ffffff"
    
    // InputField Light
    property color colorOnFocusDay: "#ccd1d3"
    property color colorMouseOverDay: "#d9d9d9" 
    property color colorDefaultDay: "#ececec"
    property color placeholderTextColorDay: "#111215"
    property color textColorInputDay: "#000000"
    property color selectionColorInputDay: "#161b22"
    property color selectedTextColorInputDay: "#000000"

    //Button
    property color colorDefaultBtnDay: "#0c1122"
    property color colorMouseOverBtnDay: "#111831"
    property color colorPressedBtnDay: "#ec733a"

    property color textBtnColorDefaultDay: "#FFFFFF"
    property color textBtnColorMouseOverDay: "#FFFFFF"
    property color textBtnColorClickedDay: "#000000"

    //Button
    property color colorDefaultBtnNight: "#6dacb6"
    property color colorMouseOverBtnNight: "#6198a1"
    property color colorPressedBtnNight: "#99f1ff"

    property color textBtnColorDefaultNight: "#000000"
    property color textBtnColorMouseOverNight: "#000000"
    property color textBtnColorClickedNight: "#1F2328"

    //Client Page
    property color textBgBorderRectangleNight : "#161b22"
    property color textBgColorRectangleNight : "#21262d"
    property color textBgBorderRectangleDay : "#161b22"
    property color textBgColorRectangleDay : "#21262d"

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
            if(windowStatus === 0){
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
            if(windowStatus === 1){
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
            if(previewCollapse === false){
                tooglePreviewBtn.btnIconMirror = true
                animationPreview.running = true
                previewCollapse = true
            }else{
                tooglePreviewBtn.btnIconMirror = false
                animationPreview.running = true
                previewCollapse = false
            }
        }
        // Toggle Budget Bar
        function collapseBudgetPreview(){
            if(budgetBarCollapse === false){
                toogleBudgetPreviewBtn.btnIconSource = "../images/svg_icons/up_icon.svg"
                animationbgBudgetCol.running = true
                budgetBarCollapse = true
            }else{
                toogleBudgetPreviewBtn.btnIconSource = "../images/svg_icons/down_icon.svg"
                animationbgBudgetCol.running = true
                budgetBarCollapse = false
            }
        }
        // Toggle Dark and Light Mode
        function toggleDarkMode() {
            var clientPage = stackView.item;
            if(isDarkMode === true){
                // Light
                clientPage.textBgColorRectangle = "#ececec";
                clientPage.textBgBorderRectangle = "#66657686";
                clientPage.textLblColor = "#656D76";
                clientPage.textResTxtColor = "#1f2328";
                isDarkMode = false 
            }else{
                // Dark
                clientPage.textBgColorRectangle = "#161b22";
                clientPage.textBgBorderRectangle = "#21262d";
                clientPage.textLblColor = "#818995";
                clientPage.textResTxtColor = "#FFFFFF";
                isDarkMode = true 
            }
        }
        // Create Client LeftMenuButtons
        function createButton(name, address, mail, city, zip_code, phone) {
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
                        // console.log(user_id)
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
                        // user_id: user_id
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
                color: isDarkMode ? topBarBgNight : topBarBgDay
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.rightMargin: 0
                anchors.leftMargin: 0

                ToggleBtnHamburger {
                    btnColorMouseOver: isDarkMode ? toggleBtnHamburgerColorMouseOverNight : toggleBtnHamburgerColorMouseOverDay
                    btnColorDefault: isDarkMode ? toggleBtnHamburgerColorDefaultNight : toggleBtnHamburgerColorDefaultDay
                    btnColorClicked: isDarkMode ? toggleBtnHamburgerColorClickedNight : toggleBtnHamburgerColorClickedDay
                    btnIconColor: isDarkMode? "#FFFFFF" : "#000000"
                    onClicked: animationMenu.running = true
                }


                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: rowMaxMinBtn.left
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                    anchors.topMargin: 0

                    Rectangle {
                        id: mouse_area
                        opacity: 1
                        border.color: "#00000000"
                        border.width: 1
                        anchors.fill: parent
                        z: 0
                        gradient: Gradient {
                            GradientStop {
                                position: 0
                                color: isDarkMode ? gradientStartNight : gradientStartDay
                            }

                            GradientStop {
                                position: 1
                                color: isDarkMode ? gradientEndNight : gradientEndDay
                            }
                        }

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
                        source: isDarkMode ? iconAppNight : iconAppDay
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
                        color: isDarkMode ? "#ffffff" : "#000000"
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
                        color: isDarkMode ? "#ffffff" : "#000000"
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
                        color: isDarkMode ? "#ffffff" : "#000000"
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
                    width: 140
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                    TopBarButton {
                        id: btnDayNight
                        btnIconSource: isDarkMode ? toggleDarkModelogoSourceW : toggleDarkModelogoSourceB
                        btnColorClicked: "#99f1ff"
                        btnColorMouseOver: "#6dacb6"
                        btnColorDefault: "#00000000"
                        onClicked: internal.toggleDarkMode()
                    }

                    MinimizeButton {
                        id: minimizeButton
                        height: 35
                        btnColorMouseOver: isDarkMode ? btnColorMouseOverNight : btnColorMouseOverDay
                        btnColorDefault: isDarkMode ? btnColorDefaultNight : btnColorDefaultDay
                        btnColorClicked: isDarkMode ? btnColorClickedNight : btnColorClickedDay
                        btnIconSource: "../images/svg_icons/minimize_icon.svg"
                        btnIconColor: isDarkMode? "#FFFFFF" : "#000000"
                        onClicked: {
                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }
                    }

                    RestoreButton {
                        id: restoreButton
                        height: 35
                        btnColorMouseOver: isDarkMode ? btnColorMouseOverNight : btnColorMouseOverDay
                        btnColorDefault: isDarkMode ? btnColorDefaultNight : btnColorDefaultDay
                        btnColorClicked: isDarkMode ? btnColorClickedNight : btnColorClickedDay
                        btnIconSource: "../images/svg_icons/maximize_icon.svg"
                        btnIconColor: isDarkMode? "#FFFFFF" : "#000000"
                        onClicked: {
                            internal.maximizeRestore()
                        }
                    }

                    CloseButton {
                        id: closeButton
                        height: 35
                        btnColorMouseOver: isDarkMode ? btnColorMouseOverNight : btnColorMouseOverDay
                        btnColorDefault: isDarkMode ? btnColorDefaultNight : btnColorDefaultDay
                        btnColorClicked: isDarkMode ? closeBtnColorClickedNight : closeBtnColorClickedDay
                        btnIconSource: "../images/svg_icons/close_icon.svg"
                        btnIconColor: isDarkMode? "#FFFFFF" : "#000000"
                        onClicked: {
                            mainWindow.close()
                        }
                    }


                }



                Rectangle {
                    id: topBarDescription
                    color: isDarkMode ? topBarDescriptionBgNight : topBarDescriptionBgDay
                    border.color: isDarkMode ? topBarDescriptionLineNight : topBarDescriptionLineDay
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
                        color: isDarkMode ? "#a1a1a1" : "#3d3d3d"
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
                        color: isDarkMode ? "#a1a1a1" : "#3d3d3d"
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
//                    width: 70
                    width: 200
                    color: isDarkMode ? leftMenuBgNight : leftMenuBgDay
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
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: bgBudgetCol.top
                        anchors.bottomMargin: 0
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
                            source: isDarkMode ? leftImageSourceNight : leftImageSourceDay
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
                            color: isDarkMode ? "#efefef" : "#0c0c0c"
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

                                // LeftMenuBtn{
                                //     id: leftMenuExample
                                //     btnColorDefault: isDarkMode ? leftMenuBtnColorDefaultNight : leftMenuBtnColorDefaultDay
                                //     btnColorMouseOver: isDarkMode ? leftMenuBtnColorMouseOverNight : leftMenuBtnColorMouseOverDay
                                //     btnColorClicked: isDarkMode ? leftMenuBtnColorClickedNight : leftMenuBtnColorClickedDay
                                //     textAndOverlayColorDefault: isDarkMode ? textAndOverlayColorDefaultNight : textAndOverlayColorDefaultDay
                                //     textAndOverlayColorMouseOver: isDarkMode ? textAndOverlayColorMouseOverNight : textAndOverlayColorMouseOverDay
                                //     textAndOverlayColorClicked: isDarkMode ? textAndOverlayColorClickedNight : textAndOverlayColorClickedDay
                                //     textSecondaryColorDefault: isDarkMode ? textSecondaryColorDefaultNight : textSecondaryColorDefaultDay
                                //     textSecondaryColorMouseOver: isDarkMode ? textSecondaryColorMouseOverNight : textSecondaryColorMouseOverDay
                                //     textSecondaryColorClicked: isDarkMode ? textSecondaryColorClickedNight : textSecondaryColorClickedDay
                                //     activeMenuColorRight: isDarkMode ? activeMenuColorRightNight : activeMenuColorRightDay
                                //     activeMenuColorLeft: isDarkMode ? activeMenuColorLeftNight : activeMenuColorLeftDay
                                // }

                                Component {
                                    id: leftMenuBtnComponent
                                    LeftMenuBtn {
                                        property string tag: ""
                                        font.weight: Font.Light
                                        font.family: "Titillium Web Light"
                                        font.pointSize: 10
                                        btnIconSource: "../images/svg_icons/icon_users.svg"
                                        btnColorDefault: isDarkMode ? leftMenuBtnColorDefaultNight : leftMenuBtnColorDefaultDay
                                        btnColorMouseOver: isDarkMode ? leftMenuBtnColorMouseOverNight : leftMenuBtnColorMouseOverDay
                                        btnColorClicked: isDarkMode ? leftMenuBtnColorClickedNight : leftMenuBtnColorClickedDay
                                        textAndOverlayColorDefault: isDarkMode ? textAndOverlayColorDefaultNight : textAndOverlayColorDefaultDay
                                        textAndOverlayColorMouseOver: isDarkMode ? textAndOverlayColorMouseOverNight : textAndOverlayColorMouseOverDay
                                        textAndOverlayColorClicked: isDarkMode ? textAndOverlayColorClickedNight : textAndOverlayColorClickedDay
                                        textSecondaryColorDefault: isDarkMode ? textSecondaryColorDefaultNight : textSecondaryColorDefaultDay
                                        textSecondaryColorMouseOver: isDarkMode ? textSecondaryColorMouseOverNight : textSecondaryColorMouseOverDay
                                        textSecondaryColorClicked: isDarkMode ? textSecondaryColorClickedNight : textSecondaryColorClickedDay
                                        activeMenuColorRight: isDarkMode ? activeMenuColorRightNight : activeMenuColorRightDay
                                        activeMenuColorLeft: isDarkMode ? activeMenuColorLeftNight : activeMenuColorLeftDay
                                    }
                                }
                            }
                        }



                    }

                    Rectangle {
                        id: bgBudgetCol
                        x: 0
                        y: 800
                        height: 300
                        color: isDarkMode ? bgBudgetColBgNight : bgBudgetColBgDay
                        border.color: "#00000000"
                        border.width: 0
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        z: 0
                        anchors.bottomMargin: 0

                        PropertyAnimation{
                            id: animationbgBudgetCol
                            target: bgBudgetCol
                            property: "height"
                            to: if(bgBudgetCol.height == 300) return 30; else return 300
                            duration: 250
                            easing.type: Easing.InOutQuint
                        }

                        ExpandBudgetButton{
                            id: toogleBudgetPreviewBtn
                            anchors.bottom: parent.top
                            z: -1
                            clip: true
                            btnColorClicked: "#99f1ff"
                            btnColorMouseOver: "#0f141b"
                            anchors.bottomMargin: -5
                            btnIconSource: "../images/svg_icons/down_icon.svg"
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: {
                                internal.collapseBudgetPreview()
                            }
                        }
                        Rectangle {
                            id: separatorBudget
                            width: clientCol.width
                            height: 1
                            color: isDarkMode ? separatorNight : separatorDay
                            border.color: "#00000000"
                        }

                        Label {
                            id: labelBudgets
                            width: clientCol.width
                            color: isDarkMode ? "#efefef" : "#0c0c0c"
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
                    color: isDarkMode ? contentAreaNight : contentAreaDay
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
                            color: isDarkMode ? "#ededed" : "#0c1122"
                            text: qsTr("Customer Data")
                            anchors.left: parent.left
                            anchors.top: parent.top
                            font.family: "Titillium Web Light"
                            font.pointSize: 14
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
                                color: isDarkMode ? textColorInputNight : textColorInputDay
                                placeholderTextColor: isDarkMode ? placeholderTextColorNight : placeholderTextColorDay
                                colorOnFocus: isDarkMode ? colorOnFocusNight : colorOnFocusDay
                                colorMouseOver: isDarkMode ? colorMouseOverNight : colorMouseOverDay
                                colorDefault: isDarkMode ? colorDefaultNight : colorDefaultDay
                                selectedTextColor: isDarkMode ? selectedTextColorInputNight : selectedTextColorInputDay
                                selectionColor: isDarkMode ? selectionColorInputNight : selectionColorInputDay
                                font.family: "Titillium Web Light"
                                font.pointSize: 9
                                placeholderText: "Name"
                            }

                            CustomTextField{
                                id: textAddress
                                x: 246
                                y: 0
                                width: (customerData.width * 1/3) - 5
                                color: isDarkMode ? textColorInputNight : textColorInputDay
                                placeholderTextColor: isDarkMode ? placeholderTextColorNight : placeholderTextColorDay
                                colorOnFocus: isDarkMode ? colorOnFocusNight : colorOnFocusDay
                                colorMouseOver: isDarkMode ? colorMouseOverNight : colorMouseOverDay
                                colorDefault: isDarkMode ? colorDefaultNight : colorDefaultDay
                                selectedTextColor: isDarkMode ? selectedTextColorInputNight : selectedTextColorInputDay
                                selectionColor: isDarkMode ? selectionColorInputNight : selectionColorInputDay
                                font.family: "Titillium Web Light"
                                font.pointSize: 9
                                placeholderText: "Address"
                            }

                            CustomTextField{
                                id: textPhone
                                x: 492
                                y: 0
                                width: (customerData.width * 1/3) - 5
                                color: isDarkMode ? textColorInputNight : textColorInputDay
                                placeholderTextColor: isDarkMode ? placeholderTextColorNight : placeholderTextColorDay
                                colorOnFocus: isDarkMode ? colorOnFocusNight : colorOnFocusDay
                                colorMouseOver: isDarkMode ? colorMouseOverNight : colorMouseOverDay
                                colorDefault: isDarkMode ? colorDefaultNight : colorDefaultDay
                                selectedTextColor: isDarkMode ? selectedTextColorInputNight : selectedTextColorInputDay
                                selectionColor: isDarkMode ? selectionColorInputNight : selectionColorInputDay
                                font.family: "Titillium Web Light"
                                font.pointSize: 9
                                placeholderText: "Phone number"
                            }

                            CustomTextField{
                                id: textEmailCustomer
                                x: 0
                                y: 47
                                width: (customerData.width * 1/3) - 5
                                color: isDarkMode ? textColorInputNight : textColorInputDay
                                placeholderTextColor: isDarkMode ? placeholderTextColorNight : placeholderTextColorDay
                                colorOnFocus: isDarkMode ? colorOnFocusNight : colorOnFocusDay
                                colorMouseOver: isDarkMode ? colorMouseOverNight : colorMouseOverDay
                                colorDefault: isDarkMode ? colorDefaultNight : colorDefaultDay
                                selectedTextColor: isDarkMode ? selectedTextColorInputNight : selectedTextColorInputDay
                                selectionColor: isDarkMode ? selectionColorInputNight : selectionColorInputDay
                                font.family: "Titillium Web Light"
                                font.pointSize: 9
                                placeholderText: "Email"
                            }

                            CustomTextField{
                                id: textCity
                                x: 246
                                y: 47
                                width: (customerData.width * 1/3) - 5
                                color: isDarkMode ? textColorInputNight : textColorInputDay
                                placeholderTextColor: isDarkMode ? placeholderTextColorNight : placeholderTextColorDay
                                colorOnFocus: isDarkMode ? colorOnFocusNight : colorOnFocusDay
                                colorMouseOver: isDarkMode ? colorMouseOverNight : colorMouseOverDay
                                colorDefault: isDarkMode ? colorDefaultNight : colorDefaultDay
                                selectedTextColor: isDarkMode ? selectedTextColorInputNight : selectedTextColorInputDay
                                selectionColor: isDarkMode ? selectionColorInputNight : selectionColorInputDay
                                font.family: "Titillium Web Light"
                                font.pointSize: 9
                                placeholderText: "City"
                            }

                            CustomTextField{
                                id: textZip
                                x: 492
                                y: 47
                                width: (customerData.width * 1/3) - 5
                                color: isDarkMode ? textColorInputNight : textColorInputDay
                                placeholderTextColor: isDarkMode ? placeholderTextColorNight : placeholderTextColorDay
                                colorOnFocus: isDarkMode ? colorOnFocusNight : colorOnFocusDay
                                colorMouseOver: isDarkMode ? colorMouseOverNight : colorMouseOverDay
                                colorDefault: isDarkMode ? colorDefaultNight : colorDefaultDay
                                selectedTextColor: isDarkMode ? selectedTextColorInputNight : selectedTextColorInputDay
                                selectionColor: isDarkMode ? selectionColorInputNight : selectionColorInputDay
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
                            textBtnColorDefault: isDarkMode ? textBtnColorDefaultNight : textBtnColorDefaultDay
                            textBtnColorMouseOver: isDarkMode ? textBtnColorMouseOverNight : textBtnColorMouseOverDay
                            textBtnColorClicked: isDarkMode ? textBtnColorClickedNight : textBtnColorClickedDay
                            colorDefault: isDarkMode ? colorDefaultBtnNight : colorDefaultBtnDay
                            colorPressed: isDarkMode ? colorPressedBtnNight : colorPressedBtnDay
                            colorMouseOver: isDarkMode ? colorMouseOverBtnNight : colorMouseOverBtnDay
                            onClicked: {
                                console.log("userID es: ", userID)
                                clientObj.createClient(textName.text, textAddress.text, textEmailCustomer.text, textCity.text, textZip.text, textPhone.text, userID);
                                cleanInputText()
                            }

                            function cleanInputText() {
                                textName.text = "";
                                textAddress.text = "";
                                textEmailCustomer.text = "";
                                textCity.text = "";
                                textZip.text = "";
                                textPhone.text = "";
                            }
                            
                            Connections {
                                target: clientObj
                                function onClientValidated(message){
                                    warningLabel.visible = true
                                    if (message === "Rellene todos los campos"){
                                        warningLabel.text = message;
                                    } else {
                                        warningLabel.text = message;
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

                        Label {
                            id: warningLabel
                            color: isDarkMode ? warningLabelNight : warningLabelDay
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
                        color: isDarkMode ? separatorNight : separatorDay
                        anchors.left: parent.left
                        anchors.right: contentPreview.left
                        anchors.top: customerDataContent.bottom
                        anchors.topMargin: 0
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                    }

                    Rectangle {
                        id: contentPages
                        color: isDarkMode ? contentPagesNight : contentPagesDay
                        border.width: 0
                        anchors.left: parent.left
                        anchors.right: contentPreview.left
                        anchors.top: separator.bottom
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 0

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
                            to: if(previewCollapse === false) return 5; else return (contentArea.width * 2/5)
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
                            color: isDarkMode ? rightSideBgNight : rightSideBgDay
                            radius: 5
                            border.color: isDarkMode ? rightSideLineNight : rightSideLineDay
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
                                color: isDarkMode ? "#ffffff" : "#000000"
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
                    color: isDarkMode ? bottomAreaBgNight : bottomAreaBgDay
                    border.color: isDarkMode ? bottomAreaLineNight : bottomAreaLineDay
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentArea.bottom
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.leftMargin: 0

                    Label {
                        id: labelTopInfoLeft1
                        color: isDarkMode ? "#a1a1a1" : "#3d3d3d"
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
                            fillMode: Image.PreserveAspectCrop
                            smooth: true
                            anchors.leftMargin: 5
                            anchors.topMargin: 5
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

    // Definición de la función que se ejecutará cuando se emita la señal
    function onClientsReceived(clients) {
        for (var i = 0; i < clients.length; i++) {
            var clientName = clients[i].name;
            var clientAddress = clients[i].address;
            var clientEmail = clients[i].email;
            var clientCity = clients[i].city;
            var clientZipCode = clients[i].zip_code;
            var clientPhone = clients[i].phone;
            internal.createButton(clientName, clientAddress, clientEmail, clientCity, clientZipCode, clientPhone);
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

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
