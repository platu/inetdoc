#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QtCore/QTextStream>
#include <QtCore/QDebug>
#include <QtNetwork>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{

    listenSocket = new QUdpSocket(this);

    if (listenSocket->bind(QHostAddress::Any, 8888) < 0) {
            qDebug("Impossible de créer le socket en écoute");
            exit(1);
    }

    ui->setupUi(this);

    QObject::connect(listenSocket, SIGNAL(readyRead()),
                this, SLOT(processPendingDatagrams()));

    QObject::connect(ui->pushButton, SIGNAL(clicked()),
                this, SLOT(close()));
}

MainWindow::~MainWindow()
{
    listenSocket->close();

    delete ui;
}

void MainWindow::processPendingDatagrams()
{

    while (listenSocket->hasPendingDatagrams())  {

        QByteArray datagram;

        datagram.resize(listenSocket->pendingDatagramSize());
        listenSocket->readDatagram(datagram.data(), datagram.size(), 
	                           &senderAddress, 
				   &senderPort);

        msg = datagram.data();
	qDebug() << "Depuis : " << senderAddress.toString() << ':' << senderPort;
	qDebug() << "Message : " << msg;

        ui->senderLabel->setText(tr("Depuis : %1:%2")
	                         . arg(senderAddress.toString())
				 . arg(senderPort));
        ui->msgLabel->setText(tr("Message : \"%1\"")
	                      . arg(msg));

        msg = msg.toUpper();

        datagram.clear();
        datagram.append(msg);

        if (listenSocket->writeDatagram(datagram, senderAddress, senderPort) < 0) {
            qDebug("Émission du message modifié impossible");
            listenSocket->close();
            exit(1);
        }
    }
}
