import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 640
    height: 600
    title: qsTr("Grocery List Manager")

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: homepage
    }

    Page {
        id: homepage
        property StackView stack: null

        GridLayout {
            flow: GridLayout.TopToBottom
            columns: 3
            rows: 1

            Column {
                ListView {
                    width: 180; height: 200
                    spacing: 10
                    model: ContactModel {}
                    delegate: Text {
                        text: name + ": " + number
                    }
                }
            }

            Column {
                topPadding: 200
                leftPadding: 40
                Button {
                    text: qsTr("Refresh")


                }
                Button {
                    text: qsTr("Clear List")
                    highlighted: true
                }
            }

            Column {
                topPadding: 200
                leftPadding: 100
                Button {
                    text: qsTr("Add New Item")
                    anchors { horizontalCenter: parent.horizontalCenter}
                    onClicked: {
                        addNewItem.visible = true;
                        addNewItem.stack = stackView;
                        stackView.push(addNewItem)
                    }
                }
                Button {
                    text: qsTr("Add Item to List")
                    anchors { horizontalCenter: parent.horizontalCenter}
                    onClicked: {
                        addItemToList.visible = true;
                        addItemToList.stack = stackView;
                        stackView.push(addItemToList)
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
}
