import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.LocalStorage
import QtQuick.Dialogs
import "Database.js" as DB

// pragma ComponentBehavior: Bound

ApplicationWindow {
    visible: true
    width: 840
    height: 700
    title: qsTr("Grocery List Manager")

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: homepage
    }

    Page {
        id: homepage
        property StackView stack: null

        Loader { id: pageLoader }

        GridLayout {
            flow: GridLayout.TopToBottom
            columns: 3
            rows: 1

            Column {
                ListView {
                    id: mainList
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    width: 250; height: 500
                    leftMargin: 40
                    topMargin: 40
                    spacing: 10
                    model: List {}
                    delegate: listDelegate
                }
            }

            Component {
                id: listDelegate
                Row {
                    Text {
                        text: itemName + ", Quantity: " + quantity + " " + unit + ", Checked: " + checked
                    }
                }

            }

            Column {
                topPadding: 200
                leftPadding: 40

                MessageDialog {
                    id: clearItemsDialog
                    text: "You have cleared everything."
                    buttons: MessageDialog.Ok
                    visible: false
                    onButtonClicked: pageLoader.source = "Main.qml"
                }

                Button {
                    text: qsTr("CAUTION! Clear All Data")
                    highlighted: true
                    onClicked: {
                        DB.dbDeleteItems()
                        DB.dbDeleteLineItems()
                        clearItemsDialog.open()
                    }
                }

                MessageDialog {
                    id: clearLineItemsDialog
                    text: "You have cleared line items."
                    buttons: MessageDialog.Ok
                    visible: false
                    onButtonClicked: pageLoader.source = "Main.qml"
                }

                Button {
                    text: qsTr("Clear Line Items")
                    highlighted: true
                    onClicked: {
                        DB.dbDeleteLineItems()
                        clearLineItemsDialog.open()
                    }
                }
            }

            Column {
                topPadding: 200
                leftPadding: 100
                Button {
                    text: qsTr("Add New Item")
                    // anchors { horizontalCenter: parent.horizontalCenter}
                    onClicked: {
                        addNewItem.visible = true;
                        addNewItem.stack = stackView;
                        stackView.push(addNewItem)
                    }
                }
                Button {
                    text: qsTr("Add Item to List")
                    // anchors { horizontalCenter: parent.horizontalCenter}
                    onClicked: {
                        addItemToList.visible = true;
                        addItemToList.stack = stackView;
                        stackView.push(addItemToList)
                        pageLoader.source = "ItemOptions.qml"
                    }
                }

                Button {
                    text: qsTr("Quit Application")
                    highlighted: true
                    onClicked: {
                        Qt.quit()
                    }
                }
            }
        }
    }

    AddNewItem {
        id: addNewItem
        visible: false
    }

    AddItemToList {
        id: addItemToList
        visible: false
    }

    Component.onCompleted: {
        DB.dbInit()
        DB.dbGenerateUser()
        DB.dbGenerateGroceryList()
    }
}
