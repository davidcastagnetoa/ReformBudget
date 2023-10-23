import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "controls"

Window {
    id: mainWindow
    width: 1420
    height: 870
    visible: true
    color: "#00000000"
    title: qsTr("Reform Budget")

    //Custom Properties
    property string username
    property alias mainWindow: mainWindow

    // REMOVE TITLE BAR
    flags: Qt.Window | Qt.FramelessWindowHint

    // // PROPERTIES
    property int windowStatus: 0
    property int windowMargin: 10
    property bool previewCollapse: false
    property int buttonCount: 2

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
                        width: 55
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../images/Logo.png"
                        sourceSize.height: 35
                        sourceSize.width: 55
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 5
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: label
                        width: 120
                        color: "#ffffff"
                        text: qsTr("Reform Budget")
                        anchors.left: iconApp.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 13
                        font.bold: false
                        font.family: "Titillium Web Light"
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
                        btnIconSource: "../images/svg_icons/minimize_icon.svg"
                        onClicked: {
                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }
                    }

                    RestoreButton {
                        id: restoreButton
                        height: 35
                        btnIconSource: "../images/svg_icons/maximize_icon.svg"
                        onClicked: {
                            internal.maximizeRestore()
                        }
                    }

                    CloseButton {
                        id: closeButton
                        height: 35
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
                    width: 200
                    color: "#161b22"
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
                        height: 400
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.rightMargin: 0
                        z: 0
                        spacing: -1

                        Item {
                            width: 70
                            height: 20  // Añade un espacio de 15px en la parte superior de la columna.
                        }

                        Image {
                            id: image
                            width: 190
                            height: 50
                            anchors.left: parent.left
                            horizontalAlignment: Image.AlignHCenter
                            verticalAlignment: Image.AlignVCenter
                            source: "../images/ReformBudget_Logo.png"
                            z: 0
                            anchors.leftMargin: 0
                            mirror: false
                            sourceSize.height: 50
                            sourceSize.width: 190
                            fillMode: Image.PreserveAspectFit
                        }

                        Item {
                            width: 70
                            height: 20  // Añade un espacio de 15px en la parte superior de la columna.
                        }

//                        LeftMenuBtn{
//                            id: leftMenuBtn01
//                            width: leftMenuBtn01.width
//                            text: "Client 01"
//                            font.weight: Font.Light
//                            font.family: "Titillium Web Light"
//                            secondaryTextContent: "Direccion"
//                            isActiveMenu: true
//                            z: 0
//                            font.pointSize: 10
//                            btnIconSource: "../images/svg_icons/icon_users.svg"
//                        }
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

                    // CustomButton{
                    //     id: createCustomer
                    //     width: 190
                    //     height: 35
                    //     text: "Añadir cliente"
                    //     anchors.left: parent.left
                    //     anchors.top: clientCol.bottom
                    //     anchors.leftMargin: 5
                    //     anchors.topMargin: 5
                    //     font.weight: Font.Light
                    //     font.pointSize: 9
                    //     colorDefault: "#00d15b"
                    //     colorPressed: "#00ef68"
                    //     colorMouseOver: "#008337"
                    //     onClicked: {
                    //         clientObj.createClient("Juan Carlos", "Call de la Piruleta, 1", "juancarlos@gmail.com", "Madrid", "28016", "680771328");
                    //     }
                    //     Connections {
                    //         target: clientObj
                    //         function onClientCreated(name, address, mail, city, zip_code, phone) {
                    //             console.log(name)
                    //             console.log(address)
                    //             console.log(mail)
                    //             console.log(city)
                    //             console.log(zip_code)
                    //             console.log(phone)
                    //             function createButton() {
                    //                 var newButton = leftMenuBtnComponent.createObject(clientCol);
                    //                 if (newButton) {
                    //                     newButton.text = name;
                    //                     newButton.secondaryTextContent = address
                    //                     buttonCount ++;
                    //                     newButton.tag = "leftMenuBtn" + buttonCount;
                    //                     newButton.width = newButton.tag.width
                    //                 } else {
                    //                     console.error("Error al crear el botón desde leftMenuBtnComponent");
                    //                 }
                    //             }
                    //             // Usamos Qt.callLater para llamar a la función createButton en el próximo ciclo del bucle de eventos
                    //             Qt.callLater(createButton)
                    //         }
                    //     }
                    // }

                    Column {
                        id: budgetCol
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: clientCol.bottom
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                    }

                }

                Rectangle {
                    id: contentArea
                    color: "#0d1117"
                    border.color: "#000000"
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
                        id: contentPages
                        color: "#00000000"
                        anchors.fill: parent

                        StackView {
                            id: stackView
                            anchors.fill: parent
                            initialItem: Qt.resolvedUrl("pages/clientPage.qml")
                        }
                    }

                    Rectangle {
                        id: contentPreview
                        x: 639
                        width: 550
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
                            to: if(contentPreview.width == 550) return 35; else return 550
                            duration: 450
                            easing.type: Easing.InOutCirc
                        }

                        ExpandPanelButton {
                            id: tooglePreviewBtn
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: rightSide.left
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
                            anchors.leftMargin: 30
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
                                font.family: "Titillium Web Light"
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
                        font.pointSize: 10
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
        anchors.topMargin: 10
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
        anchors.topMargin: 10
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













/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
