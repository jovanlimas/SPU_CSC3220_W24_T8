-- One SELECT statement that joins two tables and limits the result set using the WHERE clause.
SELECT GroceryList.UserID, LineItem.ItemID, LineItem.Quantity, LineItem.Unit, LineItem.LineNum
FROM LineItem
JOIN GroceryList ON GroceryList.GroceryListID = LineItem.GroceryListID
WHERE LineItem.GroceryListID = 1

-- One UPDATE statement that updates at least two columns in at least two rows.
UPDATE LineItem
SET Quantity = 2, Checked = 1
WHERE ItemID = 100 or ItemID = 101