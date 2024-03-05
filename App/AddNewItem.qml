import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    visible: true
    property StackView stack: null

    GridLayout {
        flow: GridLayout.TopToBottom
        columns: 2

        Column {
            Button {
                text: qsTr("Back")
                onClicked: stackView.pop()
            }
        }

        Column {
            spacing: 15
            leftPadding: 520
            topPadding: 150

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                id: title
                text: qsTr("Add a New Item")
            }

            TextField {
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Item name (ex: Orange Juice)")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Add")
                highlighted: true
            }
        }
    }
}
