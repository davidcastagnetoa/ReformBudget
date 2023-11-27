import QtQuick
import QtQuick.Controls


Item {
    id:topLeftMenu
    width: 30
    height: 30

    // CUSTOM PROPERTIES
    property color bgColor: "#161b22"
    property color bgColorHovered: "#0d1117"
    property color bgColorEntered: "#00C859"
    property bool activeMenu: false

    // BG MENU
    Rectangle {
        id:bg
        width: 30
        anchors.fill: parent
        color: bgColor

        // Text Menu

        // Icon Animated
        Rectangle {
            id: iconAnimated
            width: 16
            height: 16
            color: "#00000000"
            rotation: -45
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.verticalCenterOffset: 0
            anchors.rightMargin: 7
            clip: true

            // Vertical LINE
            Rectangle {
                id: verticalLine
                width: 2
                height: 9
                color: "#e2e3e3"
                anchors.horizontalCenter: parent.horizontalCenter
                antialiasing: true
            }

            // Horizontal LINE
            Rectangle {
                id: horizontalLine
                width: 9
                height: 2
                color: "#e2e3e3"
                anchors.verticalCenter: parent.verticalCenter
                antialiasing: true
            }
        }
    }

        // Mouse Area Events
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if (!activeMenu)
            {
                rotateClicked.running = true
                barVerticalClicked.running = true
                barHorizontalClicked.running = true
                topPositionClicked.running = true
                bg.color = bgColorEntered
                activeMenu = true
            }else {
                rotateExited.running = true
                barVerticalExited.running = true
                barHorizontalExited.running = true
                topPositionExited.running = true
                bg.color = bgColor
                activeMenu = false
            }
        }
        onEntered: {
            if (!activeMenu)
            {
                bg.color = bgColorEntered
            }
        }
        onExited: {
            if (!activeMenu)
            {
                bg.color = bgColor
            }
        }
    }

    // Set Animations

    // Rotate
    PropertyAnimation {
        id: rotateClicked
        properties: "rotation"
        target: iconAnimated
        to: -45
        duration: 150
    }

    PropertyAnimation {
        id: rotateExited
        properties: "rotation"
        target: iconAnimated
        to: 45
        duration: 150
    }

    // Animated Line Bar
    PropertyAnimation {
        id: barVerticalClicked
        properties: "height"
        target: verticalLine
        to: 16
        duration: 150
    }
    PropertyAnimation {
        id: barVerticalExited
        properties: "height"
        target: verticalLine
        to: 9
        duration: 150
    }
    PropertyAnimation {
        id: barHorizontalClicked
        properties: "width"
        target: horizontalLine
        to: 16
        duration: 150
    }
    PropertyAnimation {
        id: barHorizontalExited
        properties: "width"
        target: horizontalLine
        to: 9
        duration: 150
    }

    // Adjust Position
    PropertyAnimation {
        id: topPositionClicked
        properties: "anchors.verticalCenterOffset"
        target: iconAnimated
        to: 0
        duration: 150
    }
    PropertyAnimation {
        id: topPositionExited
        properties: "anchors.verticalCenterOffset"
        target: iconAnimated
        to: 4
        duration: 150
    }


}
/*##^##
Designer {
    D{i:0;formeditorZoom:4}
}
##^##*/
