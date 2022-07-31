import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import "./Component"

Window {
    id: root
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    color: m_skin.background
    visible: true

    property var m_skin: Object
    property real itemWidth: 90
    property real itemHeight: 30

    Component.onCompleted: {
        m_skin = getSkin()

        if ( !client.isOpen() ) {
            // 开始扫描蓝牙设备
            client.startDiscovery()
            client.showMessageBox(2, "开始搜索蓝牙服务器 !")
        }
    }

    // 接收服务器信息
    Connections {
        target: client

        onSendMessage: {
            if ( messageType === 1 ) {
                // 获取当前信息，用于初始化界面
                client.sendData("getCurrentState")

                // 界面可用
                master.enabled = true

                client.showMessageBox(2, "连接成功 !")
            }

            else if ( messageType === 2 ) {
                // 开始扫描蓝牙设备
                client.startDiscovery()

                // 界面不可用
                master.enabled = false

                client.showMessageBox(3, "蓝牙服务器已关闭，将持续扫描 !")
            }

            else if ( messageType === 3 && !client.isOpen() ) {
                // 开始扫描蓝牙设备
                client.startDiscovery()

                client.showMessageBox(3, "未发现蓝牙服务器，将持续扫描 !")
            }

            else if ( messageType === 4 ) {
                client.showMessageBox(3, "蓝牙通信出现异常 !")
            }
        }

        onCallQmlReciveData: {}
    }

    // 主界面
    Rectangle {
        id: master
        anchors.fill: parent
        color: m_skin.moduleBarBackground
        enabled: false

        // 左侧轴标题
        Rectangle {
            x: leftAxis.x + 10; y: leftAxis.y - 10; z: leftAxis.z + 1
            width: lable_l.contentWidth + 10; height: lable_l.contentHeight
            color: m_skin.moduleBarBackground

            QYText {
                id: lable_l
                width: contentWidth; height: contentHeight
                elide: Text.ElideNone
                fontBold: true
                pixelSize: 16
                leftPadding: 5
                text: "左侧轴"
            }
        }

        // 左侧轴
        GroupBox {
            id: leftAxis
            x: 10; y: 15

            // 操作左侧轴
            Column {
                spacing: 10

                // 左侧速度选择
                Row {
                    spacing: 10

                    QYText {
                        width: root.itemWidth / 2; height: root.itemHeight
                        text: "速 度 :"
                    }

                    QYCombobox {
                        id: leftSpeedCombobox
                        width: root.itemWidth; height: root.itemHeight
                        leftPadding: 10
                        model: ["高 速", "中 速", "低 速", "超低速"]
                        font.family: "微软雅黑"
                        font.pixelSize: 14
                        onCurrentIndexChanged: {}
                    }
                }

                // X_L
                Row {
                    spacing: 10

                    QYText {
                        width: root.itemWidth / 2; height: 40
                        text: "X : "
                    }

                    Rectangle {
                        width: 40; height: 40
                        radius: 5
                        color: m_skin.unenableTextColor

                        Image {
                            anchors.fill: parent
                            anchors.margins: 5
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/image/Component/LeftSL.png"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                parent.color = m_skin.buttonPressColor
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                            }
                        }
                    }

                    Rectangle {
                        width: 40; height: 40
                        radius: 5
                        color: m_skin.unenableTextColor

                        Image {
                            anchors.fill: parent
                            anchors.margins: 5
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/image/Component/RightSL.png"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                parent.color = m_skin.buttonPressColor
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                            }
                        }
                    }
                }

                // Y_L
                Row {
                    spacing: 10

                    QYText {
                        width: root.itemWidth / 2; height: 40
                        text: "Y : "
                    }

                    Rectangle {
                        width: 40; height: 40
                        radius: 5
                        color: m_skin.unenableTextColor

                        Image {
                            anchors.fill: parent
                            anchors.margins: 5
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/image/Component/UpSL.png"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                parent.color = m_skin.buttonPressColor
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                            }
                        }
                    }

                    Rectangle {
                        width: 40; height: 40
                        radius: 5
                        color: m_skin.unenableTextColor

                        Image {
                            anchors.fill: parent
                            anchors.margins: 5
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/image/Component/DownSL.png"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                parent.color = m_skin.buttonPressColor
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                            }
                        }
                    }
                }
            }
        }

        // 右侧轴标题
        Rectangle {
            x: rightAxis.x + 10; y: rightAxis.y - 10; z: rightAxis.z + 1
            width: lable_r.contentWidth + 10; height: lable_r.contentHeight
            color: m_skin.moduleBarBackground

            QYText {
                id: lable_r
                width: contentWidth; height: contentHeight
                elide: Text.ElideNone
                fontBold: true
                pixelSize: 16
                leftPadding: 5
                text: "右侧轴"
            }
        }

        // 右侧轴
        GroupBox {
            id: rightAxis
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10

            // 操作右侧轴
            Column {
                spacing: 10

                // 右侧速度选择
                Row {
                    spacing: 10

                    QYText {
                        width: root.itemWidth / 2; height: root.itemHeight
                        text: "速 度 :"
                    }

                    QYCombobox {
                        id: rightSpeedCombobox
                        width: root.itemWidth; height: root.itemHeight
                        leftPadding: 10
                        model: ["高 速", "中 速", "低 速", "超低速"]
                        font.family: "微软雅黑"
                        font.pixelSize: 14
                        onCurrentIndexChanged: {}
                    }
                }

                // X_R
                Row {
                    spacing: 10

                    QYText {
                        width: root.itemWidth / 2; height: 40
                        text: "X : "
                    }

                    Rectangle {
                        width: 40; height: 40
                        radius: 5
                        color: m_skin.unenableTextColor

                        Image {
                            anchors.fill: parent
                            anchors.margins: 5
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/image/Component/LeftSL.png"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                parent.color = m_skin.buttonPressColor
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                            }
                        }
                    }

                    Rectangle {
                        width: 40; height: 40
                        radius: 5
                        color: m_skin.unenableTextColor

                        Image {
                            anchors.fill: parent
                            anchors.margins: 5
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/image/Component/RightSL.png"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                parent.color = m_skin.buttonPressColor
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                            }
                        }
                    }
                }

                // Y_R
                Row {
                    spacing: 10

                    QYText {
                        width: root.itemWidth / 2; height: 40
                        text: "Y : "
                    }

                    Rectangle {
                        width: 40; height: 40
                        radius: 5
                        color: m_skin.unenableTextColor

                        Image {
                            anchors.fill: parent
                            anchors.margins: 5
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/image/Component/UpSL.png"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                parent.color = m_skin.buttonPressColor
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                            }
                        }
                    }

                    Rectangle {
                        width: 40; height: 40
                        radius: 5
                        color: m_skin.unenableTextColor

                        Image {
                            anchors.fill: parent
                            anchors.margins: 5
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/image/Component/DownSL.png"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                parent.color = m_skin.buttonPressColor
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                            }
                        }
                    }
                }
            }
        }

        // Separator line - portrait
        Rectangle {
            width: 4; height: parent.height - 10
            radius: 4
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: leftAxis.x + leftAxis.width + 10
            color: m_skin.separatorLineColor
        }

        Column {
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: leftAxis.x + leftAxis.width + 24
            spacing: 10

            // 右侧点标定
            Row {
                spacing: 10

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "右侧点标定 : "
                }

                QYCombobox {
                    id: rightPosCombobox
                    width: root.itemWidth * 1.3; height: root.itemHeight
                    leftPadding: 10
                    model: ["安全点", "初始点", "定位点", "测量点", "放料点"]
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                }

                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "移 动"
                    onSelected: {}
                }

                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "保 存"
                    onSelected: {}
                }
            }

            // 左侧点标定
            Row {
                spacing: 10

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "左侧点标定 : "
                }

                QYCombobox {
                    id: leftPosCombobox
                    width: root.itemWidth * 1.3; height: root.itemHeight
                    leftPadding: 10
                    model: ["安全点", "OK 初始点", "NG 初始点", "测量点", "取料点"]
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                }

                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "移 动"
                    onSelected: {}
                }

                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "保 存"
                    onSelected: {}
                }
            }

            // 间距标定
            Row {
                spacing: 10

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "间距标定 : "
                }

                QYCombobox {
                    id: spaceCombobox
                    width: root.itemWidth * 1.3; height: root.itemHeight
                    leftPadding: 10
                    model: ["镜片行间距", "镜片列间距", "料盘行间距", "料盘列间距", "吸盘间距"]
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                }

                // 同心圆 状态标志
                Rectangle {
                    width: root.itemHeight; height: root.itemHeight
                    radius: height
                    color: "transparent"
                    border.color: lineSpacingB.color
                    border.width: 2

                    Rectangle {
                        id: lineSpacingB
                        x: root.itemHeight / 4; y: root.itemHeight / 4
                        width: root.itemHeight / 2; height: root.itemHeight / 2
                        radius: root.itemHeight / 2
                        color: m_skin.separatorLineColor
                    }
                }

                // 记录第一个对准的位置
                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "位置 A"
                    onSelected: {
                        lineSpacingB.color = "#FFFF00"
                    }
                }

                // 记录移动后对准的第二个位置
                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "位置 B"
                    onSelected: {
                        lineSpacingB.color = "#00FF00"
                    }
                }
            }

            // 定位气缸
            Row {
                spacing: 10

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "定位气缸 :"
                }

                QYCheckBoxOppisite {
                    width: root.itemWidth * 2; height: root.itemHeight
                    prefix: "夹紧"
                    suffix: "释放"
                    onIsCheckedChanged: {}
                }
            }

            // 翻面气缸
            Row {
                spacing: 10

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "翻面气缸 :"
                }

                QYCheckBoxOppisite {
                    width: root.itemWidth * 2; height: root.itemHeight
                    prefix: "向左"
                    suffix: "向右"
                    onIsCheckedChanged: {}
                }
            }

            // 翻面定位
            Row {
                spacing: 10

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "翻面定位 :"
                }

                QYCheckBoxOppisite {
                    width: root.itemWidth * 2; height: root.itemHeight
                    prefix: "夹紧"
                    suffix: "释放"
                    onIsCheckedChanged: {}
                }
            }

            // 气缸升降
            Row {
                spacing: 10

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "Z 轴气缸 :"
                }

                QYCombobox {
                    id: zAxisCombobox
                    width: root.itemWidth; height: root.itemHeight
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                    model: ["左", "右"]
                }

                QYCheckBoxOppisite {
                    width: root.itemWidth * 2; height: root.itemHeight
                    prefix: "上升"
                    suffix: "下降"
                    onIsCheckedChanged: {}
                }
            }

            // 抽气
            Row {
                spacing: 10

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "抽 气 :"
                }

                QYCombobox {
                    id: vacuumCombobox
                    width: root.itemWidth; height: root.itemHeight
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                    model: ["左侧左", "左侧右", "右侧左", "右侧右"]
                }

                QYCheckBoxOppisite {
                    width: root.itemWidth * 2; height: root.itemHeight
                    prefix: "打开"
                    suffix: "关闭"
                    onIsCheckedChanged: {}
                }
            }
        }
    }

    function getSkin() {
        var obj = {}
        obj.menuBarBackground = "#2D2D2D"
        obj.menuHoverColor = "#646464"
        obj.menuTextColor = "#FFFFFF"
        obj.unenableTextColor = "#9B9B9B"
        obj.actionBackground = "#373737"
        obj.actionHoverColor = "#4FA0F1"

        // 工具栏
        obj.toolBarBackground = "#AAAAAA"
        obj.toolButtonHoverColor = "#999999"
        obj.toolButtonPressColor = "#777777"
        obj.toolBarSeparatorLineColor = "#FFFFFF"

        // 功能栏及常用按钮
        obj.background = "#858585"
        obj.moduleBarBackground = "#3F3F3F"
        obj.buttonHoverColor = "#999999"
        obj.buttonDefaultColor = "#818181"
        obj.buttonPressColor = "#666666"
        obj.isDark = true

        // 分割线
        obj.separatorLineColor = "#707070"

        // 文本提示颜色
        obj.textPromptColor = "#FFFFFF"

        // 下拉框
        obj.comboBoxBackground = "#2D2D2D"
        obj.comboBoxHoverColor = "#4F4F4F"
        obj.comboBoxPressColor = "#363636"

        // 数据报表
        obj.tableWidgetItemPressColor = "#696969"
        obj.tableWidgetSeparatorLineColor = "#CFCFCF"

        // 边框
        obj.defaultBorderColor = "#9B9B9B"
        obj.activeBorderColor = "#FFFFFF"

        // 3D视图背景色
        obj.viewBackgroundIn3D = "#363636"

        // 图片默认背景色
        obj.imageBackground = "#000000"

        return obj;
    }
}
