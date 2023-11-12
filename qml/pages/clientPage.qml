import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"


Item {
    //PROPERTIES
    property var currentClient: ({name: "", address: "", mail: "", city: "", zip_code: "", phone: "", user_id: 0})
    property color textLblColor: "#818995"
    property color textResTxtColor: "#FFFFFF"

    onCurrentClientChanged: {
        if (currentClient !== null) {
            textResponseName.text = currentClient.name;
            textResponseAddress.text = currentClient.address;
            textResponseMail.text = currentClient.mail;
            textResponseCity.text = currentClient.city;
            textResponseZip_code.text = currentClient.zip_code;
            textResponsePhone.text = currentClient.phone;
            // Actualizar otros elementos de la UI con los datos del cliente
        }
    }

    implicitWidth: 1200
    implicitHeight: 775

    Timer {
        id: hideWarningTimer
        interval: 2000  // 2 segundos
        onTriggered: warningLabel.visible = false
    }

    // INTERNAL FUNCTIONS
    QtObject{
        id: internal
    }

    Rectangle {
        id: bgPage
        color: "#00000000"
        anchors.fill: parent

        Rectangle {
            id: rectangle
            width: 368
            height: 141
            color: "#161b22"
            radius: 10
            border.color: "#21262d"
            border.width: 1
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.topMargin: 10

            Column {
                id: nameBlockBg
                anchors.fill: parent
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.bottomMargin: 10
                anchors.topMargin: 10
                spacing: 0

                Item{
                    id: nameClientData
                    width: 300
                    height: 20
                    Label {
                        id: labelName
                        y: 30
                        color: textLblColor
                        text: qsTr("Nombre Completo:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Regular"
                        anchors.leftMargin: 0
                        font.pointSize: 10
                        font.weight: Font.Normal
                        font.family: "Titillium Web"
                    }

                    Label {
                        id: textResponseName
                        y: 24
                        color: textResTxtColor
                        text: currentClient.name
                        elide: Text.ElideNone
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: labelName.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Light"
                        fontSizeMode: Text.HorizontalFit
                        style: Text.Normal
                        font.pointSize: 10
                        font.weight: Font.Light
                        font.family: "Titillium Web"
                        anchors.leftMargin: 7
                    }
                }

                Item {
                    id: mailClientData
                    width: 300
                    height: 20
                    visible: true
                    Label {
                        id: labelMail
                        y: 30
                        color: textLblColor
                        text: qsTr("Email:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Regular"
                        anchors.leftMargin: 0
                        font.pointSize: 10
                        font.weight: Font.Normal
                        font.family: "Titillium Web"
                    }
                    Label {
                        id: textResponseMail
                        y: 24
                        color: textResTxtColor
                        text: currentClient.address
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: labelMail.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Light"
                        fontSizeMode: Text.HorizontalFit
                        font.weight: Font.Light
                        font.pointSize: 10
                        font.family: "Titillium Web"
                        anchors.leftMargin: 7
                    }
                }

                Item {
                    id: phoneClientData
                    width: 300
                    height: 20
                    visible: true
                    Label {
                        id: labelPhone
                        y: 30
                        color: textLblColor
                        text: qsTr("Teléfono:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Regular"
                        anchors.leftMargin: 0
                        font.pointSize: 10
                        font.weight: Font.Normal
                        font.family: "Titillium Web"
                    }
                    Label {
                        id: textResponsePhone
                        y: 24
                        color: textResTxtColor
                        text: currentClient.phone
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: labelPhone.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenterOffset: 0
                        font.styleName: "Light"
                        fontSizeMode: Text.HorizontalFit
                        font.weight: Font.Light
                        font.pointSize: 10
                        font.family: "Titillium Web"
                        anchors.leftMargin: 6
                    }
                }

                Item {
                    id: addressClientData
                    width: 300
                    height: 20
                    visible: true
                    Label {
                        id: labelAddress
                        y: 30
                        color: textLblColor
                        text: qsTr("Dirección:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Regular"
                        anchors.leftMargin: 0
                        font.pointSize: 10
                        font.weight: Font.Normal
                        font.family: "Titillium Web"
                    }
                    Label {
                        id: textResponseAddress
                        y: 24
                        color: textResTxtColor
                        text: currentClient.address
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: labelAddress.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Light"
                        fontSizeMode: Text.HorizontalFit
                        font.pointSize: 10
                        font.family: "Titillium Web"
                        font.weight: Font.Light
                        anchors.leftMargin: 7
                    }
                }

                Item {
                    id: zip_codeClientData
                    width: 300
                    height: 20
                    visible: true
                    Label {
                        id: labelZip_code
                        y: 30
                        color: textLblColor
                        text: qsTr("Código Postal:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Regular"
                        anchors.leftMargin: 0
                        font.pointSize: 10
                        font.weight: Font.Normal
                        font.family: "Titillium Web"
                    }
                    Label {
                        id: textResponseZip_code
                        y: 24
                        color: textResTxtColor
                        text: currentClient.zip_code
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: labelZip_code.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Light"
                        fontSizeMode: Text.HorizontalFit
                        font.weight: Font.Light
                        font.pointSize: 10
                        font.family: "Titillium Web"
                        anchors.leftMargin: 7
                    }
                }

                Item {
                    id: cityClientData
                    width: 300
                    height: 20
                    visible: true
                    Label {
                        id: labelCity
                        y: 30
                        color: textLblColor
                        text: qsTr("Ciudad:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Regular"
                        anchors.leftMargin: 0
                        font.pointSize: 10
                        font.weight: Font.Normal
                        font.family: "Titillium Web"
                    }
                    Label {
                        id: textResponseCity
                        y: 24
                        color: textResTxtColor
                        text: currentClient.city
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: labelCity.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Light"
                        fontSizeMode: Text.HorizontalFit
                        font.weight: Font.Light
                        font.pointSize: 10
                        font.family: "Titillium Web"
                        anchors.leftMargin: 7
                    }
                }


            }
        }


    }

}

