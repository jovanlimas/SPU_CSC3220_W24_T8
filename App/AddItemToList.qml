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
                    pageLoader.source = "Main.qml"
                }
            }
        }

        Column {
            spacing: 15
            leftPadding: 680
            topPadding: 140

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Select item")
            }

            ComboBox {
                id: itemName
                anchors.horizontalCenter: parent.horizontalCenter
                width: 200
                model: ItemOptions {}
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Item quantity")
            }

            TextField {
                id: quantity
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("ex: 1")
                validator: DoubleValidator {bottom: 0; top: 10000000;}
                focus: true
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Quantity Unit")
            }

            TextField {
                id: unit
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("ex: lbs")
            }

            MessageDialog {
                id: success
                buttons: MessageDialog.Ok
                text: "Item successfully added to list."
                visible: false
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Add to list")
                highlighted: true
                onClicked: {
                    DB.dbAddItemToList(quantity.displayText, unit.displayText, itemName.displayText)
                    success.open()
                }
            }
        }
    }
}
