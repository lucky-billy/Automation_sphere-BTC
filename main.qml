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

    property var leftPosList: [0,0,0,0,0]
    property var rightPosList: [0,0,0,0,0]
    property var spaceList: [0,0,0,0,0]

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

        onCallQmlReciveData: {
            var list = data.split(",")
            var type = list[0]

            // 初始化界面
            if ( type === "currentState" ) {
                leftSpeedCombobox.currentIndex = Number(list[1])
                rightSpeedCombobox.currentIndex = Number(list[2])
                leftPosList[0] = Number(list[3])
                leftPosList[1] = Number(list[4])
                leftPosList[2] = Number(list[5])
                leftPosList[3] = Number(list[6])
                leftPosList[4] = Number(list[7])
                rightPosList[0] = Number(list[8])
                rightPosList[1] = Number(list[9])
                rightPosList[2] = Number(list[10])
                rightPosList[3] = Number(list[11])
                rightPosList[4] = Number(list[12])
                spaceList[0] = Number(list[13])
                spaceList[1] = Number(list[14])
                spaceList[2] = Number(list[15])
                spaceList[3] = Number(list[16])
                locateCheckBox.isChecked = Number(list[17]) === 1
                flipCheckBox.isChecked = Number(list[18]) === 1
                flipLocateCheckBox.isChecked = Number(list[19]) === 1
                zAxisCombobox.currentIndex = Number(list[20])
                zAxisCheckBox.isChecked = Number(list[21]) === 1
                vacuumCombobox.currentIndex = Number(list[22])
                vacuumCheckBox.isChecked = Number(list[23]) === 1

                rightPos.state = rightPosList[rightPosCombobox.currentIndex] === 1 ? 2 : 0
                leftPos.state = leftPosList[leftPosCombobox.currentIndex] === 1 ? 2 : 0
                spacePos.state = spaceList[spaceCombobox.currentIndex] === 1 ? 2 : 0
            }

            else if ( type === "changeLeftSpeed" ) {
                // 修改左侧速度
                leftSpeedCombobox.currentIndex = Number(list[1])
            }

            else if ( type === "changeRightSpeed" ) {
                // 修改右侧速度
                rightSpeedCombobox.currentIndex = Number(list[1])
            }

            else if ( type === "leftPosSaveCheck" ) {
                // 左侧点标定
                var index = Number(list[1])
                var value = Number(list[2])
                leftPosList[index] = value
                leftPos.state = leftPosList[leftPosCombobox.currentIndex] === 1 ? 2 : 0
            }

            else if ( type === "rightPosSaveCheck" ) {
                // 右侧点标定
                index = Number(list[1])
                value = Number(list[2])
                rightPosList[index] = value
                rightPos.state = rightPosList[rightPosCombobox.currentIndex] === 1 ? 2 : 0
            }

            else if ( type === "spacePosBCheck" ) {
                // 间距标定
                index = Number(list[1])
                value = Number(list[2])
                spaceList[index] = value
                spacePos.state = spaceList[spaceCombobox.currentIndex] === 1 ? 2 : 0
            }

            else if ( type === "locateCheckBox" ) {
                // 定位气缸
                locateCheckBox.isChecked = Number(list[1]) === 1
            }
            else if ( type === "flipCheckBox" ) {
                // 翻面气缸
                flipCheckBox.isChecked = Number(list[1]) === 1
            }
            else if ( type === "flipLocateCheckBox" ) {
                // 翻面定位
                flipLocateCheckBox.isChecked = Number(list[1]) === 1
            }
            else if ( type === "zAxis" ) {
                // Z 轴气缸
                zAxisCombobox.currentIndex = Number(list[1])
                zAxisCheckBox.isChecked = Number(list[2]) === 1
            }
            else if ( type === "vacuum" ) {
                // 抽气
                vacuumCombobox.currentIndex = Number(list[1])
                vacuumCheckBox.isChecked = Number(list[2]) === 1
            }
        }
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
                        onCurrentIndexChanged: { client.sendData("changeLeftSpeed," + currentIndex) }
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
                                client.sendData("llxMove")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("llxStop")
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
                                client.sendData("lrxMove")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("lrxStop")
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
                                client.sendData("luyMove")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("luyStop")
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
                                client.sendData("ldyMove")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("ldyStop")
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
                        onCurrentIndexChanged: { client.sendData("changeRightSpeed," + currentIndex) }
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
                                client.sendData("rlxMove")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("rlxStop")
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
                                client.sendData("rrxMove")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("rrxStop")
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
                                client.sendData("ruyMove")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("ruyStop")
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
                                client.sendData("rdyMove")
                            }
                            onReleased: {
                                parent.color = m_skin.unenableTextColor
                                client.sendData("rdyStop")
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
                    model: ["OK 初始点", "NG 初始点", "测量点 C", "测量点 D", "取料点"]
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                    onCurrentIndexChanged: leftPos.state = leftPosList[leftPosCombobox.currentIndex] === 1 ? 2 : 0
                }

                // 同心圆 状态标志
                Rectangle {
                    width: root.itemHeight; height: root.itemHeight
                    radius: height
                    color: "transparent"
                    border.color: leftPos.color
                    border.width: 2

                    Rectangle {
                        id: leftPos
                        x: root.itemHeight / 4; y: root.itemHeight / 4
                        width: root.itemHeight / 2; height: root.itemHeight / 2
                        radius: root.itemHeight / 2
                        color: {
                            switch ( leftPos.state )
                            {
                            case 0: m_skin.separatorLineColor; break
                            case 1: "#FFFF00"; break
                            case 2: "#00FF00"; break
                            default: break
                            }
                        }

                        property int state: 0
                    }
                }

                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "移 动"
                    onSelected: { client.sendData("leftPosMove," + leftPosCombobox.currentIndex) }
                }

                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "保 存"
                    onSelected: { client.sendData("leftPosSave," + leftPosCombobox.currentIndex) }
                }
            }

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
                    model: ["初始点", "定位点", "测量点 A", "测量点 B", "放料点"]
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                    onCurrentIndexChanged: rightPos.state = rightPosList[rightPosCombobox.currentIndex] === 1 ? 2 : 0
                }

                // 同心圆 状态标志
                Rectangle {
                    width: root.itemHeight; height: root.itemHeight
                    radius: height
                    color: "transparent"
                    border.color: rightPos.color
                    border.width: 2

                    Rectangle {
                        id: rightPos
                        x: root.itemHeight / 4; y: root.itemHeight / 4
                        width: root.itemHeight / 2; height: root.itemHeight / 2
                        radius: root.itemHeight / 2
                        color: {
                            switch ( rightPos.state )
                            {
                            case 0: m_skin.separatorLineColor; break
                            case 1: "#FFFF00"; break
                            case 2: "#00FF00"; break
                            default: break
                            }
                        }

                        property int state: 0
                    }
                }

                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "移 动"
                    onSelected: { client.sendData("rightPosMove," + rightPosCombobox.currentIndex) }
                }

                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "保 存"
                    onSelected: { client.sendData("rightPosSave," + rightPosCombobox.currentIndex) }
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
                    model: ["镜片行间距", "镜片列间距", "料盘行间距", "料盘列间距"]
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                    onCurrentIndexChanged: spacePos.state = spaceList[spaceCombobox.currentIndex] === 1 ? 2 : 0
                }

                // 同心圆 状态标志
                Rectangle {
                    width: root.itemHeight; height: root.itemHeight
                    radius: height
                    color: "transparent"
                    border.color: spacePos.color
                    border.width: 2

                    Rectangle {
                        id: spacePos
                        x: root.itemHeight / 4; y: root.itemHeight / 4
                        width: root.itemHeight / 2; height: root.itemHeight / 2
                        radius: root.itemHeight / 2
                        color: {
                            switch ( spacePos.state )
                            {
                            case 0: m_skin.separatorLineColor; break
                            case 1: "#FFFF00"; break
                            case 2: "#00FF00"; break
                            default: break
                            }
                        }

                        property int state: 0
                    }
                }

                // 记录第一个对准的位置
                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "位置 A"
                    onSelected: {
                        spacePos.state = 1
                        spaceCombobox.enabled = false
                        client.sendData("spacePosA," + spaceCombobox.currentIndex)
                    }
                }

                // 记录移动后对准的第二个位置
                QYButton {
                    width: root.itemWidth; height: root.itemHeight
                    content: "位置 B"
                    onSelected: {
                        spaceCombobox.enabled = true
                        client.sendData("spacePosB," + spaceCombobox.currentIndex)
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
                    id: locateCheckBox
                    width: root.itemWidth * 2; height: root.itemHeight
                    prefix: "夹紧"
                    suffix: "释放"
                    onIsCheckedChanged: { client.sendData("locateCheckBox," + String(isChecked ? 1 : 0)) }
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
                    id: flipCheckBox
                    width: root.itemWidth * 2; height: root.itemHeight
                    prefix: "向左"
                    suffix: "向右"
                    onIsCheckedChanged: { client.sendData("flipCheckBox," + String(isChecked ? 1 : 0)) }
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
                    id: flipLocateCheckBox
                    width: root.itemWidth * 2; height: root.itemHeight
                    prefix: "夹紧"
                    suffix: "释放"
                    onIsCheckedChanged: { client.sendData("flipLocateCheckBox," + String(isChecked ? 1 : 0)) }
                }
            }

            // Z 轴气缸
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
                    id: zAxisCheckBox
                    width: root.itemWidth * 2; height: root.itemHeight
                    prefix: "上升"
                    suffix: "下降"
                    isChecked: true
                    onIsCheckedChanged: { client.sendData("zAxis," + zAxisCombobox.currentIndex + "," + String(isChecked ? 1 : 0)) }
                }
            }

            // 吸气
            Row {
                spacing: 10

                QYText {
                    width: root.itemWidth; height: root.itemHeight
                    text: "吸 气 :"
                }

                QYCombobox {
                    id: vacuumCombobox
                    width: root.itemWidth; height: root.itemHeight
                    font.family: "微软雅黑"
                    font.pixelSize: 14
                    model: ["左侧左", "左侧右", "右侧左", "右侧右"]
                }

                QYCheckBoxOppisite {
                    id: vacuumCheckBox
                    width: root.itemWidth * 2; height: root.itemHeight
                    prefix: "打开"
                    suffix: "关闭"
                    onIsCheckedChanged: { client.sendData("vacuum," + vacuumCombobox.currentIndex + "," + String(isChecked ? 1 : 0)) }
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
