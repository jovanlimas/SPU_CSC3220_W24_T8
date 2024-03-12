import QtQuick
import QtQuick.LocalStorage
import "Database.js" as DB

ListModel {
    id: listModel
    Component.onCompleted: DB.dbReadAll()
}
