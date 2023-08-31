/*******************************************************************************
**
** Copyright (C) 2022 ru.auroraos
**
** This file is part of the My Aurora OS Application project.
**
** Redistribution and use in source and binary forms,
** with or without modification, are permitted provided
** that the following conditions are met:
**
** * Redistributions of source code must retain the above copyright notice,
**   this list of conditions and the following disclaimer.
** * Redistributions in binary form must reproduce the above copyright notice,
**   this list of conditions and the following disclaimer
**   in the documentation and/or other materials provided with the distribution.
** * Neither the name of the copyright holder nor the names of its contributors
**   may be used to endorse or promote products derived from this software
**   without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
** AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
** THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
** FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
** IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
** FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
** OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
** PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS;
** OR BUSINESS INTERRUPTION)
** HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
** WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE)
** ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
** EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
*******************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.Layouts 1.1
import iperf 1.0

Page {
    id: root
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    PageHeader {
        id: _pageheader
        objectName: "pageHeader"
        title: qsTr("Speed test")
        extraContent.children: [
                IconButton {
                    objectName: "aboutButton"
                    icon.source: "image://theme/icon-m-developer-mode"
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                }
            ]

    }

    ColumnLayout {
        id: _col
        anchors.top: _pageheader.bottom
        anchors.bottom: root.bottom
        anchors.left: root.left
        anchors.right: root.right
        width: root.width

        spacing: 20
        anchors.margins: 20

        RowLayout {
            id: _textfields
            width: parent.width

            TextField {
                id: _somefield
                font.pixelSize: Theme.fontSizeSmall
                text: "$ iperf"
                readOnly: true
//                Layout.alignment: Qt.AlignLeft
                Layout.fillWidth: true
//                width: 10
            }

            TextField {
                id: arguments
//                anchors.left: _somefield.right
                placeholderText: "-c 5gst.ru -p 5555"
                inputMethodHints: Qt.ImhUrlCharactersOnly
                onTextChanged: {console.log("Change args"); iperf.args = text;}
                Layout.fillWidth: true
            }
        }

        RowLayout {
            id: _buttonsrow
            anchors.left: _col.left
            anchors.right: _col.right
            width: _col.width
            spacing: 80

            Button {
                id: startbutton
                text: "Clean"
                onClicked: {console.log("Clean"); iperf.cleanIperf();}

            }
            Button {
                id: cleanbutton
                text: "Start"
                onClicked: {console.log("Start"); iperf.startIperf();}

            }
        }


        Item{
            id: _console
            width: parent.width
            Layout.fillHeight: true

            Rectangle{
                height: _console.height
                width: parent.width
                border.width: 2
                radius: 10
                opacity: 0.2
                color: palette.secondaryColor
            }
            SilicaFlickable {
                anchors.margins: 20
                anchors.fill: _console
                contentWidth: iperfOutput.width; contentHeight: iperfOutput.height
                clip: true

                TextEdit {
                    id: iperfOutput
                    text: "iperf output...\n"
                    color: palette.primaryColor
                    readOnly: true

                }
                VerticalScrollDecorator {}
            }
        }
    }

    Iperf{
        id: iperf
        onOutputChanged: {
            iperfOutput.text = output
        }
    }

}
