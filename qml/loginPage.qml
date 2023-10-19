import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "controls"
import QtGraphicalEffects 1.0
import QtQuick.Timeline 1.0


Window {
    id: loginPage
    width: 380
    height: 670
    visible: true
    color: "#00000000"
    // color: "#ffffff" // For Test
    title: qsTr("Acceso")

    signal loginSuccessful()

    //REMOVE TITLE BAR
    flags: Qt.SplashScreen | Qt.FramelessWindowHint

    //PROPERTIES
    property bool windowCollapse: false

    //TIMER
    Timer {
        id: hideLabelTimer
        interval: 3500  // 3.5 segundos
        onTriggered: lblIncorrectLoginData.visible = false
    }

    // Internal Functions
    QtObject {
        id: internal

        function collapseWindow(window){
            if(windowCollapse == false){
                btnColapse.btnIconSource = "../images/svg_icons/down_icon.svg"
                windowCollapse = true
            }else{
                btnColapse.btnIconSource = "../images/svg_icons/up_icon.svg"
                windowCollapse = false
            }
        }
    }

    Rectangle {
        id: background
        x: 90
        y: 190
        // width: 360 // Plegado
        // height: 560 // Plegado
        width: 360 // Desplegado
        height: 960 // Desplegado
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

        DragHandler {
            onActiveChanged: if(active){
                loginPage.startSystemMove()
            }
        }

        TopBarButton {
            id: btnColapse
            width: 35
            btnIconSource: "../images/svg_icons/up_icon.svg"
            btnColorDefault: "#110000"
            btnColorClicked: "#611415"
            btnColorMouseOver: "#2e0001"
            anchors.left: parent.left
            anchors.top: parent.top
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
            anchors.bottomMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter
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
            anchors.bottomMargin: 10
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
            anchors.bottom: textUsername.top
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 15
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
            anchors.bottomMargin: 8
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
            anchors.bottomMargin: 8
            placeholderText: "Password"
            echoMode: TextInput.Password
        }

        CustomTextField {
            id: rptTextPassword
            x: 30
            y: 389
            opacity: 1
            anchors.bottom: textEmail.top
            colorDefault: "#161b22"
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 8
            placeholderText: "Repeat Password"
            echoMode: TextInput.Password
        }

        CustomTextField {
            id: textEmail
            x: 30
            y: 389
            opacity: 1
            anchors.bottom: btnLogin.top
            colorDefault: "#161b22"
            font.family: "Titillium Web Light"
            font.pointSize: 9
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 13
            placeholderText: "Email"
        }

        CustomButton {
            id: btnLogin
            x: 172
            y: 435
            width: 300
            height: 40
            opacity: 1.1
            text: "Acceder"
            anchors.bottom: btnCreateUser.top
            font.italic: false
            font.family: "Titillium Web Regular"
            font.bold: false
            font.pointSize: 10
            anchors.bottomMargin: 10
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

        CustomButton {
            id: btnCreateUser
            x: 172
            y: 435
            width: 300
            height: 40
            opacity: 1.1
            text: "Crear cuenta"
            anchors.bottom: parent.bottom
            font.italic: false
            font.family: "Titillium Web Regular"
            font.bold: false
            font.pointSize: 10
            anchors.bottomMargin: 60
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
                        console.error(message)
                        lblIncorrectLoginData.visible = true
                        lblIncorrectLoginData.color = "#FF3535" // red
                        lblIncorrectLoginData.text = message
                        hideLabelTimer.start()
                    }
                }
            }
        }


        Label {
            id: lblIncorrectLoginData
            y: 522
            height: 13
            opacity: 1
            color: "#FF0000"
            text: qsTr("Datos de acceso incorrectos.")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            font.letterSpacing: -0.05
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: false
            anchors.rightMargin: 30
            anchors.bottomMargin: 30
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
            color: "#dcdcdc"
            text: qsTr("v0.1.0 - David Castagneto - 2023")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: lblIncorrectLoginData.bottom
            font.letterSpacing: -0.05
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: false
            anchors.rightMargin: 30
            anchors.bottomMargin: 20
            anchors.leftMargin: 30
            anchors.topMargin: 5
            font.family: "Titillium Web Regular"
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
                frame: 3107
                value: 1
            }
        }

        KeyframeGroup {
            target: rptTextPassword
            property: "opacity"
            Keyframe {
                frame: 2206
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 3107
                value: 1
            }
        }

        KeyframeGroup {
            target: textEmail
            property: "opacity"
            Keyframe {
                frame: 1805
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 3107
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
                frame: 3205
                value: 1
            }
        }

        KeyframeGroup {
            target: btnCreateUser
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
                frame: 3205
                value: 1
            }
        }

        KeyframeGroup {
            target: lblDevelopTeam
            property: "opacity"
            Keyframe {
                frame: 2805
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 3305
                value: 1
            }
        }

        KeyframeGroup {
            target: lblIncorrectLoginData
            property: "opacity"
            Keyframe {
                frame: 2805
                value: 0
            }

            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 3305
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
                value: 660
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
    }

}






