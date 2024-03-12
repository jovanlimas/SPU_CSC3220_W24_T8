import QtQuick
import QtQuick.LocalStorage
import "Database.js" as DB

ListModel {
    id: itemOptions
    Component.onCompleted: {
        console.log("ItemOptionsLoaded")
        DB.dbReadAllItems()
    }
}
