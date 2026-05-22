import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page

    property alias cfg_targetDate: targetField.text
    property alias cfg_footerLabel: footerField.text
    property alias cfg_accentColor: accentField.text
    property alias cfg_showFooter: footerToggle.checked
    property alias cfg_showSeconds: secondsToggle.checked

    QQC2.TextField {
        id: targetField
        Kirigami.FormData.label: i18n("Target date / time:")
        placeholderText: "2026-11-19T00:00:00"
        Layout.preferredWidth: Kirigami.Units.gridUnit * 16
    }
    QQC2.Label {
        text: i18n("ISO format: YYYY-MM-DDTHH:MM:SS (24h, local time)")
        opacity: 0.7
        font.pointSize: Kirigami.Theme.smallFont.pointSize
    }

    QQC2.TextField {
        id: footerField
        Kirigami.FormData.label: i18n("Footer label:")
        placeholderText: "LAUNCH"
        Layout.preferredWidth: Kirigami.Units.gridUnit * 16
    }

    RowLayout {
        Kirigami.FormData.label: i18n("Accent color:")
        QQC2.TextField {
            id: accentField
            placeholderText: "#19d2ff"
            Layout.preferredWidth: Kirigami.Units.gridUnit * 8
        }
        Rectangle {
            width: 24; height: 24; radius: 4
            color: accentField.text || "#19d2ff"
            border.color: "#444"; border.width: 1
        }
    }

    QQC2.CheckBox {
        id: secondsToggle
        text: i18n("Show seconds")
    }
}
