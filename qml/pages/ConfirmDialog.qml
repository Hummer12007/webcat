// Code parts borrowed from Jollas Sailfish-Browser Code

/****************************************************************************
** Original Author
** Copyright (C) 2013 Jolla Ltd.
** Contact: Raine Makelainen <raine.makelainen@jollamobile.com>
**
****************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: dialog
    allowedOrientations: mainWindow.firstPage.allowedOrientations
    property alias acceptText: header.acceptText
    property alias label: lbl.text
    default property alias defaultContent: promptContent.children

    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: contentColumn.height

        Column {
            id: contentColumn
            width: parent.width

            DialogHeader {
                id: header
            }

            Item {
                id: promptContent
                width: dialog.width
                height: Math.max(childrenRect.height, dialog.height - header.height) - Theme.paddingLarge * 2

                Label {
                    id: lbl
                    property bool largeFont: true

                    x: Theme.paddingLarge
                    width: parent.width - (2 * Theme.paddingLarge)
                    anchors {
                        top: parent.top
                        topMargin: !largeFont ? Theme.paddingLarge : Theme.itemSizeSmall
                    }
                    font.pixelSize: largeFont ? Theme.fontSizeExtraLarge : Theme.fontSizeMedium
                    color: Theme.highlightColor
                    text: qsTr("Accept ?")

                    onContentWidthChanged: {
                        // We want to get contentWidth text width only once. When wrapping
                        // goes enabled we get contentWidth that is less than width.
                        // Greater than ~ three liner will be rendered with smaller font.
                        if (contentWidth > width * 3 && wrapMode == Text.NoWrap) {
                            largeFont = false
                            wrapMode = Text.Wrap
                        } else if (contentWidth > width && wrapMode == Text.NoWrap) {
                            wrapMode = Text.Wrap
                        }
                    }
                }
            }
        }
    }
}
