import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 1.15
import "../controls"


Item {
    //PROPERTIES
    // Client selected data
    property var currentClient: ({
        user_id: 0,
        name: "",
        address: "",
        mail: "",
        city: "",
        zip_code: "",
        phone: ""
    })

    property var budgetsClient: ({
        client_id: 0,
        budgetId: "",
        budgetName: "",
        budgetAmountSubtotal: 0,
        budgetAmountTaxes: 0,
        budgetAmountTotal: 0,
        budgetDate: "",
        budgetDescription: "",
        budgetStatus: "",
        budgetType: "",
        budgetCategory: "",
        budgetNotes: "",
    })

    // Budgets's client selected data colors
    property color textLblColor: "#818995"
    property color textResTxtColor: "#FFFFFF"
    property color textBgColorRectangle: "#161b22"
    property color textBgBorderRectangle: "#21262d"

    // Custom Field texts & placeholder
    property color textColorInput : "#ffffff"
    property color placeholderTextColorInput : "#b1b4bf"
    property color selectionColorInput : "#99f1ff"
    property color selectedTextColorInput : "#ffffff"

    // Custom Field Bg
    property color colorDefaultInput : "#161b22"
    property color colorOnFocusInput : "#202833"
    property color colorMouseOverInput : "#293341"

    // // Indicators Bg
    // property color indicatorColorDefault: "#202833"
    // property color indicatorColorFocus: "#293341"
    // property color indicatorColorHovered: "#344052"
    

    // Signals
    onCurrentClientChanged: {
        if (currentClient !== null) {
            // Actualizar otros elementos de la UI con los datos del cliente
            textResponseName.text = currentClient.name;
            textResponseAddress.text = currentClient.address;
            textResponseMail.text = currentClient.mail;
            textResponseCity.text = currentClient.city;
            textResponseZip_code.text = currentClient.zip_code;
            textResponsePhone.text = currentClient.phone;
        }
    }

    implicitWidth: 1200
    implicitHeight: 775

    Timer {
        id: hideWarningTimer
        interval: 2000  // 2 segundos
        onTriggered: warningLabel.visible = false
    }



    //PROPERTY FONTS
    property string currentFont : titillium_Web_Light_VFont.name
    property string currentFontThin : titillium_Web_Extralight_VFont.name

    FontLoader {
        id: gepesteVFont
        source: Qt.resolvedUrl("../../myfonts/GepesteV.ttf")
    }

    FontLoader {
        id: titillium_Web_Light_VFont
        source: Qt.resolvedUrl("../../myfonts/TitilliumWeb-Light.ttf")
    }

    FontLoader {
        id: titillium_Web_Extralight_VFont
        source: Qt.resolvedUrl("../../myfonts/TitilliumWeb-ExtraLight.ttf")
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
            id: textBgClientData
            width: 350
            height: 141
            color: textBgColorRectangle
            radius: 8
            border.color: textBgBorderRectangle
            border.width: 1
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.topMargin: 15

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
                    width: 330
                    height: 20
                    Label {
                        id: labelName
                        y: 30
                        color: textLblColor
                        text: qsTr("Nombre Completo:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.letterSpacing: 0.2
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Regular"
                        anchors.leftMargin: 0
                        font.pointSize: 10
                        font.weight: Font.Normal
                        font.family: currentFont
                    }

                    Label {
                        id: textResponseName
                        y: 24
                        color: textResTxtColor
                        text: currentClient.name
                        elide: Text.ElideNone
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: labelName.right
                        font.letterSpacing: 0.25
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Light"
                        fontSizeMode: Text.HorizontalFit
                        style: Text.Normal
                        font.pointSize: 10
                        font.weight: Font.Light
                        font.family: currentFont
                        anchors.leftMargin: 10
                    }
                }

                Item {
                    id: mailClientData
                    width: 330
                    height: 20
                    visible: true
                    Label {
                        id: labelMail
                        y: 30
                        color: textLblColor
                        text: qsTr("Email:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.letterSpacing: 0.2
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Regular"
                        anchors.leftMargin: 0
                        font.pointSize: 10
                        font.weight: Font.Normal
                        font.family: currentFont
                    }
                    Label {
                        id: textResponseMail
                        y: 24
                        color: textResTxtColor
                        text: currentClient.address
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: labelMail.right
                        font.letterSpacing: 0.25
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Light"
                        fontSizeMode: Text.HorizontalFit
                        font.weight: Font.Light
                        font.pointSize: 10
                        font.family: currentFont
                        anchors.leftMargin: 10
                    }
                }

                Item {
                    id: phoneClientData
                    width: 330
                    height: 20
                    visible: true
                    Label {
                        id: labelPhone
                        y: 30
                        color: textLblColor
                        text: qsTr("Teléfono:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.letterSpacing: 0.2
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Regular"
                        anchors.leftMargin: 0
                        font.pointSize: 10
                        font.weight: Font.Normal
                        font.family: currentFont
                    }
                    Label {
                        id: textResponsePhone
                        y: 24
                        color: textResTxtColor
                        text: currentClient.phone
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: labelPhone.right
                        font.letterSpacing: 0.25
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenterOffset: 0
                        font.styleName: "Light"
                        fontSizeMode: Text.HorizontalFit
                        font.weight: Font.Light
                        font.pointSize: 10
                        font.family: currentFont
                        anchors.leftMargin: 10
                    }
                }

                Item {
                    id: addressClientData
                    width: 330
                    height: 20
                    visible: true
                    Label {
                        id: labelAddress
                        y: 30
                        color: textLblColor
                        text: qsTr("Dirección:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.letterSpacing: 0.2
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Regular"
                        anchors.leftMargin: 0
                        font.pointSize: 10
                        font.weight: Font.Normal
                        font.family: currentFont
                    }
                    Label {
                        id: textResponseAddress
                        y: 24
                        color: textResTxtColor
                        text: currentClient.address
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: labelAddress.right
                        font.letterSpacing: 0.25
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Light"
                        fontSizeMode: Text.HorizontalFit
                        font.pointSize: 10
                        font.family: currentFont
                        font.weight: Font.Light
                        anchors.leftMargin: 10
                    }
                }

                Item {
                    id: zip_codeClientData
                    width: 330
                    height: 20
                    visible: true
                    Label {
                        id: labelZip_code
                        y: 30
                        color: textLblColor
                        text: qsTr("Código Postal:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.letterSpacing: 0.2
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Regular"
                        anchors.leftMargin: 0
                        font.pointSize: 10
                        font.weight: Font.Normal
                        font.family: currentFont
                    }
                    Label {
                        id: textResponseZip_code
                        y: 24
                        color: textResTxtColor
                        text: currentClient.zip_code
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: labelZip_code.right
                        font.letterSpacing: 0.25
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Light"
                        fontSizeMode: Text.HorizontalFit
                        font.weight: Font.Light
                        font.pointSize: 10
                        font.family: currentFont
                        anchors.leftMargin: 10
                    }
                }

                Item {
                    id: cityClientData
                    width: 330
                    height: 20
                    visible: true
                    Label {
                        id: labelCity
                        y: 30
                        color: textLblColor
                        text: qsTr("Ciudad:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.letterSpacing: 0.2
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Regular"
                        anchors.leftMargin: 0
                        font.pointSize: 10
                        font.weight: Font.Normal
                        font.family: currentFont
                    }
                    Label {
                        id: textResponseCity
                        y: 24
                        color: textResTxtColor
                        text: currentClient.city
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: labelCity.right
                        font.letterSpacing: 0.25
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.styleName: "Light"
                        fontSizeMode: Text.HorizontalFit
                        font.weight: Font.Light
                        font.pointSize: 10
                        font.family: currentFont
                        anchors.leftMargin: 10
                    }
                }


            }
        }

        Rectangle{
            id: budgetDataBg
            width: 350
            height: 141
            color: "#00000000"
            radius: 8
            border.color: "#00000000"
            border.width: 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: textBgClientData.bottom
            anchors.leftMargin: 10
            anchors.rightMargin: 30
            anchors.topMargin: 10

            CustomTextField {
                id: descriptionItem
                width: (bgPage.width * 1/3) - 5
                color: textColorInput
                placeholderTextColor: placeholderTextColorInput
                colorOnFocus: colorOnFocusInput
                colorMouseOver: colorMouseOverInput
                colorDefault: colorDefaultInput
                selectedTextColor: selectedTextColorInput
                selectionColor: selectionColorInput
                font.family: currentFont
                font.pointSize: 9
                placeholderText: "Description"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 0
                anchors.leftMargin: 0
                anchors.rightMargin: 0
            }

            CustomNumberField {
                id: quantityItem
                // color: textColorInput
                anchors.top: descriptionItem.bottom
                anchors.topMargin: 7
                anchors.left: parent.left
                anchors.leftMargin: 0
                colorOnFocus: colorOnFocusInput
                colorMouseOver: colorMouseOverInput
                colorDefault: colorDefaultInput

                // Text color SpinBox
                textColorSpinbox: textColorInput
                selectedTextColorSpinbox: selectedTextColorInput
                selectionColorSpinbox: selectionColorInput

                // // Indicators btn colors
                // indicatorBtnColorDefault: indicatorColorDefault
                // indicatorBtnColorFocus: indicatorColorFocus
                // indicatorBtnColorHovered: indicatorColorHovered
            }
            
            // CustonmButton {
            //     id: addArticle
            //     width: 150
            //     height: 35
            //     text: "Add Entrance"

            //     anchors.left: parent.left
            //     anchors.bottom: parent.bottom
            //     anchors.leftMargin: 10
            //     anchors.bottomMargin: 10

            //     font.family: currentFont
            //     font.pointSize: 9

            //     textBtnColorDefault: txtBtnColorDefault
            //     textBtnColorMouseOver: txtBtnColorMouseOver
            //     textBtnColorClicked: txtBtnColorClicked
            //     colorDefault: colorDefaultBgBtn
            //     colorPressed: colorPressedBgBtn
            //     colorMouseOver: colorMouseOverBgBtn
            // }
        }
    }
}

