/*
 * Launch Countdown — Plasma 6 widget
 */

import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    FontLoader {
        id: bigShoulders
        source: "/usr/local/share/fonts/b/BigShoulders_VariableFont_opsz,wght.ttf"
    }

    property var targetDate: parseTarget(Plasmoid.configuration.targetDate)
    property int days:    0
    property int hours:   0
    property int minutes: 0
    property int seconds: 0
    property bool finished: false

    Connections {
        target: Plasmoid.configuration
        function onTargetDateChanged() {
            root.targetDate = root.parseTarget(Plasmoid.configuration.targetDate)
            root.tick()
        }
    }

    function parseTarget(s) {
        if (!s) return new Date(2026, 10, 19, 0, 0, 0)
        const d = new Date(s)
        if (isNaN(d.getTime())) return new Date(2026, 10, 19, 0, 0, 0)
        return d
    }

    function pad(n, w) {
        let s = String(Math.max(0, Math.floor(n)))
        while (s.length < w) s = "0" + s
        return s
    }

    function tick() {
        const now = new Date()
        const s = Math.max(0, Math.floor((root.targetDate.getTime() - now.getTime()) / 1000))
        root.days    = Math.floor(s / 86400)
        root.hours   = Math.floor((s % 86400) / 3600)
        root.minutes = Math.floor((s % 3600) / 60)
        root.seconds = s % 60
        root.finished = (s === 0)
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.tick()
    }

    property string stencilFamily: bigShoulders.status === FontLoader.Ready ? bigShoulders.name : "sans-serif"
    property string monoFamily:    "JetBrains Mono, IBM Plex Mono, Hack, DejaVu Sans Mono, monospace"

    property color accent: Plasmoid.configuration.accentColor || "#5bc8f5"

    property var monthNames: [
        "JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE",
        "JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"
    ]

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    preferredRepresentation: fullRepresentation

    fullRepresentation: Item {
        id: card
        Layout.minimumWidth:    Kirigami.Units.gridUnit * 22
        Layout.minimumHeight:   Kirigami.Units.gridUnit * 9
        Layout.preferredWidth:  Kirigami.Units.gridUnit * 28
        Layout.preferredHeight: Kirigami.Units.gridUnit * 11

        Rectangle {
            anchors.fill: parent
            radius: 14
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#1e1128" }
                GradientStop { position: 1.0; color: "#130c1e" }
            }
            border.color: "#3d1a2e"
            border.width: 1
        }

        Rectangle {
            anchors.fill: parent
            radius: 14
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: Qt.rgba(0.24, 0.04, 0.07, 0.38) }
                GradientStop { position: 0.6; color: Qt.rgba(0.05, 0.03, 0.12, 0.10) }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            anchors.bottomMargin: 22
            spacing: 12

            Row {
                Layout.fillWidth: true
                spacing: 0

                Text {
                    text: root.monthNames[root.targetDate.getMonth()] + " " + root.targetDate.getDate()
                    color: "#ffffff"
                    font.family: root.stencilFamily
                    font.weight: Font.Bold
                    font.pixelSize: 20
                    font.letterSpacing: 1.5
                }

                Text {
                    text: " " + root.targetDate.getFullYear()
                    color: "#e87272"
                    font.family: root.stencilFamily
                    font.weight: Font.Bold
                    font.pixelSize: 20
                    font.letterSpacing: 1.5
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 8

                Repeater {
                    model: {
                        const cells = [
                            { value: root.pad(root.days, root.days >= 100 ? 3 : 2), label: "DAYS" },
                            { value: root.pad(root.hours, 2),   label: "HOURS" },
                            { value: root.pad(root.minutes, 2), label: "MINS" }
                        ]
                        if (Plasmoid.configuration.showSeconds)
                            cells.push({ value: root.pad(root.seconds, 2), label: "SECS" })
                        return cells
                    }

                    delegate: Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumHeight: 72
                        radius: 10
                        color: "#0b0916"
                        border.color: Qt.rgba(0.35, 0.40, 0.58, 0.20)
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.topMargin: 10
                            anchors.bottomMargin: 10
                            spacing: 4

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                Layout.fillHeight: true
                                verticalAlignment: Text.AlignVCenter
                                text: modelData.value
                                color: root.accent
                                font.family: root.stencilFamily
                                font.weight: Font.Light
                                font.pixelSize: Math.min(parent.height * 0.55, 52)
                                font.letterSpacing: 0.4
                                renderType: Text.NativeRendering
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: modelData.label
                                color: "#8899aa"
                                font.family: root.monoFamily
                                font.pixelSize: 10
                                font.letterSpacing: 3
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 7
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 32
            height: 2
            radius: 1
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.35; color: Qt.rgba(0.28, 0.68, 0.90, 0.85) }
                GradientStop { position: 0.65; color: Qt.rgba(0.28, 0.68, 0.90, 0.85) }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }
    }

    compactRepresentation: Item {
        Layout.minimumWidth: compactText.implicitWidth + 16
        Layout.preferredWidth: compactText.implicitWidth + 16

        Text {
            id: compactText
            anchors.centerIn: parent
            text: root.days + "d " + root.pad(root.hours, 2) + ":" + root.pad(root.minutes, 2)
            color: root.accent
            font.family: root.stencilFamily
            font.weight: Font.Light
            font.pixelSize: Math.max(12, Math.round(parent.height * 0.55))
        }

        MouseArea {
            anchors.fill: parent
            onClicked: root.expanded = !root.expanded
        }
    }
}
