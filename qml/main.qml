import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

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

                    Button {
                        id: toogleBtn
                        x: 0
                        y: 60
                        width: 70
                        height: 60
                        text: qsTr("Toggle")
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
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
                            color: "#ffffff"
                            text: qsTr("Reform Budget")
                            anchors.left: iconApp.right
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 13
                            font.bold: false
                            font.family: "Titillium Web Light"
                            anchors.topMargin: 0
                            anchors.bottomMargin: 0
                            anchors.rightMargin: 0
                            anchors.leftMargin: 5
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
                        id: rightSide
                        x: 751
                        y: 5
                        width: 417
                        color: "#161b22"
                        radius: 5
                        border.width: 0
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        scale: 1
                        transformOrigin: Item.BottomRight
                        z: 1
                        anchors.topMargin: 0
                        clip: true
                        anchors.bottomMargin: 5
                        anchors.rightMargin: 5

                        Button {
                            id: tooglePreviewBtn
                            x: 4
                            y: 56
                            width: 30
                            height: 30
                            text: qsTr("Toggle")
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.topMargin: 0
                            anchors.leftMargin: 0
                        }

                        Label {
                            id: previewLbl
                            width: 65
                            color: "#ffffff"
                            text: qsTr("Preview")
                            anchors.left: tooglePreviewBtn.right
                            anchors.top: parent.top
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Titillium Web Light"
                            anchors.topMargin: 5
                            anchors.leftMargin: 5
                            font.pointSize: 11
                        }
                    }

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
                    }
                }


            }
        }
    }





/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}D{i:6}D{i:7}D{i:5}D{i:9}D{i:10}D{i:8}D{i:13}D{i:14}
}
##^##*/
