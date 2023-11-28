import QtQuick
import QtQuick.Window
import QtQuick.Controls
import "controls"
// import QtGraphicalEffects 1.0
import QtQuick.Timeline 1.0


Window {
    id: loginPage
    width: 366
    visible: true
    color: "#00000000"
    // color: "#ffffff" // For Test
    height: 556
    title: qsTr("Acceso")

    signal loginSuccessful()

    //REMOVE TITLE BAR
    flags: Qt.SplashScreen | Qt.FramelessWindowHint

    //PROPERTIES
    property bool windowCollapse: false
    property bool signUp: true
    property bool isDarkMode: false

    property url logoSourceW: "../images/Anera Solutions Logo W.png"
    property url logoSourceB: "../images/Anera Solutions Logo B.png"
    property url toggleDarkModelogoSourceW: "../images/svg_icons/png_icons_wanderson/bluedaynight.png"
    property url toggleDarkModelogoSourceB: "../images/svg_icons/png_icons_wanderson/blackdaynight.png"
    property url onTopButtonLogoB: "../images/svg_icons/png_icons_wanderson/forward-B.png"
    property url onTopButtonLogoW: "../images/svg_icons/png_icons_wanderson/forward.png"
    property url onDownButtonLogoB: "../images/svg_icons/png_icons_wanderson/backward.png"
    property url onDownButtonLogoW: "../images/svg_icons/png_icons_wanderson/backward-W.png"
    //Close button
    property url closeBtnIconSourceW: "../images/svg_icons/png_icons_wanderson/close_icon.png"
    property url closeBtnIconSourceB: "../images/svg_icons/png_icons_wanderson/close_icon-B.png"
    // Bg
    property color gradientStart : "#0d1117"
    property color gradientEnd : "#000000"
    property color textColor: "#dcdcdc"
    property color textColorDay: "#111111"
    property color textColorNight: "#dcdcdc"
    property color textColorSecondary: "#a1a1a1"
    property color textDayTurquoise: "#0492c9"
    property color textNightTurquoise: "#007bff"
    property color btnColorDefault: "#6dacb6"
    property color btnColorMouseOver: "#6198a1"
    property color btnColorClicked: "#99f1ff"
    // InputField
    property color colorOnFocusNight: "#202833"
    property color colorMouseOverNight: "#293341"
    property color colorDefaultNight: "#161b22"
    property color placeholderTextColorNight: "#b1b4bf"
    property color textColorInputNight: "#ffffff"
    property color selectedTextColorInputNight: "#ffffff"
    property color selectionColorInputNight: "#99f1ff"
    // InputField
    property color colorOnFocusDay: "#ccd1d3"
    property color colorMouseOverDay: "#d9d9d9" 
    property color colorDefaultDay: "#ececec"
    property color placeholderTextColorDay: "#111215"
    property color textColorInputDay: "#000000"
    property color selectedTextColorInputDay: "#000000"
    property color selectionColorInputDay: "#161b22"
    
    //Button
    property color colorDefaultBtnNight: "#0c1122"
    property color colorMouseOverBtnNight: "#111831"
    property color colorPressedBtnNight: "#ec733a"

    property color textBtnColorDefaultNight: "#FFFFFF"
    property color textBtnColorMouseOverNight: "#FFFFFF"
    property color textBtnColorClickedNight: "#000000"

    //Button
    property color colorDefaultBtnDay: "#6dacb6"
    property color colorPressedBtnDay: "#99f1ff"
    property color colorMouseOverBtnDay: "#6198a1"

    property color textBtnColorDefaultDay: "#FFFFFF"
    property color textBtnColorMouseOverDay: "#FFFFFF"
    property color textBtnColorClickedDay: "#000000"

    //TIMER
    Timer {
        id: hideLabelTimer
        interval: 3000  // 3 segundos
        onTriggered: lblIncorrectLoginData.visible = false
    }

    // Internal Functions
    QtObject {
        id: internal
        function getButtonIcon() {
            if (windowCollapse) {
                return isDarkMode ? onTopButtonLogoB : onTopButtonLogoW;
            } else {
                return isDarkMode ? onDownButtonLogoB : onDownButtonLogoW;
            }
        }
        function collapseWindow(){
            windowCollapse = !windowCollapse;
        }
        function toogleSignIn_Up() {
            if(signUp == true){ // Modo Crear Cuenta
                lblSignInUp.text = "Ya tienes cuenta? Inicia sesion"
                lblSignIn.text = "Crea una Cuenta"
                lblCorpData.text = "Registra tus datos"
                btnCreateUser.visible = true
                btnCreateUser.height = 40
                btnLogin.visible = false
                btnLogin.height = 0
                animationToggleRptTextPassword.running = true
                loginPage.height = 616
                signUp = false
            }else{ // Modo Iniciar Sesion
                lblSignInUp.text = "No tienes cuenta? Crea una cuenta"
                lblSignIn.text = "Inicia Sesión"
                lblCorpData.text = "Accede con tu usuario y contraseña"
                btnCreateUser.visible = false
                btnCreateUser.height = 0
                btnLogin.visible = true
                btnLogin.height = 40
                animationToggleRptTextPassword.running = true
                loginPage.height = 556
                signUp = true
            }
        }
        function toggleDarkMode() {
            if(isDarkMode == true){
                gradientStart = "#0d1117"
                gradientEnd = "#000000"
                textColor = "#dcdcdc"
                textColorSecondary = "#a1a1a1"
                isDarkMode = false 
            }else{
                gradientStart = "#ffffff"
                gradientEnd = "#d1d1d1"
                textColor = "#111111"
                textColorSecondary = "#323232"
                isDarkMode = true 
            }
        }
    }

    // LOAD LOCAL FONTS FROM ROOT FOLDER INSTEAD SYSTEM FONTS

    //PROPERTY FONTS
    property string currentFont : gepesteVFont.name
    property string currentFontThin : titillium_Web_Extralight_VFont.name

    FontLoader {
        id: gepesteVFont
        source: Qt.resolvedUrl("../myfonts/GepesteV.ttf")
        // Component.onCompleted: {
        //     console.log("Nombre de la fuente: GepesteV")
        //     console.log("Ruta de la fuente: " + gepesteVFont.source)
        //     console.log("Estado de la fuente: " + (gepesteVFont.status == FontLoader.Ready ? "Cargada" : "No cargada"))
        // }
    }

    FontLoader {
        id: titillium_Web_Light_VFont
        source: Qt.resolvedUrl("../myfonts/TitilliumWeb-Light.ttf")
        // Component.onCompleted: {
        //     console.log("Nombre de la fuente: Titillium Web Light")
        //     console.log("Ruta de la fuente: " + titillium_Web_Light_VFont.source)
        //     console.log("Estado de la fuente: " + (titillium_Web_Light_VFont.status == FontLoader.Ready ? "Cargada" : "No cargada"))
        // }
    }

    FontLoader {
        id: titillium_Web_Extralight_VFont
        source: Qt.resolvedUrl("../myfonts/TitilliumWeb-ExtraLight.ttf")
        // Component.onCompleted: {
        //     console.log("Nombre de la fuente: Titillium Web Light")
        //     console.log("Ruta de la fuente: " + titillium_Web_Extralight_VFont.source)
        //     console.log("Estado de la fuente: " + (titillium_Web_Extralight_VFont.status == FontLoader.Ready ? "Cargada" : "No cargada"))
        // }
    }




    ParallelAnimation {
        id: animationToggleRptTextPassword

        PropertyAnimation{
            target: loginPage
            property: "height"
            to: signUp ? 556 : 616
            duration: 450
            easing.type: Easing.InOutCirc
        }

        PropertyAnimation{
            target: background
            property: "height"
            to: signUp ? 550 : 610
            duration: 450
            easing.type: Easing.InOutCirc
        }
        
        PropertyAnimation{
            target: rptTextPassword
            property: "height"
            to: if(signUp == false) return 40; else return 00
            duration: 450
            easing.type: Easing.InOutCirc
        }

        PropertyAnimation {
            target: rptTextPassword
            property: "anchors.bottomMargin"
            to: signUp ? 0 : 6
            duration: 450
            easing.type: Easing.InOutCirc
        }

        PropertyAnimation {
            target: rptTextPassword
            property: "opacity"
            to: signUp ? 0 : 1
            duration: 450
            easing.type: Easing.InOutCirc
        }

        PropertyAnimation{
            target: textEmail
            property: "height"
            to: if(signUp == false) return 40; else return 00
            duration: 450
            easing.type: Easing.InOutCirc
        }

        PropertyAnimation{
            target: textEmail
            property: "opacity"
            to: signUp ? 0 : 1
            duration: 450
            easing.type: Easing.InOutCirc
        }

        PropertyAnimation {
            target: textPassword
            property: "anchors.bottomMargin"
            to: signUp ? 0 : 6
            duration: 450
            easing.type: Easing.InOutCirc
        }

    }


    Rectangle {
        id: background
        x: 90
        y: 190
        width: 360 // Desplegado
        height: 550 // Desplegado
        opacity: 1
        radius: 9.9
        border.color: "#00000000"
        border.width: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        z: 1
        antialiasing: true
        gradient: Gradient {
            GradientStop {
                position: 0
                color: gradientStart
            }

            GradientStop {
                position: 1
                color: gradientEnd
            }
        }

        DragHandler {
            onActiveChanged: if(active){
                loginPage.startSystemMove()
            }
        }

        TopBarButton {
            id: btnColapse
            width: 35
            btnIconSource: Qt.resolvedUrl(internal.getButtonIcon())
            btnColorClicked: "#99f1ff"
            btnColorMouseOver: "#6dacb6"
            anchors.left: btnDayNight.right
            anchors.top: parent.top
            btnColorDefault: "#00000000"
            anchors.leftMargin: 0
            anchors.topMargin: 15
            onClicked: {
                WindowManager.toggleAlwaysOnTop()
                internal.collapseWindow()
            }
        }

        TopBarButton {
            id: btnDayNight
            width: 35
            btnIconSource: Qt.resolvedUrl(isDarkMode ? toggleDarkModelogoSourceB : toggleDarkModelogoSourceW)
            btnColorClicked: "#99f1ff"
            btnColorMouseOver: "#6dacb6"
            anchors.left: parent.left
            anchors.top: parent.top
            btnColorDefault: "#00000000"
            anchors.leftMargin: 15
            anchors.topMargin: 15
            onClicked: internal.toggleDarkMode()
        }

        CloseButton_login {
            id: closeButton_login
            x: 315
            y: 15
            opacity: 0
            text: "Button"
            btnIconSource: Qt.resolvedUrl(isDarkMode ? closeBtnIconSourceB : closeBtnIconSourceW)
            anchors.right: parent.right
            anchors.top: parent.top
            colorDefault: "#00000000"
            antialiasing: false
            anchors.rightMargin: 15
            anchors.topMargin: 15
            colorPressed: "#99f1ff"
            colorMouseOver: "#6dacb6"
            onClicked: loginPage.close()
        }

        Image {
            id: logoGPSDImage
            x: 17
            y: 65
            width: 326
            height: 180
            opacity: 1
            anchors.bottom: lblSignIn.top
            source: Qt.resolvedUrl(isDarkMode ? logoSourceB : logoSourceW)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 15
            fillMode: Image.PreserveAspectFit
        }

        CircularProgressBar {
            id: circularProgressBar
            x: 55
            y: 236
            opacity: 1
            visible: true
            text: "%"
            anchors.verticalCenter: parent.verticalCenter
            textFontFamily: currentFontThin
            enabled: false
            z: 0
            textSize: 18
            value: 100
            // enableDropShadow: true
            baselineOffset: 0
            focus: false
            antialiasing: true
            clip: false
            maxValue: 100
            strokeBgWidth: 8
            progressWidth: 12
            samples: 55
            // dropShadowRadius: 8
            bgStrokeColor: "#151d27"
            textColor: "#00b9ec"
            progressColor: "#436b70"
            anchors.horizontalCenter: parent.horizontalCenter
        }


        Label {
            id: lblSignIn
            x: 113
            y: 297
            width: 133
            height: 25
            opacity: 1
            color: textColor
            text: qsTr("Inicia Sesión")
            anchors.bottom: lblCorpData.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 4
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: currentFont
            font.pointSize: 18
        }

        Label {
            id: lblCorpData
            x: 30
            y: 330
            width: 300
            height: 18
            opacity: 1
            color: textColor
            text: qsTr("Accede con tu usuario y contraseña")
            anchors.bottom: lblIncorrectLoginData.top
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 6
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: currentFont
        }

        CustomTextField {
            id: textUsername
            x: 43
            y: 343
            opacity: 0
            anchors.bottom: textPassword.top
            color: isDarkMode ? textColorInputDay : textColorInputNight
            placeholderTextColor: isDarkMode ? placeholderTextColorDay : placeholderTextColorNight
            colorOnFocus: isDarkMode ? colorOnFocusDay : colorOnFocusNight
            colorMouseOver: isDarkMode ? colorMouseOverDay: colorMouseOverNight
            colorDefault: isDarkMode ? colorDefaultDay : colorDefaultNight
            selectedTextColor: isDarkMode ? selectedTextColorInputNight : selectedTextColorInputDay
            selectionColor: isDarkMode ? selectionColorInputDay : selectionColorInputNight
            font.family: currentFont
            font.pointSize: 9
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 6
            placeholderText: "Username"
        }

        CustomTextField {
            id: textPassword
            x: 30
            y: 389
            opacity: 1
            anchors.bottom: rptTextPassword.top
            color: isDarkMode ? textColorInputDay : textColorInputNight
            placeholderTextColor: isDarkMode ? placeholderTextColorDay : placeholderTextColorNight
            colorOnFocus: isDarkMode ? colorOnFocusDay : colorOnFocusNight
            colorMouseOver: isDarkMode ? colorMouseOverDay: colorMouseOverNight
            colorDefault: isDarkMode ? colorDefaultDay : colorDefaultNight
            selectedTextColor: isDarkMode ? selectedTextColorInputNight : selectedTextColorInputDay
            selectionColor: isDarkMode ? selectionColorInputDay : selectionColorInputNight
            font.family: currentFont
            font.pointSize: 9
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 0
            placeholderText: "Password"
            echoMode: TextInput.Password
            Keys.onEnterPressed: loginUser.user_login(textUsername.text, textPassword.text) // Para teclados windows
            Keys.onReturnPressed: loginUser.user_login(textUsername.text, textPassword.text) // Para teclados Mac
        }

        CustomTextField {
            id: rptTextPassword
            x: 30
            y: 389
            height: 0
            opacity: 1
            visible: true
            anchors.bottom: textEmail.top
            color: isDarkMode ? textColorInputDay : textColorInputNight
            placeholderTextColor: isDarkMode ? placeholderTextColorDay : placeholderTextColorNight
            colorOnFocus: isDarkMode ? colorOnFocusDay : colorOnFocusNight
            colorMouseOver: isDarkMode ? colorMouseOverDay: colorMouseOverNight
            colorDefault: isDarkMode ? colorDefaultDay : colorDefaultNight
            selectedTextColor: isDarkMode ? selectedTextColorInputNight : selectedTextColorInputDay
            selectionColor: isDarkMode ? selectionColorInputDay : selectionColorInputNight
            font.family: currentFont
            font.pointSize: 9
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 0
            placeholderText: "Repeat Password"
            echoMode: TextInput.Password
        }

        CustomTextField {
            id: textEmail
            x: 30
            y: 389
            height: 0
            opacity: 1
            visible: true
            anchors.bottom: lblSignInUp.top
            color: isDarkMode ? textColorInputDay : textColorInputNight
            placeholderTextColor: isDarkMode ? placeholderTextColorDay : placeholderTextColorNight
            colorOnFocus: isDarkMode ? colorOnFocusDay : colorOnFocusNight
            colorMouseOver: isDarkMode ? colorMouseOverDay: colorMouseOverNight
            colorDefault: isDarkMode ? colorDefaultDay : colorDefaultNight
            selectedTextColor: isDarkMode ? selectedTextColorInputNight : selectedTextColorInputDay
            selectionColor: isDarkMode ? selectionColorInputDay : selectionColorInputNight
            font.family: currentFont
            font.pointSize: 9
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 60
            placeholderText: "Email"
            Keys.onEnterPressed: signupUser.create_user(textUsername.text, textEmail.text, textPassword.text, rptTextPassword.text) // Para teclados windows
            Keys.onReturnPressed: signupUser.create_user(textUsername.text, textEmail.text, textPassword.text, rptTextPassword.text) // Para teclados Mac
        }

        CustomButton {
            id: btnCreateUser
            x: 172
            y: 435
            width: 300
            height: 40
            opacity: 1.1
            text: "Crear cuenta"
            anchors.bottom: lblSignInUp.top
            font.italic: false
            font.family: currentFont
            font.bold: false
            font.pointSize: 10
            anchors.bottomMargin: 7

            textBtnColorDefault: isDarkMode ? textBtnColorDefaultNight : textBtnColorDefaultDay
            textBtnColorMouseOver: isDarkMode ? textBtnColorMouseOverNight : textBtnColorMouseOverDay
            textBtnColorClicked: isDarkMode ? textBtnColorClickedNight : textBtnColorClickedDay

            colorDefault: isDarkMode ? colorDefaultBtnNight : colorDefaultBtnDay
            colorPressed: isDarkMode ? colorPressedBtnNight : colorPressedBtnDay
            colorMouseOver: isDarkMode ? colorMouseOverBtnNight : colorMouseOverBtnDay
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: signupUser.create_user(textUsername.text, textEmail.text, textPassword.text, rptTextPassword.text)
            Connections {
                target: signupUser
                function onUserCreated(message) {
                    console.log(message)
                    if (message === "User created successfull") {
                        var component = Qt.createComponent("main.qml")
                        var win = component.createObject()
                        win.username = textUsername.text
                        win.show()
                        loginSuccessful()
                        visible = false
                    } else {
                        console.log(message)
                        lblIncorrectLoginData.visible = true
                        lblIncorrectLoginData.color = "#FF7777" // red
                        lblIncorrectLoginData.text = message
                        hideLabelTimer.start()
                    }
                }
            }
        }

        CustomButton {
            id: btnLogin
            x: 172
            y: 435
            width: 300
            height: 40
            opacity: 1.1
            visible: true
            text: "Acceder"
            anchors.bottom: lblSignInUp.top
            display: AbstractButton.TextBesideIcon
            checked: false
            font.italic: false
            font.family: currentFont
            font.bold: true
            font.pointSize: 12
            anchors.bottomMargin: 7
            
            textBtnColorDefault: isDarkMode ? textBtnColorDefaultNight : textBtnColorDefaultDay
            textBtnColorMouseOver: isDarkMode ? textBtnColorMouseOverNight : textBtnColorMouseOverDay
            textBtnColorClicked: isDarkMode ? textBtnColorClickedNight : textBtnColorClickedDay

            colorDefault: isDarkMode ? colorDefaultBtnNight : colorDefaultBtnDay
            colorPressed: isDarkMode ? colorPressedBtnNight : colorPressedBtnDay
            colorMouseOver: isDarkMode ? colorMouseOverBtnNight : colorMouseOverBtnDay
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: loginUser.user_login(textUsername.text, textPassword.text) // En model.user este consta de 3 atributos, pero solo se usan dos aqui
            Connections {
                target: loginUser
                // function onUserLogin(user, pass) {
                function onUserLoged(user, pass) {
                    if (user === "Acceso concedido") {
                        lblIncorrectLoginData.visible = true
                        lblIncorrectLoginData.color = "#08FF00" // green
                        lblIncorrectLoginData.text = user
                        hideLabelTimer.start()
                        var component = Qt.createComponent("main.qml")
                        var win = component.createObject()
                        win.username = textUsername.text
                        win.show()
                        loginSuccessful()
                        visible = false
                    }
                    else if (user === "No existe usuario o debe crear una cuenta"){
                        console.log(user)
                        lblIncorrectLoginData.visible = true
                        lblIncorrectLoginData.color = "#FF86FF"  // purple
                        lblIncorrectLoginData.text = user
                        hideLabelTimer.start()
                    } else {
                        console.log(user)
                        lblIncorrectLoginData.visible = true
                        lblIncorrectLoginData.color = "#FF7777" // red
                        lblIncorrectLoginData.text = "Usuario o Contaseña Incorrectos"
                        hideLabelTimer.start()
                    }
                }
            }
        }

        Label {
            id: lblSignInUp
            property bool isMouseOver: false

            y: 606
            height: 15
            opacity: 1
            visible: true
            text: qsTr("No tienes cuenta? Crea una cuenta")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: lblDevelopTeam.top
            font.letterSpacing: -0.05
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 30
            font.bold: false
            anchors.bottomMargin: 10
            anchors.rightMargin: 30
            font.family: currentFont
            font.pointSize: 10
            color: if (isMouseOver) {
                        return isDarkMode ? textNightTurquoise : textDayTurquoise
                    } else {
                        return isDarkMode ? textColorDay : textColorNight
                    }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: internal.toogleSignIn_Up()
                onEntered: {
                    lblSignInUp.isMouseOver = true
                }
                onExited: {
                    lblSignInUp.isMouseOver = false
                }
            }

        }



        Label {
            id: lblIncorrectLoginData
            y: 367
            height: 13
            opacity: 1
            color: "#FF0000"
            text: qsTr("Datos de acceso incorrectos.")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: textUsername.top
            font.letterSpacing: -0.05
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 6
            font.bold: false
            anchors.rightMargin: 30
            anchors.leftMargin: 30
            font.family: currentFont
            font.pointSize: 8
            visible: false
        }

        Label {
            id: lblDevelopTeam
            y: 522
            height: 13
            opacity: 1
            color: textColorSecondary
            text: qsTr("v0.1.0 - David Castagneto - 2023 ©")
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            font.letterSpacing: -0.05
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.Light
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: false
            anchors.rightMargin: 30
            anchors.bottomMargin: 15
            font.family: currentFont
            font.pointSize: 8
            visible: true
        }

    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                running: true
                loops: 1
                duration: 4000
                to: 4000
                from: 0
            }
        ]
        enabled: true
        startFrame: 0
        endFrame: 3500

        KeyframeGroup {
            target: circularProgressBar
            property: "value"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 1720
                value: 100
            }
        }

        KeyframeGroup {
            target: circularProgressBar
            property: "opacity"
            Keyframe {
                frame: 1719
                value: 1
            }

            Keyframe {
                frame: 2468
                value: 0
            }

            Keyframe {
                frame: 0
                value: 1
            }
        }

        KeyframeGroup {
            target: logoGPSDImage
            property: "opacity"
            Keyframe {
                frame: 2200
                value: 0
            }

            Keyframe {
                frame: 2701
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: lblSignIn
            property: "opacity"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 2304
                value: 0
            }

            Keyframe {
                frame: 2805
                value: 1
            }
        }

        KeyframeGroup {
            target: lblCorpData
            property: "opacity"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 2403
                value: 0
            }

            Keyframe {
                frame: 2904
                value: 1
            }
        }

        KeyframeGroup {
            target: textUsername
            property: "opacity"
            Keyframe {
                frame: 3008
                value: 1
            }

            Keyframe {
                frame: 2508
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: textPassword
            property: "opacity"
            Keyframe {
                frame: 2607
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 3105
                value: 1
            }
        }

        KeyframeGroup {
            target: rptTextPassword
            property: "opacity"
            Keyframe {
                frame: 2709
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 3206
                value: 1
            }
        }

        KeyframeGroup {
            target: textEmail
            property: "opacity"
            Keyframe {
                frame: 2807
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 3307
                value: 1
            }
        }

        KeyframeGroup {
            target: btnLogin
            property: "opacity"
            Keyframe {
                frame: 2706
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 3207
                value: 1
            }
        }

        KeyframeGroup {
            target: btnCreateUser
            property: "opacity"
            Keyframe {
                frame: 2807
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 3307
                value: 1
            }
        }

        KeyframeGroup {
            target: lblDevelopTeam
            property: "opacity"
            Keyframe {
                frame: 2807
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 3307
                value: 1
            }
        }

        KeyframeGroup {
            target: lblIncorrectLoginData
            property: "opacity"
            Keyframe {
                frame: 2807
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 3307
                value: 1
            }
        }

        KeyframeGroup {
            target: background
            property: "border.width"
            Keyframe {
                frame: 0
                value: 13
            }

            Keyframe {
                frame: 1501
                value: 13
            }

            Keyframe {
                frame: 1700
                value: 1
            }
        }

        KeyframeGroup {
            target: background
            property: "radius"
            Keyframe {
                frame: 0
                value: 125
            }

            Keyframe {
                frame: 1501
                value: 125
            }

            Keyframe {
                frame: 1700
                value: 10
            }
        }

        KeyframeGroup {
            target: background
            property: "width"
            Keyframe {
                frame: 0
                value: 250
            }

            Keyframe {
                frame: 1501
                value: 250
            }

            Keyframe {
                easing.bezierCurve: [0.891, 0.00372, 0.107, 0.999, 1, 1]
                frame: 2101
                value: 360
            }
        }

        KeyframeGroup {
            target: background
            property: "height"
            Keyframe {
                frame: 0
                value: 250
            }

            Keyframe {
                frame: 1502
                value: 250
            }

            Keyframe {
                easing.bezierCurve: [0.89, 0.00372, 0.11, 0.999, 1, 1]
                frame: 2101
                value: 550
            }
        }

        KeyframeGroup {
            target: closeButton_login
            property: "opacity"
            Keyframe {
                frame: 2600
                value: 1
            }

            Keyframe {
                frame: 2100
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: btnColapse
            property: "opacity"
            Keyframe {
                frame: 3500
                value: 1
            }

            Keyframe {
                frame: 2100
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: btnDayNight
            property: "opacity"
            Keyframe {
                frame: 3500
                value: 1
            }

            Keyframe {
                frame: 2100
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: lblSignInUp
            property: "opacity"
            Keyframe {
                frame: 2807
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 3307
                value: 1
            }
        }

        KeyframeGroup {
            target: circularProgressBar
            property: "progressColor"
            Keyframe {
                value: "#436b70"
                frame: 0
            }

            Keyframe {
                value: "#73b7c1"
                frame: 1300
            }

            Keyframe {
                value: "#99f1ff"
                frame: 1500
            }

            Keyframe {
                frame: 1720
                value: "#99f1ff"
            }
        }

        KeyframeGroup {
            target: circularProgressBar
            property: "textColor"
            Keyframe {
                value: "#00c859"
                frame: 0
            }

            Keyframe {
                value: "#00b9ec"
                frame: 1719
            }
        }
    }

}










