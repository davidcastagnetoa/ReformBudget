import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

// Theme.qml
QtObject {
    property var background: themeSwitcher.background
    property var text: themeSwitcher.text

    QtObject {
        id: themeLight
        property color background: "white"
        property color text: "black"
    }

    QtObject {
        id: themeDark
        property color background: "black"
        property color text: "#dcdcdc"
    }

    QtObject {
        id: themeSwitcher
        property var background: themeLight.background
        property var text: themeLight.text
        property bool isDarkMode: false

        function toggleTheme() {
            if (isDarkMode) {
                background = themeLight.background
                text = themeLight.text
                isDarkMode = false
            } else {
                background = themeDark.background
                text = themeDark.text
                isDarkMode = true
            }
        }
    }
}

