#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QtGui>
#include <QtCore/QTextStream>
#include <QtCore/QDebug>
#include <QtNetwork>

namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private slots:
    void processPendingDatagrams();

private:
    Ui::MainWindow *ui;
    QLabel *senderLabel, *msgLabel;
    QUdpSocket *listenSocket;
    QHostAddress senderAddress;
    quint16 senderPort;
    QString msg;

};

#endif // MAINWINDOW_H
