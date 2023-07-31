#include "iperf.h"
#include <QDebug>
#include <QProcess>

Iperf::Iperf(QObject *parent)
    : QObject(parent)
{
    qDebug() << "\n~~~\nCreate Iperf instance\n~~~\n";
}


const QString &Iperf::args() const
{
    return m_args;
}

void Iperf::setArgs(const QString &newArgs)
{
    if (m_args == newArgs)
        return;
    m_args = newArgs;
    emit argsChanged();
}

const QString &Iperf::output() const
{
    return m_output;
}

void Iperf::startIperf()
{
    if (m_args.isEmpty()) {
        qDebug()<<"arguments are empty";
        m_output = "arguments are empty";
        emit iperfFinished(false);
        return;
    }

    // Execute iperf
    QString program = "iperf";
    QStringList arguments = m_args.split(" ");
    qDebug()<<"start"<<program<<"with args:"<<arguments<<"(TODO)";
    m_output = "start: '" + program + " " + arguments.join(" ") + "'";
//    QProcess *proc = new QProcess;
//    proc->start(program, arguments);
//    proc->waitForFinished();
//    delete proc;
    emit iperfFinished(true);
}
