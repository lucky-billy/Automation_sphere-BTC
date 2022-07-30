#include "qybluetoothclient.h"
#include <QMessageBox>

QYBlueToothClient::QYBlueToothClient(QObject *parent) : QObject(parent)
{
    m_socket = new QBluetoothSocket(QBluetoothServiceInfo::RfcommProtocol, this);

    connect(m_socket, &QBluetoothSocket::connected, [&](){ emit sendMessage(1); });
    connect(m_socket, &QBluetoothSocket::disconnected, [&](){ emit sendMessage(2); m_socket->deleteLater(); });
    connect(m_socket, &QBluetoothSocket::readyRead, [&](){ readData(); });


    m_discoveryAgent = new QBluetoothDeviceDiscoveryAgent(this);

    connect(m_discoveryAgent, &QBluetoothDeviceDiscoveryAgent::deviceDiscovered,
            [&](const QBluetoothDeviceInfo &info){ findNewDevice(info); });
    connect(m_discoveryAgent, &QBluetoothDeviceDiscoveryAgent::finished,
            [&](){ emit sendMessage(3); });
}

QYBlueToothClient::~QYBlueToothClient()
{
    if ( m_socket != nullptr ) {
        m_socket->deleteLater();
    }
}

void QYBlueToothClient::startDiscovery()
{
    // 开始扫描蓝牙设备
    m_discoveryAgent->start();
}

bool QYBlueToothClient::isOpen()
{
    return m_socket->isOpen();
}

void QYBlueToothClient::findNewDevice(const QBluetoothDeviceInfo &info)
{
    QBluetoothDeviceInfo::MajorDeviceClass majorDeviceClass = info.majorDeviceClass();
    if ( majorDeviceClass == QBluetoothDeviceInfo::ComputerDevice ) {
        qDebug() << "name: " + info.name();
        qDebug() << "address: " + info.address().toString();
        qDebug() << "deviceUuid: " + info.deviceUuid().toString();

        if ( !m_socket->isOpen() ) {
            // 蓝牙串口通信服务的UUID码 "00001101-0000-1000-8000-00805F9B34FB"
            static const QLatin1String serviceUuid("e8e10f95-1a70-4b27-9ccf-02010264e9c8");

            // 连接服务器
            m_socket->connectToService(info.address(), QBluetoothUuid(serviceUuid), QIODevice::ReadWrite);
        }
    }
}

void QYBlueToothClient::readData()
{
    QByteArray data = m_socket->readAll();
    QString str = QString::fromLatin1(data);

    // 解析指令
    for ( int i = 0; i< str.size(); ++i )
    {
        if ( str[i] == "<" ) {
            int index = str.indexOf(">", i + 1);
            QString temp = str.mid(i + 1, index - i - 1);

            emit callQmlReciveData(temp);
            i = index;
        }
    }
}

void QYBlueToothClient::sendData(QString data)
{
    if ( !m_socket->isOpen() ) {
        emit sendMessage(4);
        return;
    }

    // 加入头尾
    data = "<" + data + ">";
    m_socket->write(data.toLatin1());
}

void QYBlueToothClient::showMessageBox(int type, QString info)
{
    switch ( type )
    {
    // 在正常操作中提出问题
    case 1: QMessageBox::question(nullptr, QStringLiteral("疑问"), info, QMessageBox::Ok); break;

    // 用于报告有关正常操作的信息
    case 2: QMessageBox::information(nullptr, QStringLiteral("信息"), info, QMessageBox::Ok); break;

    // 用于报告非关键错误
    case 3: QMessageBox::warning(nullptr, QStringLiteral("警告"), info, QMessageBox::Ok); break;

    // 用于报告关键错误
    case 4: QMessageBox::critical(nullptr, QStringLiteral("错误"), info, QMessageBox::Ok); break;
    default: break;
    }
}
