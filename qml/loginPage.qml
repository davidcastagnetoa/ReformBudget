import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "controls"
import QtGraphicalEffects 1.0
import QtQuick.Timeline 1.0


Window {
    id: loginPage
    width: 366
    height: 556
    visible: true
    color: "#00000000"
    // color: "#ffffff" // For Test
    title: qsTr("Acceso")

    signal loginSuccessful()

    //REMOVE TITLE BAR
    flags: Qt.SplashScreen | Qt.FramelessWindowHint

    //PROPERTIES
    property bool windowCollapse: false
    property bool signUp: false

    //TIMER
    Timer {
        id: hideLabelTimer
        interval: 3000  // 3 segundos
        onTriggered: lblIncorrectLoginData.visible = false
    }

    // Internal Functions
    QtObject {
        id: internal

        function collapseWindow(window){
            if(windowCollapse == false){
                btnColapse.btnIconSource = "../images/svg_icons/lock-rounded.svg"
                windowCollapse = true
            }else{
                btnColapse.btnIconSource = "../images/svg_icons/unlock-rounded.svg"
                windowCollapse = false
            }
        }
        function toogleSignIn_Up() {
            if(signUp == false){ // Modo Crear Cuenta
                animationBg.running = true
                animationWindow.running = true
                lblSignInUp.text = "Ya tienes cuenta? Inicia sesion"
                lblSignIn.text = "Crea una Cuenta"
                lblCorpData.text = "Registra tus datos"
                btnCreateUser.visible = true
                btnCreateUser.height = 40
                btnLogin.visible = false
                btnLogin.height = 0
                rptTextPassword.visible = true
                rptTextPassword.height = 40
                rptTextPassword.anchors.bottomMargin = 6
                textPassword.anchors.bottomMargin = 6
                textEmail.visible = true
                textEmail.height = 40
                signUp = true
            }else{ // Modo Iniciar Sesion
                animationBg.running = true
                animationWindow.running = true
                lblSignInUp.text = "No tienes cuenta? Crea una cuenta"
                lblSignIn.text = "Inicia Sesión"
                lblCorpData.text = "Accede con tu usuario y contraseña"
                btnCreateUser.visible = false
                btnCreateUser.height = 0
                btnLogin.visible = true
                btnLogin.height = 40
                rptTextPassword.visible = false
                rptTextPassword.height = 0
                rptTextPassword.anchors.bottomMargin = 0
                textPassword.anchors.bottomMargin = 0
                textEmail.visible = false
                textEmail.height = 0
                signUp = false
            }
        }
    }

    PropertyAnimation{
           id: animationWindow
           target: loginPage
           property: "height"
           to: if(signUp == false) return 616; else return 556
           duration: 150
           easing.type: Easing.InOutCubic
       }

    Rectangle {
        id: background
        x: 90
        y: 190
        width: 360 // Desplegado
        height: 550 // Desplegado
        opacity: 1
        color: "#0d1117"
        radius: 9.9
        border.color: "#00000000"
        border.width: 1
        anchors.verticalCenter: parent.verticalCenter
        z: 1
        antialiasing: true
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#0d1117"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

       PropertyAnimation{
           id: animationBg
           target: background
           property: "height"
           to: if(signUp == false) return 610; else return 550
           duration: 150
           easing.type: Easing.InOutCubic
       }

        DragHandler {
            onActiveChanged: if(active){
                loginPage.startSystemMove()
            }
        }

        TopBarButton {
            id: btnColapse
            width: 35
            btnIconSource: "../images/svg_icons/unlock-rounded.svg"
            btnColorClicked: "#00ef68"
            btnColorMouseOver: "#008337"
            anchors.left: parent.left
            anchors.top: parent.top
            btnColorDefault: "#00000000"
            anchors.leftMargin: 15
            anchors.topMargin: 15
            onClicked: {
                WindowManager.toggleAlwaysOnTop()
                internal.collapseWindow()
            }
        }

        CloseButton_login {
            id: closeButton_login
            x: 315
            y: 15
            opacity: 0
            text: "Button"
            anchors.right: parent.right
            anchors.top: parent.top
            antialiasing: false
            anchors.rightMargin: 15
            anchors.topMargin: 15
            colorPressed: "#00ef68"
            colorMouseOver: "#008337"
            colorDefault: "#00c859"
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
            source: "../images/Anera Logo II.png"
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
            text: "% Loading"
            anchors.verticalCenter: parent.verticalCenter
            enabled: false
            z: 0
            textSize: 18
            value: 100
            enableDropShadow: true
            baselineOffset: 0
            focus: false
            antialiasing: false
            clip: false
            maxValue: 100
            strokeBgWidth: 8
            progressWidth: 12
            samples: 55
            dropShadowRadius: 8
            bgStrokeColor: "#151d27"
            textColor: "#00c859"
            progressColor: "#00c859"
            anchors.horizontalCenter: parent.horizontalCenter
        }


        Label {
            id: lblSignIn
            x: 113
            y: 297
            width: 133
            height: 25
            opacity: 1
            color: "#dcdcdc"
            text: qsTr("Inicia Sesión")
            anchors.bottom: lblCorpData.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 4
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Titillium Web Light"
            font.pointSize: 18
        }

        Label {
            id: lblCorpData
            x: 30
            y: 330
            width: 300
            height: 18
            opacity: 1
            color: "#dcdcdc"
            text: qsTr("Accede con tu usuario y contraseña")
            anchors.bottom: lblIncorrectLoginData.top
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 6
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Titillium Web Light"
        }

        CustomTextField {
            id: textUsername
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
            id: textPassword
            x: 30
            y: 389
            opacity: 1
            anchors.bottom: rptTextPassword.top
            colorDefault: "#161b22"
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 0
            placeholderText: "Password"
            echoMode: TextInput.Password
            Keys.onEnterPressed: envVariables.user_login(textUsername.text, textPassword.text) // Para teclados windows
            Keys.onReturnPressed: envVariables.user_login(textUsername.text, textPassword.text) // Para teclados Mac
        }

        CustomTextField {
            id: rptTextPassword
            x: 30
            y: 389
            height: 0
            opacity: 1
            visible: false
            anchors.bottom: textEmail.top
            colorDefault: "#161b22"
            font.family: "Titillium Web Light"
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
            visible: false
            anchors.bottom: lblSignInUp.top
            colorDefault: "#161b22"
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 60
            placeholderText: "Email"
            Keys.onEnterPressed: userHandler.create_user(textUsername.text, textEmail.text, textPassword.text, rptTextPassword.text) // Para teclados windows
            Keys.onReturnPressed: userHandler.create_user(textUsername.text, textEmail.text, textPassword.text, rptTextPassword.text) // Para teclados Mac
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
            font.family: "Titillium Web Regular"
            font.bold: false
            font.pointSize: 10
            anchors.bottomMargin: 7
            colorDefault: "#00d15b"
            colorPressed: "#00ef68"
            colorMouseOver: "#008337"
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: userHandler.create_user(textUsername.text, textEmail.text, textPassword.text, rptTextPassword.text)
            Connections {
                target: userHandler
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
                        lblIncorrectLoginData.color = "#FF3535" // red
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
            font.italic: false
            font.family: "Titillium Web Regular"
            font.bold: false
            font.pointSize: 10
            anchors.bottomMargin: 7
            colorDefault: "#00d15b"
            colorPressed: "#00ef68"
            colorMouseOver: "#008337"
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: envVariables.user_login(textUsername.text, textPassword.text)
            Connections {
                target: envVariables
                function onUserLogin(user, pass) {
                    if (user === "Acceso granted") {
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
                    else if (user === "No existe usuario debe crear una cuenta"){
                        console.log(user)
                        lblIncorrectLoginData.visible = true
                        lblIncorrectLoginData.color = "#FF35F0"  // purple
                        lblIncorrectLoginData.text = user
                        hideLabelTimer.start()
                    } else {
                        console.log(user)
                        lblIncorrectLoginData.visible = true
                        lblIncorrectLoginData.color = "#FF3535" // red
                        lblIncorrectLoginData.text = "Usuario o Contaseña Incorrectos"
                        hideLabelTimer.start()
                    }
                }
            }
        }

        Label {
            id: lblSignInUp
            y: 606
            height: 15
            opacity: 1
            visible: true
            color: "#F5F5F5"
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
            font.family: "Titillium Web Light"
            font.pointSize: 10
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: internal.toogleSignIn_Up()
                onEntered: {
                    lblSignInUp.color = "#489EFF"
                }
                onExited: {
                    lblSignInUp.color = "#F5F5F5"
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
            font.family: "Titillium Web Regular"
            font.pointSize: 8
            visible: false
        }

        Label {
            id: lblDevelopTeam
            y: 522
            height: 13
            opacity: 1
            color: "#a1a1a1"
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
            font.family: "Titillium Web Light"
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
                frame: 1720
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
                frame: 1501
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
    }

}








