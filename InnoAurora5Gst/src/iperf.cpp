#include "iperf.h"
#include <QDebug>
#include <QProcess>

Iperf::Iperf(QObject *parent): QObject(parent)
{
    qDebug() << "\n~~~\nCreate Iperf instance\n~~~\n";
    connect(&proc, SIGNAL(readyReadStandardOutput()), this, SLOT(writeText()));
    connect(&proc, SIGNAL(readyReadStandardError()), this, SLOT(writeText()));
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

void Iperf::writeText()
{
    QString out_text = proc.readAllStandardOutput() + "\n" + proc.readAllStandardError();
    qDebug()<<"writeText func" + out_text +"\n";

    m_output += out_text;
    emit outputChanged();
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
    /*
     * NOTE: it's expected that `%{_datadir}` in the .spec file is "/usr/share",
     * and the project's `%{name}` is "ru.auroraos.InnoAurora5Gst"; otherwise
     * the following line shall be updated.
     * TODO: could we automatically detect if that's not the case? Generate C macros from the spec?
     */
    QString program = "/usr/share/ru.auroraos.InnoAurora5Gst/bin/iperf";
    QStringList arguments = m_args.split(" ");


    proc.start(program, arguments);    
    qDebug()<<"start"<<program<<"with args:"<<arguments;
}

void Iperf::cleanIperf()
{
    m_output = "";
    qDebug()<<"clean func \n";
    emit outputChanged();
}
