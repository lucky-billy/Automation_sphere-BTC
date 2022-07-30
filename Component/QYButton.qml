import QtQuick 2.0
import "../Component"

// 自定义图像与文字结合的按钮，可通用
Rectangle {
    width: isChinese ? 140 : 160; height: 40
    radius: 2
    color: {
        if (mouseArea.pressed || checked) return m_skin.buttonPressColor
        if (mouseArea.containsMouse) return m_skin.buttonHoverColor
        if (useInModuleBar) return m_skin.moduleBarBackground
        if (onlyText) return m_skin.buttonDefaultColor
        return m_skin.moduleBarBackground
    }

    property alias imageSource: image.source
    property alias content: label.text
    property int pixelSize: 14
    property bool onlyText: imageSource == ""
    property bool useInModuleBar: false
    property bool checked: false

    signal selected()
    signal isPressed()
    signal isReleased()

    // 始终显示为一个正方形
    Image {
        id: image
        x: label.text === "" ? 0 : parent.height / 6; y: x
        width: height; height: parent.height - 2 * y
        visible: !onlyText
    }

    Text {
        id: label
        x: onlyText ? 0 : parent.height + ( useInModuleBar ? 20 : 0 )
        width: parent.width - x; height: parent.height
        font.family: "微软雅黑"
        font.pixelSize: pixelSize
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: onlyText ? Text.AlignHCenter : Text.AlignLeft
        elide: Text.ElideRight
        renderType: isQtRendering ? Text.QtRendering : Text.NativeRendering
        color: parent.enabled ? m_skin.menuTextColor : m_skin.unenableTextColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onPressed: isPressed()
        onReleased: isReleased()
        onClicked: selected()
    }
}
