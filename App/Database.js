function dbInit()
{
    let db = LocalStorage.openDatabaseSync("GroceryList_DB", "", "GroceryListManager", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS GroceryList ( GroceryListID INTEGER, UserID        INTEGER REFERENCES User (UserID), PRIMARY KEY ( GroceryListID ), FOREIGN KEY ( UserID ) REFERENCES User (UserID) );')
            tx.executeSql('CREATE TABLE IF NOT EXISTS Item ( ItemID   INTEGER, ItemName TEXT    NOT NULL, PRIMARY KEY ( ItemID ) );')
            tx.executeSql('CREATE TABLE IF NOT EXISTS LineItem ( GroceryListID INTEGER, LineNum       INTEGER, Quantity      INTEGER, Unit          TEXT, Checked       INTEGER DEFAULT (0), ItemID        INTEGER, PRIMARY KEY ( GroceryListID, LineNum ), FOREIGN KEY ( ItemID ) REFERENCES Item (ItemID), FOREIGN KEY ( GroceryListID ) REFERENCES GroceryList (GroceryListID)  );')
            tx.executeSql('CREATE TABLE IF NOT EXISTS User ( UserID   INTEGER, Username TEXT    NOT NULL, PRIMARY KEY ( UserID ) );')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("GroceryList_DB", "", "GroceryListManager", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbInsertItem(ItemID, ItemName)
{
    let db = dbGetHandle()
    let rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT or IGNORE INTO Item VALUES(?, ?)',
                      [ItemID, ItemName])
        let result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

function dbInsertLineItem(GroceryListID, LineNum, Quantity, Unit, Checked, ItemID)
{
    let db = dbGetHandle()
    let rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO LineItem VALUES(?, ?, ?, ?, ?, ?)',
                      [GroceryListID, LineNum, Quantity, Unit, Checked, ItemID])
        let result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    console.log("Added item to list")

    return rowid;
}

// helper function to dbInsertLineItem
function dbAddItemToList(Quantity, Unit, ItemName)
{
    let db = dbGetHandle()
    let rowid = 0;
    let ItemID;
    let results;

    db.transaction(function (tx) {
        ItemID = tx.executeSql('SELECT ItemID FROM Item WHERE ItemName = ?', [ItemName])
        results = tx.executeSql('SELECT Quantity, Unit, Checked, ItemID FROM LineItem')
    })

    let lineNum = results.rows.length + 1

    dbInsertLineItem(1, lineNum, Quantity, Unit, 0, ItemID.rows.item(0).ItemID)
}

function dbInsertUser(UserID, Username)
{
    let db = dbGetHandle()
    let rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT or IGNORE INTO User VALUES(?, ?)',
                      [UserID, Username])
        let result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

function dbInsertGroceryList(GroceryListID, UserID)
{
    let db = dbGetHandle()
    let rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT or IGNORE INTO GroceryList VALUES(?, ?)',
                      [GroceryListID, UserID])
        let result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

// default User
function dbGenerateUser() {
    dbInsertUser(1, "John Doe")
}

// default GroceryList
function dbGenerateGroceryList() {
    dbInsertGroceryList(1, 1)
}

function dbReadAll()
{
    let db = dbGetHandle()

    db.transaction(function (tx) {
        let results = tx.executeSql('SELECT Quantity, Unit, Checked, ItemID FROM LineItem')
        let itemName;

        for (let i = 0; i < results.rows.length; i++) {
            itemName = tx.executeSql('SELECT ItemName from Item WHERE ItemID = ?', [results.rows.item(i).ItemID])

            console.log("LineItem size: " + results.rows.length)
            console.log(results.rows.item(i).ItemID)
            console.log(itemName.rows.item(0).ItemName)
            console.log(results.rows.item(i).Quantity)
            console.log(results.rows.item(i).Unit)
            console.log(results.rows.item(i).Checked)

            listModel.append({
                itemName: itemName.rows.item(0).ItemName,
                quantity: results.rows.item(i).Quantity,
                unit: results.rows.item(i).Unit,
                checked: results.rows.item(i).Checked
            })
        }
    })
}

function dbReadAllItems()
{
    let db = dbGetHandle()
    db.transaction(function (tx) {
        let results = tx.executeSql('SELECT ItemName FROM Item')
        for (let i = 0; i < results.rows.length; i++) {        
            itemOptions.append({
                itemName: results.rows.item(i).ItemName,
            })
        }
    })
}

function dbDeleteItems()
{
    let db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('DELETE from Item;')
    })
    console.log("All Items deleted.")
}

function dbDeleteLineItems()
{
    let db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('DELETE from LineItem;')
    })
    console.log("All Line Items deleted.")
}

// TODO
function dbUpdate(Pdate, Pdesc, Pdistance, Prowid)
{
    let db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql(
                    'update trip_log set date=?, trip_desc=?, distance=? where rowid = ?', [Pdate, Pdesc, Pdistance, Prowid])
    })
}

// TODO
function dbDeleteRow(Prowid)
{
    let db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('delete from trip_log where rowid = ?', [Prowid])
    })
}
