import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    width: 840; height: 420
    title: qsTr("Automation_sphere")
    visible: true

    property bool highSpeed: true
    property int currentIndex: 0

    // bg
    Image {
        anchors.fill: parent
        source: "qrc:/image/bg.png"
    }

    // Logo
    Image {
        x: 20; y: 330
        source: "qrc:/image/logo.png"
    }

    // A
    Image {
        x: 788; y: 20
        source: "qrc:/image/a.png"
    }

    // B
    Image {
        x: 20; y: 20
        source: "qrc:/image/b.png"
    }

    //------------------------------------------------------------------------------

    // B-up
    Image {
        x: 80; y: 20
        source: b_up_mouseArea.pressed ? "qrc:/image/b_up_pressed.png" : "qrc:/image/b_up.png"

        MouseArea {
            id: b_up_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // B-down
    Image {
        x: 80; y: 140
        source: b_down_mouseArea.pressed ? "qrc:/image/b_up_pressed.png" : "qrc:/image/b_up.png"
        rotation: 180

        MouseArea {
            id: b_down_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // B-left
    Image {
        x: 20; y: 80
        source: b_left_mouseArea.pressed ? "qrc:/image/b_up_pressed.png" : "qrc:/image/b_up.png"
        rotation: 270

        MouseArea {
            id: b_left_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // B-right
    Image {
        x: 140; y: 80
        source: b_right_mouseArea.pressed ? "qrc:/image/b_up_pressed.png" : "qrc:/image/b_up.png"
        rotation: 90

        MouseArea {
            id: b_right_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    //------------------------------------------------------------------------------

    // A-up
    Image {
        x: 696; y: 20
        source: a_up_mouseArea.pressed ? "qrc:/image/a_up_pressed.png" : "qrc:/image/a_up.png"

        MouseArea {
            id: a_up_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // A-down
    Image {
        x: 696; y: 140
        source: a_down_mouseArea.pressed ? "qrc:/image/a_up_pressed.png" : "qrc:/image/a_up.png"
        rotation: 180

        MouseArea {
            id: a_down_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // A-left
    Image {
        x: 636; y: 80
        source: a_left_mouseArea.pressed ? "qrc:/image/a_up_pressed.png" : "qrc:/image/a_up.png"
        rotation: 270

        MouseArea {
            id: a_left_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // A-right
    Image {
        x: 756; y: 80
        source: a_right_mouseArea.pressed ? "qrc:/image/a_up_pressed.png" : "qrc:/image/a_up.png"
        rotation: 90

        MouseArea {
            id: a_right_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    //------------------------------------------------------------------------------

    // OK
    Image {
        x: 244; y: 20
        source: ok_mouseArea.pressed ? "qrc:/image/ok_pressed.png" : "qrc:/image/ok.png"

        MouseArea {
            id: ok_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // NG
    Image {
        x: 244; y: 80
        source: ng_mouseArea.pressed ? "qrc:/image/ng_pressed.png" : "qrc:/image/ng.png"

        MouseArea {
            id: ng_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // Flip_left
    Image {
        x: 244; y: 140
        source: flip_left_mouseArea.pressed ? "qrc:/image/flip_left_pressed.png"
                                            : "qrc:/image/flip_left.png"

        MouseArea {
            id: flip_left_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // Measure B
    Image {
        x: 244; y: 200
        source: measureB_mouseArea.pressed ? "qrc:/image/measureB_pressed.png"
                                           : "qrc:/image/measureB.png"

        MouseArea {
            id: measureB_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    //------------------------------------------------------------------------------

    // Reclaim
    Image {
        x: 436; y: 20
        source: reclaim_mouseArea.pressed ? "qrc:/image/reclaim_pressed.png"
                                          : "qrc:/image/reclaim.png"

        MouseArea {
            id: reclaim_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // Reclaim
    Image {
        x: 436; y: 80
        source: location_mouseArea.pressed ? "qrc:/image/location_pressed.png"
                                           : "qrc:/image/location.png"

        MouseArea {
            id: location_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // Flip_right
    Image {
        x: 436; y: 140
        source: flip_right_mouseArea.pressed ? "qrc:/image/flip_right_pressed.png"
                                             : "qrc:/image/flip_right.png"

        MouseArea {
            id: flip_right_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // Measure A
    Image {
        x: 436; y: 200
        source: measureA_mouseArea.pressed ? "qrc:/image/measureA_pressed.png"
                                           : "qrc:/image/measureA.png"

        MouseArea {
            id: measureA_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    //------------------------------------------------------------------------------

    // High speed
    Image {
        x: 40; y: 234
        source: highSpeed ? "qrc:/image/checked.png" : "qrc:/image/unchecked.png"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                highSpeed = true
            }
        }
    }

    Image {
        x: 84; y: 230
        source: "qrc:/image/high_speed.png"
    }

    // Low speed
    Image {
        x: 40; y: 284
        source: highSpeed ? "qrc:/image/unchecked.png" : "qrc:/image/checked.png"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                highSpeed = false
            }
        }
    }

    Image {
        x: 84; y: 280
        source: "qrc:/image/low_speed.png"
    }

    //------------------------------------------------------------------------------

    // Combobox
    Image {
        x: 244; y: 260
        source: "qrc:/image/combobox.png"

        // Text
        Image {
            x: 14
            anchors.verticalCenter: parent.verticalCenter
            source: {
                switch ( currentIndex )
                {
                case 0: return "qrc:/image/row.png"
                case 1: return "qrc:/image/col.png"
                case 2: return "qrc:/image/tray.png"
                case 3: return "qrc:/image/sucker.png"
                default: return ""
                }
            }
        }

        // Arraw
        Image {
            x: 146
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/image/arraw.png"

            MouseArea {
                anchors.fill: parent
                onClicked: combobox_dropList.visible = !combobox_dropList.visible
            }
        }
    }

    // Combobox-list
    Image {
        id: combobox_dropList
        x: 245; y: 300
        source: "qrc:/image/combobox_bg.png"
        visible: false

        Column {
            x: 10; y: 5
            spacing: 5

            // Row
            Rectangle {
                width: 160; height: 30
                radius: 5
                border.width: 1
                border.color: "#FFBF00"
                color: "#FFEFBF"
                visible: currentIndex != 0

                Image {
                    x: 10
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/image/row.png"
                }
            }

            // Col
            Rectangle {
                width: 160; height: 30
                radius: 5
                border.width: 1
                border.color: "#FFBF00"
                color: "#FFEFBF"
                visible: currentIndex != 1

                Image {
                    x: 10
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/image/col.png"
                }
            }

            // Tray
            Rectangle {
                width: 160; height: 30
                radius: 5
                border.width: 1
                border.color: "#FFBF00"
                color: "#FFEFBF"
                visible: currentIndex != 2

                Image {
                    x: 10
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/image/tray.png"
                }
            }

            // Sucker
            Rectangle {
                width: 160; height: 30
                radius: 5
                border.width: 1
                border.color: "#FFBF00"
                color: "#FFEFBF"
                visible: currentIndex != 3

                Image {
                    x: 10
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/image/sucker.png"
                }
            }
        }
    }

    //------------------------------------------------------------------------------

    // Location A
    Image {
        x: 450; y: 260
        source: locationA_mouseArea.pressed ? "qrc:/image/locationA_pressed.png"
                                            : "qrc:/image/locationA.png"

        MouseArea {
            id: locationA_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // Location B
    Image {
        x: 570; y: 260
        source: locationB_mouseArea.pressed ? "qrc:/image/locationB_pressed.png"
                                            : "qrc:/image/locationB.png"

        MouseArea {
            id: locationB_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // Calibration
    Image {
        x: 690; y: 260
        source: calibration_mouseArea.pressed ? "qrc:/image/calibration_pressed.png"
                                              : "qrc:/image/calibration.png"

        MouseArea {
            id: calibration_mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    //------------------------------------------------------------------------------

    Connections {
        target: client
    }

}
