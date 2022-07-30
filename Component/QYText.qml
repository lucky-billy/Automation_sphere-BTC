import QtQuick 2.12

// 自定义文本框
Text {
    width: isChinese ? 20 : 30; height: 24
    font.family: "微软雅黑"
    font.bold: fontBold
    font.pixelSize: pixelSize
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignLeft
    renderType: isQtRendering ? Text.QtRendering : Text.NativeRendering
    elide: Text.ElideRight
    color: usePromptColor ? m_skin.textPromptColor : m_skin.menuTextColor

    property int pixelSize: 14
    property bool fontBold: false
    property bool usePromptColor: false
}
