import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"


Item {
    //PROPERTIES
    property var buttonList: []
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
        color: "#0d1117"
        anchors.fill: parent

    }

}





