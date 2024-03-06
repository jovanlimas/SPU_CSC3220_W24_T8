import QtQuick
import QtQuick.LocalStorage
import "Database.js" as DB

// dummy list for UI work
// ListModel {
//     ListElement {
//         name: "Bill Smith"
//         number: "555 3264"
//     }
//     ListElement {
//         name: "John Brown"
//         number: "555 8426"
//     }
//     ListElement {
//         name: "Sam Wise"
//         number: "555 0473"
//     }
// }

ListModel {
    id: itemOptions
    Component.onCompleted: {
        console.log("ItemOptionsLoaded")
        DB.dbReadAllItems()
    }
}