#include <iostream>
#include <QtCore/QCoreApplication>
#include <QtCore/QTextStream>
#include <QtCore/QDebug>
#include <QtNetwork>

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    QUdpSocket listenSocket;
    QByteArray datagram;
    QHostAddress senderAddress;
    quint16 senderPort;
    QString msg;

    if (!listenSocket.bind(QHostAddress::Any, 8888)) {
        qDebug("Impossible de créer le socket en écoute");
        exit(EXIT_FAILURE);
    }

    while (1) {

        if (listenSocket.waitForReadyRead(100)) {
            if (listenSocket.hasPendingDatagrams()) {
                datagram.resize(listenSocket.pendingDatagramSize());
                if (listenSocket.readDatagram(datagram.data(), datagram.size(),
                                              &senderAddress, &senderPort) == -1) {
                    listenSocket.close();
                    exit(EXIT_FAILURE);
                }
                msg = datagram.data();

                qDebug() << "Depuis : " << senderAddress.toString() << ':' << senderPort;
                qDebug() << "Message : " << msg;

                msg = msg.toUpper();
                datagram.clear();
                datagram.append(msg);

                if (listenSocket.writeDatagram(datagram, senderAddress, senderPort) == -1) {
                    qDebug("Émission du message modifié impossible");
                    listenSocket.close();
                    exit(EXIT_FAILURE);
                }
            }

            if (msg  == "_EXIT_") {
                listenSocket.close();
                exit(EXIT_SUCCESS);
            }
        }
    }

    listenSocket.close();

    return a.exec();
 }
