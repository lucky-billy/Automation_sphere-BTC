import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: root
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    visible: true

    property bool highSpeed: true
    property int currentIndex: 0
    property var pw: Screen.desktopAvailableWidth / 840
    property var ph: Screen.desktopAvailableHeight / 420

    // 开始扫描蓝牙设备
    Component.onCompleted: client.startDiscovery()

    Connections {
        target: client
        onSendMessage: {
            switch ( messageType )
            {
            case 1:
                messageBox.type = 1
                messageBox.visible = true
                break
            case 2:
                if ( !client.isOpen() ) {
                    messageBox.type = 2
                    messageBox.visible = true
                }
                break
            case 3:
                messageBox.type = 3
                messageBox.visible = true
                break
            case 4:
                messageBox.type = 4
                messageBox.visible = true
                break
            default: break
            }
        }
    }

    // MessageBox
    Rectangle {
        id: messageBox
        anchors.fill: parent
        color: "transparent"
        visible: false

        property int type: 0

        Image {
            anchors.centerIn: parent
            width: 520 * pw; height: 350 * ph
            source: {
                switch ( messageBox.type )
                {
                case 1: return "qrc:/image/connected.png"
                case 2: return "qrc:/image/disconnected.png"
                case 3: return "qrc:/image/noServer.png"
                case 4: return "qrc:/image/notConnected.png"
                default: break
                }
            }

            Image {
                z: messageBox_mask.z + 1
                width: 116 * pw; height: 56 * ph
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter
                source: sure_mouseArea.pressed ? "qrc:/image/sure_pressed.png"
                                               : "qrc:/image/sure.png"

                MouseArea {
                    id: sure_mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if ( messageBox.type > 1 ) {
                            root.close()
                        } else {
                            messageBox.visible = false
                        }
                    }
                }
            }
        }
    }

    //------------------------------------------------------------------------------

    // bg
    Image {
        anchors.fill: parent
        source: "qrc:/image/bg.png"
    }

    // Logo
    Image {
        x: 20 * pw; y: 330 * ph
        width: 209 * pw; height: 70 * ph
        source: "qrc:/image/logo.png"
    }

    // A
    Image {
        x: 788 * pw; y: 20 * ph
        width: 32 * pw; height: 32 * ph
        source: "qrc:/image/a.png"
    }

    // B
    Image {
        x: 20 * pw; y: 20 * ph
        width: 32 * pw; height: 32 * ph
        source: "qrc:/image/b.png"
    }

    //------------------------------------------------------------------------------

    // B-up
    Image {
        x: 80 * pw; y: 20 * ph
        width: 64 * ph; height: 64 * ph
        source: b_up_mouseArea.pressed ? "qrc:/image/b_up_pressed.png" : "qrc:/image/b_up.png"

        MouseArea {
            id: b_up_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onPressed: client.sendData("bup")
            onReleased: client.sendData("bur")
        }
    }

    // B-down
    Image {
        x: 80 * pw; y: 140 * ph
        width: 64 * ph; height: 64 * ph
        source: b_down_mouseArea.pressed ? "qrc:/image/b_up_pressed.png" : "qrc:/image/b_up.png"
        rotation: 180

        MouseArea {
            id: b_down_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onPressed: client.sendData("bdp")
            onReleased: client.sendData("bdr")
        }
    }

    // B-left
    Image {
        x: 20 * pw; y: 80 * ph
        width: 64 * ph; height: 64 * ph
        source: b_left_mouseArea.pressed ? "qrc:/image/b_up_pressed.png" : "qrc:/image/b_up.png"
        rotation: 270

        MouseArea {
            id: b_left_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onPressed: client.sendData("blp")
            onReleased: client.sendData("blr")
        }
    }

    // B-right
    Image {
        x: 140 * pw; y: 80 * ph
        width: 64 * ph; height: 64 * ph
        source: b_right_mouseArea.pressed ? "qrc:/image/b_up_pressed.png" : "qrc:/image/b_up.png"
        rotation: 90

        MouseArea {
            id: b_right_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onPressed: client.sendData("brp")
            onReleased: client.sendData("brr")
        }
    }

    //------------------------------------------------------------------------------

    // A-up
    Image {
        x: 696 * pw; y: 20 * ph
        width: 64 * ph; height: 64 * ph
        source: a_up_mouseArea.pressed ? "qrc:/image/a_up_pressed.png" : "qrc:/image/a_up.png"

        MouseArea {
            id: a_up_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onPressed: client.sendData("aup")
            onReleased: client.sendData("aur")
        }
    }

    // A-down
    Image {
        x: 696 * pw; y: 140 * ph
        width: 64 * ph; height: 64 * ph
        source: a_down_mouseArea.pressed ? "qrc:/image/a_up_pressed.png" : "qrc:/image/a_up.png"
        rotation: 180

        MouseArea {
            id: a_down_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onPressed: client.sendData("adp")
            onReleased: client.sendData("adr")
        }
    }

    // A-left
    Image {
        x: 636 * pw; y: 80 * ph
        width: 64 * ph; height: 64 * ph
        source: a_left_mouseArea.pressed ? "qrc:/image/a_up_pressed.png" : "qrc:/image/a_up.png"
        rotation: 270

        MouseArea {
            id: a_left_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onPressed: client.sendData("alp")
            onReleased: client.sendData("alr")
        }
    }

    // A-right
    Image {
        x: 756 * pw; y: 80 * ph
        width: 64 * ph; height: 64 * ph
        source: a_right_mouseArea.pressed ? "qrc:/image/a_up_pressed.png" : "qrc:/image/a_up.png"
        rotation: 90

        MouseArea {
            id: a_right_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onPressed: client.sendData("arp")
            onReleased: client.sendData("arr")
        }
    }

    //------------------------------------------------------------------------------

    // OK
    Image {
        x: 244 * pw; y: 20 * ph
        width: 160 * pw; height: 50 * ph
        source: ok_mouseArea.pressed ? "qrc:/image/ok_pressed.png" : "qrc:/image/ok.png"

        MouseArea {
            id: ok_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: client.sendData("ok")
        }
    }

    // NG
    Image {
        x: 244 * pw; y: 80 * ph
        width: 160 * pw; height: 50 * ph
        source: ng_mouseArea.pressed ? "qrc:/image/ng_pressed.png" : "qrc:/image/ng.png"

        MouseArea {
            id: ng_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: client.sendData("ng")
        }
    }

    // Flip_left
    Image {
        x: 244 * pw; y: 140 * ph
        width: 160 * pw; height: 50 * ph
        source: flip_left_mouseArea.pressed ? "qrc:/image/flip_left_pressed.png"
                                            : "qrc:/image/flip_left.png"

        MouseArea {
            id: flip_left_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: client.sendData("fl")
        }
    }

    // Measure B
    Image {
        x: 244 * pw; y: 200 * ph
        width: 160 * pw; height: 50 * ph
        source: measureB_mouseArea.pressed ? "qrc:/image/measureB_pressed.png"
                                           : "qrc:/image/measureB.png"

        MouseArea {
            id: measureB_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: client.sendData("mb")
        }
    }

    //------------------------------------------------------------------------------

    // Reclaim
    Image {
        x: 436 * pw; y: 20 * ph
        width: 160 * pw; height: 50 * ph
        source: reclaim_mouseArea.pressed ? "qrc:/image/reclaim_pressed.png"
                                          : "qrc:/image/reclaim.png"

        MouseArea {
            id: reclaim_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: client.sendData("rc")
        }
    }

    // Location
    Image {
        x: 436 * pw; y: 80 * ph
        width: 160 * pw; height: 50 * ph
        source: location_mouseArea.pressed ? "qrc:/image/location_pressed.png"
                                           : "qrc:/image/location.png"

        MouseArea {
            id: location_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: client.sendData("lc")
        }
    }

    // Flip_right
    Image {
        x: 436 * pw; y: 140 * ph
        width: 160 * pw; height: 50 * ph
        source: flip_right_mouseArea.pressed ? "qrc:/image/flip_right_pressed.png"
                                             : "qrc:/image/flip_right.png"

        MouseArea {
            id: flip_right_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: client.sendData("fr")
        }
    }

    // Measure A
    Image {
        x: 436 * pw; y: 200 * ph
        width: 160 * pw; height: 50 * ph
        source: measureA_mouseArea.pressed ? "qrc:/image/measureA_pressed.png"
                                           : "qrc:/image/measureA.png"

        MouseArea {
            id: measureA_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: client.sendData("ma")
        }
    }

    //------------------------------------------------------------------------------

    // High speed
    Image {
        x: 40 * pw; y: 234 * ph
        width: 32 * ph; height: 32 * ph
        source: highSpeed ? "qrc:/image/checked.png" : "qrc:/image/unchecked.png"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                highSpeed = true
                client.sendData("hs")
            }
        }
    }

    Image {
        x: 84 * pw; y: 230 * ph
        width: 100 * pw; height: 40 * ph
        source: "qrc:/image/high_speed.png"
    }

    // Low speed
    Image {
        x: 40 * pw; y: 284 * ph
        width: 32 * ph; height: 32 * ph
        source: highSpeed ? "qrc:/image/unchecked.png" : "qrc:/image/checked.png"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                highSpeed = false
                client.sendData("ls")
            }
        }
    }

    Image {
        x: 84 * pw; y: 280 * ph
        width: 100 * pw; height: 40 * ph
        source: "qrc:/image/low_speed.png"
    }

    //------------------------------------------------------------------------------

    // Combobox
    Image {
        x: 244 * pw; y: 260 * ph; z: 2
        width: 180 * pw; height: 40
        source: "qrc:/image/combobox.png"

        // Text
        Image {
            x: 14 * pw
            width: currentIndex < 2 ? 98 * pw : 117 * pw
            height: 24 * ph
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
            x: 146 * pw
            width: 25 * pw; height: 20 * ph
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/image/arraw.png"
            rotation: combobox_dropList.visible ? 180 : 0

            MouseArea {
                anchors.fill: parent
                onClicked: combobox_dropList.visible = !combobox_dropList.visible
            }
        }
    }

    // Combobox-list
    Image {
        id: combobox_dropList
        x: 245 * pw; y: 304 * ph; z: 2
        width: 180 * pw; height: 100 * pw
        source: "qrc:/image/combobox_bg.png"
        visible: false

        Column {
            x: 10 * pw; y: 5 * ph
            spacing: 5 * ph

            // Row
            Rectangle {
                width: 160 * pw; height: 30 * ph
                radius: 5
                border.width: 1
                border.color: "#FFBF00"
                color: "#FFEFBF"
                visible: currentIndex != 0

                Image {
                    x: 10 * pw
                    width: 98 * pw; height: 24 * ph
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/image/row.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        currentIndex = 0
                        combobox_dropList.visible = false
                    }
                }
            }

            // Col
            Rectangle {
                width: 160 * pw; height: 30 * ph
                radius: 5
                border.width: 1
                border.color: "#FFBF00"
                color: "#FFEFBF"
                visible: currentIndex != 1

                Image {
                    x: 10 * pw
                    width: 98 * pw; height: 24 * ph
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/image/col.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        currentIndex = 1
                        combobox_dropList.visible = false
                    }
                }
            }

            // Tray
            Rectangle {
                width: 160 * pw; height: 30 * ph
                radius: 5
                border.width: 1
                border.color: "#FFBF00"
                color: "#FFEFBF"
                visible: currentIndex != 2

                Image {
                    x: 10 * pw
                    width: 117 * pw; height: 24 * ph
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/image/tray.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        currentIndex = 2
                        combobox_dropList.visible = false
                    }
                }
            }

            // Sucker
            Rectangle {
                width: 160 * pw; height: 30 * ph
                radius: 5
                border.width: 1
                border.color: "#FFBF00"
                color: "#FFEFBF"
                visible: currentIndex != 3

                Image {
                    x: 10 * pw
                    width: 117 * pw; height: 24 * ph
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/image/sucker.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        currentIndex = 3
                        combobox_dropList.visible = false
                    }
                }
            }
        }
    }

    // Mask
    TransparentMask {
        id: mask
        z: 1
        anchors.fill: parent
        visible: combobox_dropList.visible
        onClose: combobox_dropList.visible = false
    }

    //------------------------------------------------------------------------------

    // Location A
    Image {
        x: 450 * pw; y: 260 * ph
        width: 100 * pw; height: 40 * ph
        source: locationA_mouseArea.pressed ? "qrc:/image/locationA_pressed.png"
                                            : "qrc:/image/locationA.png"

        MouseArea {
            id: locationA_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                switch ( currentIndex )
                {
                case 0: client.sendData("x0"); break
                case 1: client.sendData("x1"); break
                case 2: client.sendData("x2"); break
                case 3: client.sendData("x3"); break
                default: break
                }
            }
        }
    }

    // Location B
    Image {
        x: 570 * pw; y: 260 * ph
        width: 100 * pw; height: 40 * ph
        source: locationB_mouseArea.pressed ? "qrc:/image/locationB_pressed.png"
                                            : "qrc:/image/locationB.png"

        MouseArea {
            id: locationB_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                switch ( currentIndex )
                {
                case 0: client.sendData("y0"); break
                case 1: client.sendData("y1"); break
                case 2: client.sendData("y2"); break
                case 3: client.sendData("y3"); break
                default: break
                }
            }
        }
    }

    // Calibration
    Image {
        x: 690 * pw; y: 260 * ph
        width: 100 * pw; height: 40 * ph
        source: calibration_mouseArea.pressed ? "qrc:/image/calibration_pressed.png"
                                              : "qrc:/image/calibration.png"

        MouseArea {
            id: calibration_mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                switch ( currentIndex )
                {
                case 0: client.sendData("z0"); break
                case 1: client.sendData("z1"); break
                case 2: client.sendData("z2"); break
                case 3: client.sendData("z3"); break
                default: break
                }
            }
        }
    }

}
