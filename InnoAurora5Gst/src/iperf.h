#ifndef IPERF_H
#define IPERF_H

#include <QObject>
#include <QString>
#include <QProcess>

// Simple QML object to launch iperf.

class Iperf : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString args READ args WRITE setArgs NOTIFY argsChanged)
    Q_PROPERTY(QString output READ output NOTIFY outputChanged)

public:
    explicit Iperf(QObject *parent = nullptr);
    ~Iperf() = default;

    const QString &args() const;
    void setArgs(const QString &newArgs);

    const QString &output() const;

public slots:
    void startIperf();
    void cleanIperf();
    void writeText();
// TODO Write handler for error
//    void readyReadStandardError();
//    void readyReadStandardOutput();

signals:
    void argsChanged();
    void outputChanged();
    void iperfFinished(bool success);

private:

    QString m_args;
    QString m_output;
    QProcess proc;
};

#endif // IPERF_H
