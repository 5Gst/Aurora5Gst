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

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    ColumnLayout {
        spacing: 20
        anchors.margins: 40
        anchors.fill: parent

        PageHeader {
            objectName: "pageHeader"
            title: qsTr("Speed test")
            extraContent.children: [
                IconButton {
                    objectName: "aboutButton"
                    icon.source: "image://theme/icon-m-about"
                    anchors.verticalCenter: parent.verticalCenter

                    onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                }
            ]
        }


        RowLayout {
            width: parent.width
            anchors.left: parent.left
            layoutDirection: Qt.LeftToRight
            spacing: -50 // IDK how to remove space between textfields, so I use this
            TextField {
                id: iperftext
                font.pixelSize: Theme.fontSizeSmall
                text: "$ iperf"
                readOnly: true
                Layout.preferredWidth: 160

            }
            TextField {
                id: arguments
                placeholderText: "-c 5gst.ru -p 5555"
                inputMethodHints: Qt.ImhUrlCharactersOnly
                Layout.fillWidth: true
            }
            Item {
                Layout.preferredWidth: 80
            }
            Button {
                id: startbutton
                anchors.right: parent.right
                width: 100
                text: "Start"
                onClicked: {console.log("Start"); iperfOutput.text=iperfOutput.text+"check\n";}
                Layout.preferredWidth: 100
            }
        }

        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle{
                anchors.fill: parent
                border.width: 2
                radius: 10
                opacity: 0.2
                color: palette.secondaryColor
            }
            SilicaFlickable {
                anchors.margins: 20
                anchors.fill: parent
                contentWidth: iperfOutput.width; contentHeight: iperfOutput.height
                clip: true

                TextEdit {
                    id: iperfOutput
                    text: "iperf output..."
                    color: palette.primaryColor
                    readOnly: true

                }
                VerticalScrollDecorator {}
            }
        }
    }
}
