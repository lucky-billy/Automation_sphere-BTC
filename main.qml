import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import "./Component"

Window {
    id: root
    visible: true
    width: 860; height: 360
    color: m_skin.background

    property var m_skin: Object                         // 皮肤 Object
    property real itemWidth: 90
    property real itemHeight: 30
    property bool isChinese: true
    property bool isQtRendering: true
    property int lineWidth: 4                           // 线条宽度，全局适用
    property int margin: 5                              // 边界宽度，全局适用
    property bool initCompleted: false
    property bool ioStateChanged: false

    Component.onCompleted: {
        m_skin = getSkin()

        if ( !client.isOpen() ) {
            client.startDiscovery()
            client.showMessageBox(3, "请先扫描连接至服务器 !")
        }
    }

    // 接收服务器信息
    Connections {
        target: client

        onSendMessage: {
            if ( messageType === 1 ) {
                client.sendData("getSpeedScale")
                master.enabled = true
                client.showMessageBox(2, "已成功连接 !")
            }

            if ( messageType === 2 ) {
                client.startDiscovery()
                client.showMessageBox(3, "连接已被关闭，将继续扫描 !")
                master.enabled = false
            }

            if ( messageType === 3 && !client.isOpen() ) {
                client.startDiscovery()
                client.showMessageBox(3, "未发现有效设备，将继续扫描 !")
            }

            if ( messageType === 4 ) {
                client.showMessageBox(3, "请检查连接后再试 !")
            }
        }

        onCallQmlReciveData: {
            var array = data.split(",")
            var type = array[0]

            // 更新手机端速度比例
            if ( type === "speedScale" ) {
                cmb_speedL.currentIndex = Number(array[1])
                cmb_speedR.currentIndex = Number(array[2])
            }
        }
    }

    // 主界面
    Rectangle {
        id: master
        y: (parent.height - height) / 2
        width: parent.width; height: contentCol.height + 20
        color: m_skin.moduleBarBackground
        enabled: false

        // 左侧轴标题
        Rectangle {
            x: leftaxis.x + 10; y: leftaxis.y - 10; z: leftaxis.z + 1
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
            id: leftaxis
            x: 10; y: 15

            // 操作左侧轴
            Column {
                id: column_l
                spacing: 10

                // 左侧速度选择
                Row {
                    spacing: 10

                    QYText {
                        width: root.itemWidth / 2; height: root.itemHeight
                        text: "速 度 :"
                    }

                    QYCombobox {
                        id: cmb_speedL
                        width: root.itemWidth; height: root.itemHeight
                        leftPadding: 10
                        model: ["高 速", "中 速", "低 速", "超低速"]
                        font.family: "微软雅黑"
                        font.pixelSize: 14
                        currentIndex: 2
                        onCurrentIndexChanged: {
                            var msg = "speedScale_L," + currentIndex.toString()
                            client.sendData(msg)
                        }
                    }
                }

                // X_L
                Row {
                    spacing: 10

                    QYText {
                        width: root.itemWidth / 2; height: root.itemHeight
                        text: "X : "
                    }

                    Rectangle {
                        width: (root.itemWidth - 10) / 2; height: root.itemHeight
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
                                client.sendData("continuousMove_L_X_Left")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("continuousMove_L_X_Stop")
                            }
                        }
                    }

                    Rectangle {
                        width: (root.itemWidth - 10) / 2; height: root.itemHeight
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
                                client.sendData("continuousMove_L_X_Right")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("continuousMove_L_X_Stop")
                            }
                        }
                    }
                }

                // Y_L
                Row {
                    spacing: 10

                    QYText {
                        width: root.itemWidth / 2; height: root.itemHeight
                        text: "Y : "
                    }

                    Rectangle {
                        width: (root.itemWidth - 10) / 2; height: root.itemHeight
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
                                client.sendData("continuousMove_L_Y_Top")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("continuousMove_L_Y_Stop")
                            }
                        }
                    }

                    Rectangle {
                        width: (root.itemWidth - 10) / 2; height: root.itemHeight
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
                                client.sendData("continuousMove_L_Y_Bottom")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("continuousMove_L_Y_Stop")
                            }
                        }
                    }
                }
            }
        }

        // 右侧轴标题
        Rectangle {
            x: rightaxis.x + 10; y: rightaxis.y - 10; z: rightaxis.z + 1
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
            id: rightaxis
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10

            // 操作右侧轴
            Column {
                id: column_r
                spacing: 10

                // 右侧速度选择
                Row {
                    spacing: 10

                    QYText {
                        width: root.itemWidth / 2; height: root.itemHeight
                        text: "速 度 :"
                    }

                    QYCombobox {
                        id: cmb_speedR
                        width: root.itemWidth; height: root.itemHeight
                        leftPadding: 10
                        model: ["高 速", "中 速", "低 速", "超低速"]
                        font.family: "微软雅黑"
                        font.pixelSize: 14
                        currentIndex: 2
                        onCurrentIndexChanged: {
                            var msg = "speedScale_R," + currentIndex.toString()
                            client.sendData(msg)
                        }
                    }
                }

                // X_R
                Row {
                    spacing: 10

                    QYText {
                        width: root.itemWidth / 2; height: root.itemHeight
                        text: "X : "
                    }

                    Rectangle {
                        width: (root.itemWidth - 10) / 2; height: root.itemHeight
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
                                client.sendData("continuousMove_R_X_Left")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("continuousMove_R_X_Stop")
                            }
                        }
                    }

                    Rectangle {
                        width: (root.itemWidth - 10) / 2; height: root.itemHeight
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
                                client.sendData("continuousMove_R_X_Right")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("continuousMove_R_X_Stop")
                            }
                        }
                    }
                }

                // Y_R
                Row {
                    spacing: 10

                    QYText {
                        width: root.itemWidth / 2; height: root.itemHeight
                        text: "Y : "
                    }

                    Rectangle {
                        width: (root.itemWidth - 10) / 2; height: root.itemHeight
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
                                client.sendData("continuousMove_R_Y_Top")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("continuousMove_R_Y_Stop")
                            }
                        }
                    }

                    Rectangle {
                        width: (root.itemWidth - 10) / 2; height: root.itemHeight
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
                                client.sendData("continuousMove_R_Y_Bottom")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("continuousMove_R_Y_Stop")
                            }
                        }
                    }
                }
            }
        }

        // Separator line - portrait
        Rectangle {
            width: lineWidth; height: parent.height
            radius: lineWidth
            anchors.left: parent.left
            anchors.leftMargin: leftaxis.width + leftaxis.x + 10
            color: m_skin.separatorLineColor
        }

        Column {
            id: contentCol
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: leftaxis.width + leftaxis.x + 10 + lineWidth + margin * 2
            spacing: 10

            // 标定右侧点位
            Row {
                spacing: 10

                property real currentX: 0
                property real currentY: 0

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "右侧点标定 : "
                }

                QYCombobox {
                    id: cmb_pos_R
                    width: root.itemWidth * 1.3; height: root.itemHeight
                    leftPadding: 10
                    model: ["初始点", "安全点", "定位点", "测量点", "放料点"]
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                }

                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "移 动"
                    onSelected: {
                        var msg = "move_R," + cmb_pos_R.currentIndex.toString()
                        client.sendData(msg)
                    }
                }

                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "保 存"
                    onSelected: {
                        var msg = "save_R," + cmb_pos_R.currentIndex.toString()
                        client.sendData(msg)
                    }
                }
            }

            // 标定左侧点位
            Row {
                spacing: 10

                property real currentX: 0
                property real currentY: 0

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "左侧点标定 : "
                }

                QYCombobox {
                    id: cmb_pos_L
                    width: root.itemWidth * 1.3; height: root.itemHeight
                    leftPadding: 10
                    model: ["OK 初始点", "NG 初始点", "测量点", "取料点", "安全点"]
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                }

                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "移 动"
                    onSelected: {
                        var msg = "move_L," + cmb_pos_L.currentIndex.toString()
                        client.sendData(msg)
                    }
                }

                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "保 存"
                    onSelected: {
                        var msg = "save_L," + cmb_pos_L.currentIndex.toString()
                        client.sendData(msg)
                    }
                }
            }

            // 标定镜片/料盘间距
            Row {
                spacing: 10

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "间距标定 : "
                }

                QYCombobox {
                    id: cmb_space
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
                        var msg = "calibrationPosA," + cmb_space.currentIndex.toString()
                        client.sendData(msg)
                    }
                }

                // 记录移动后对准的第二个位置 并计算出与第一个位置之间的差 即为行间距
                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "位置 B"
                    onSelected: {
                        lineSpacingB.color = "#00FF00"
                        var msg = "calibrationPosB," + cmb_space.currentIndex.toString()
                        client.sendData(msg)
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
                    onIsCheckedChanged: {
                        var msg = "IO_locate," + (isChecked ? 1 : 0).toString()
                        client.sendData(msg)
                    }
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
                    onIsCheckedChanged: {
                        var msg = "IO_flip," + (isChecked ? 1 : 0).toString()
                        client.sendData(msg)
                    }
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
                    onIsCheckedChanged: {
                        var msg = "IO_flip_locate," + (isChecked ? 1 : 0).toString()
                        client.sendData(msg)
                    }
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
                    id: cmb_Cylinder
                    width: root.itemWidth; height: root.itemHeight
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                    model: ["左", "右"]
                }

                QYCheckBoxOppisite {
                    width: root.itemWidth * 2; height: root.itemHeight
                    prefix: "上升"
                    suffix: "下降"
                    onIsCheckedChanged: {
                        if ( cmb_Cylinder.currentIndex === 0 ) {
                            var msg = "IO_l_axis_z," + (isChecked ? 1 : 0).toString()
                        } else {
                            msg = "IO_r_axis_z," + (isChecked ? 1 : 0).toString()
                        }
                        client.sendData(msg)
                    }
                }
            }

            // 真空
            Row {
                spacing: 10

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "真 空 :"
                }

                QYCombobox {
                    id: cmb_Vacuum
                    width: root.itemWidth; height: root.itemHeight
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                    model: ["左侧左", "左侧右", "右侧左", "右侧右"]
                }

                QYCheckBoxOppisite {
                    width: root.itemWidth * 2; height: root.itemHeight
                    prefix: "打开"
                    suffix: "关闭"
                    onIsCheckedChanged: {
                        var type = ""
                        if ( cmb_Vacuum.currentIndex === 0 ) type = "IO_l_l_sucker"
                        if ( cmb_Vacuum.currentIndex === 1 ) type = "IO_l_r_sucker"
                        if ( cmb_Vacuum.currentIndex === 2 ) type = "IO_r_l_sucker"
                        if ( cmb_Vacuum.currentIndex === 3 ) type = "IO_r_r_sucker"
                        var msg = type + "," + (isChecked ? 1 : 0).toString()
                        client.sendData(msg)
                    }
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
