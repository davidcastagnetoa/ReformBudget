import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "controls"

Window {
    id: mainWindow
    width: 1173
    height: 660
    visible: true
    color: "#00000000"

    //Custom Properties
    property string username
    property alias mainWindow: mainWindow
    title: "Reform Budget"

    // REMOVE TITLE BAR
    flags: Qt.Window | Qt.FramelessWindowHint

    // // PROPERTIES
    property int windowStatus: 0
    property int windowMargin: 10

    // INTERNAL FUNCTIONS
    QtObject{
        id: internal

        // Maximize Restore
        function maximizeRestore(){
            if(windowStatus == 0){
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
                restoreButton.btnIconSource = "../images/svg_icons/restore_icon.svg"
            }
            else{
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
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

    }

    Rectangle {
        id: bg
        width: 1173
        height: 660
        color: "#0d1117"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
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
                        btnIconSource: "../images/svg_icons/restore_icon.svg"
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
                    y: 16
                    height: 24
                    color: "#0d1117"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
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
                        anchors.rightMargin: 5
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
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    Column {
                        id: clientCol
                        anchors.fill: parent
                        anchors.bottomMargin: 203

                        Button {
                            id: button
                            text: qsTr("Button")
                        }
                    }

                    Column {
                        id: budgetCol
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: clientCol.bottom
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 5
                    }
                }

                Rectangle {
                    id: contentArea
                    color: "#00000000"
                    border.color: "#000000"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0
                    anchors.leftMargin: 0

                    Rectangle {
                        id: contentPreview
                        x: 644
                        width: 455
                        height: 200
                        color: "#00000000"
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0

                        Button {
                            id: tooglePreviewBtn
                            x: -648
                            y: 282
                            width: 30
                            height: 30
                            text: qsTr("Toggle")
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.topMargin: 282
                            anchors.leftMargin: 0
                        }

                        Rectangle {
                            id: rightSide
                            x: 30
                            y: 5
                            width: 425
                            color: "#161b22"
                            radius: 5
                            border.width: 0
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
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
                                anchors.leftMargin: 30
                                font.pointSize: 11
                            }
                        }


                    }


                }

                Rectangle {
                    id: bottomArea
                    color: "#0d1117"
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
                        anchors.rightMargin: 5
                        anchors.topMargin: 0
                        anchors.leftMargin: 10
                        font.pointSize: 10
                    }
                }






            }


        }
    }
}





/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}D{i:7}
}
##^##*/
