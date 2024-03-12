import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.LocalStorage
import "Database.js" as DB

Page {
    visible: true
    property StackView stack: null

    Loader { id: pageLoader }

    GridLayout {
        flow: GridLayout.TopToBottom
        columns: 2

        Column {
            Button {
                text: qsTr("Back")
                onClicked: {
                    stackView.pop()
                    mainList.forceLayout()
                    pageLoader.source = "AddItemToList.qml"
                    pageLoader.source = "Main.qml"
                }
            }
        }

        Column {
            spacing: 15
            leftPadding: 720
            topPadding: 180

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                id: title
                text: qsTr("Add a New Item")
            }

            TextField {
                id: itemName
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Item name (ex: Orange Juice)")
            }

            MessageDialog {
                id: success
                buttons: MessageDialog.Ok
                text: "Item successfully added."
                visible: false
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Add")
                highlighted: true
                onClicked: {
                    DB.dbInsertItem(Math.floor(Math.random() * 1000), itemName.displayText)
                    success.open()
                    // pageLoader.source = "AddItemToList.qml"
                }
            }
        }
    }
}
