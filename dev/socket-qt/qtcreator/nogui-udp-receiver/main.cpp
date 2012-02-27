#include <iostream>
#include <QtCore/QCoreApplication>
#include <QtCore/QTextStream>
#include <QtCore/QDebug>
#include <QtNetwork>

int main(int argc, char *argv[])
{
  QCoreApplication a(argc, argv);

  bool go_on_like_this;
  QUdpSocket listenSocket;
  QByteArray datagram;
  QHostAddress senderAddress;
  quint16 senderPort;
  QString msg;

  if (listenSocket.bind(QHostAddress::Any, 8888) < 0) {
    qDebug("Impossible de créer le socket en écoute");
    go_on_like_this = false;
    }
  else
    go_on_like_this = true;

  while (go_on_like_this) {

    if (listenSocket.waitForReadyRead(100)) {
      if (listenSocket.hasPendingDatagrams()) {
        datagram.resize(listenSocket.pendingDatagramSize());
        listenSocket.readDatagram(datagram.data(), datagram.size(), &senderAddress, &senderPort);
        msg = datagram.data();

        qDebug() << "Depuis : " << senderAddress.toString() << ':' << senderPort;
        qDebug() << "Message : " << msg;

        msg = msg.toUpper();
        datagram.clear();
        datagram.append(msg);

        if (listenSocket.writeDatagram(datagram, senderAddress, senderPort) < 0) {
          qDebug("Émission du message modifié impossible");
          listenSocket.close();
          exit(1);
          }
      }

      if (msg  == "_EXIT_") {
        listenSocket.close();
        go_on_like_this = false;
        exit(0);
        }
      }
  }

  listenSocket.close();

  return a.exec();
}
