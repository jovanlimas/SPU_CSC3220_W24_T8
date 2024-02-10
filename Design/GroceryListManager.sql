--
-- File generated with SQLiteStudio v3.4.4 on Fri Feb 9 17:46:18 2024
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: GroceryList
CREATE TABLE GroceryList (
    GroceryListID INTEGER,
    UserID        INTEGER REFERENCES User (UserID),
    PRIMARY KEY (
        GroceryListID
    ),
    FOREIGN KEY (
        UserID
    )
    REFERENCES User (UserID) 
);

INSERT INTO GroceryList (GroceryListID, UserID) VALUES (1, 1);
INSERT INTO GroceryList (GroceryListID, UserID) VALUES (2, 3);
INSERT INTO GroceryList (GroceryListID, UserID) VALUES (3, 3);
INSERT INTO GroceryList (GroceryListID, UserID) VALUES (4, 4);

-- Table: Item
CREATE TABLE Item (
    ItemID   INTEGER,
    ItemName TEXT    NOT NULL,
    PRIMARY KEY (
        ItemID
    )
);

INSERT INTO Item (ItemID, ItemName) VALUES (100, 'Milk');
INSERT INTO Item (ItemID, ItemName) VALUES (101, 'Pork Ribs');
INSERT INTO Item (ItemID, ItemName) VALUES (102, 'Beef Brisket');
INSERT INTO Item (ItemID, ItemName) VALUES (103, 'Shampoo');
INSERT INTO Item (ItemID, ItemName) VALUES (104, 'Chicken');

-- Table: LineItem
CREATE TABLE LineItem (
    GroceryListID INTEGER,
    LineNum       INTEGER,
    Quantity      INTEGER,
    Unit          TEXT,
    Checked       INTEGER DEFAULT (0),
    ItemID        INTEGER,
    PRIMARY KEY (
        GroceryListID,
        LineNum
    ),
    FOREIGN KEY (
        ItemID
    )
    REFERENCES Item (ItemID),
    FOREIGN KEY (
        GroceryListID
    )
    REFERENCES GroceryList (GroceryListID) 
);

INSERT INTO LineItem (GroceryListID, LineNum, Quantity, Unit, Checked, ItemID) VALUES (1, 2, 16, 'fl oz', 0, 101);
INSERT INTO LineItem (GroceryListID, LineNum, Quantity, Unit, Checked, ItemID) VALUES (1, 1, 3, 'gal', 0, 100);
INSERT INTO LineItem (GroceryListID, LineNum, Quantity, Unit, Checked, ItemID) VALUES (2, 1, 2, 'gal', 0, 100);

-- Table: User
CREATE TABLE User (
    UserID   INTEGER,
    Username TEXT    NOT NULL,
    PRIMARY KEY (
        UserID
    )
);

INSERT INTO User (UserID, Username) VALUES (1, 'Jovan Limas');
INSERT INTO User (UserID, Username) VALUES (2, 'Kainoa Aqui');
INSERT INTO User (UserID, Username) VALUES (3, 'Toby Smedes');
INSERT INTO User (UserID, Username) VALUES (4, 'Anthony Mao');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
