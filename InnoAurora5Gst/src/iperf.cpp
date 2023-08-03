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
    QString program = "/usr/share/ru.auroraos.InnoAurora5Gst/bin/iperf";
    QStringList arguments = m_args.split(" ");
    QProcess proc;
    proc.start(program, arguments);
    proc.waitForFinished();
    QString out_text = "stdout:\n"+proc.readAllStandardOutput();
    out_text += "\n\nstderr:\n"+proc.readAllStandardError();

    qDebug()<<"start"<<program<<"with args:"<<arguments;
    qDebug()<<"output"<<out_text;

    m_output = "start: '" + program + " " + arguments.join(" ") + "'";
    m_output += "\noutput:'"+out_text+"'";

    emit iperfFinished(true);
}
