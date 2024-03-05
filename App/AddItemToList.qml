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
            leftPadding: 440
            topPadding: 110

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Select item")
            }

            ComboBox {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 200
                model: [ "Banana", "Apple", "Coconut" ]
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Item quantity")
            }

            TextField {
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
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("ex: lbs")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Add to list")
                highlighted: true
            }
        }
    }
}
