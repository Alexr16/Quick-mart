# Quick Mart

## Description
This is an OOP executable application that creates a solution for Jerry's Quick Mart exercise. 

## Jerry's Problem
Jerry requires the following functionalities:
- Select whether the customer is a Rewards Member or a Regular customer.
- Add items to the cart.
- Remove individual items from the cart, with the empty cart option.
- View cart
- Checkout and print receipt
- Cancel transaction
  
Inventory should be passed into the application in a text file, with the item information on each line. The receipt should be printed as a .txt file, with the transaction number and date included in the file name. The inventory should be updated after checkout.

## Solution
According to Jerry's problem, the app was developed considering all of the specified requirements.

As an assumption, the app requires an inventory.txt file to be initialized.
To start the application the inventory.txt file should be placed in the `data folder`, the app already has an inventory.txt file and should be replaced with another with the same name.

Once the app runs an initial Menu is presented in the console. To select an option, the user should type either the number or the name according to the displayed message.

- A user can select start transaction or exit app.
- If a transaction is selected, a user should choose a customer status (The customer status defines the unit price for an item).
- A menu with options is displayed:
  - A user can choose to Add an item to the cart, Remove the item from the cart, View the cart, Checkout, and Print Receipt, and cancel the transaction.
- For the `add item to cart option`, a user can choose to select an item from a list or add an item by name.
  - For the `choose item from list`, a user should introduce the number of the item in the list and the quantity he wants to add.
  - For the `add item with name`, a user should introduce the name of the item and the quantity he wants to add (The item should be present in the inventory).
- For the `remove item from cart option`, a user can choose to remove the individual item or remove all items.
  - For the `remove individual item`, a user can introduce the number of the item in a displayed list he wants to remove.
  - The `remove all items` remove all items from the cart.
- When a user selects the `View cart` option, information about the transaction is displayed including totals.
- For the `checkout and print receipt` option, a user starts the ending of the transaction and should introduce the cash amount is receiving, the change amount is displayed and the receipt is generated as .txt file whit the transaction information. The transaction number and date included are included in the file name, and the receipt file appears in the root folder. The inventory and the transaction number are updated as well.
- The `cancel transaction` option ends the transaction and returns to the main menu.

As consideration for future features implementations:
- The app interface could let to users add, remove, and edit items to the inventory.
- The app could create a transaction history.
- The remove items might present an option for removing items by quantity.
- The app could let to users introduce customer information and save it for history.

## Built With

- Ruby

### Prerequisites

You must have Ruby installed in your computer.

## Getting Started

Use the following steps to run this Project locally:

1. Clone the repository

2. Open the terminal

3. Run this command:
```bash
  git clone git@github.com:Alexr16/Quick-mart.git
```

4. Enter in to the folder:
```bash
  cd Quick-mart
```

5. Open the folder with a code editor (VS Code preferred)

6. Run

```bash
  ruby main.rb
```

7. Enjoy 😎

## Run Tests

- Run this command in your terminal
`gem install rspec`

- Run Rspec tests
`rspec tests`

## Author

👤 **George Rios**

- GitHub: [@Alexr16](https://github.com/Alexr16)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Alexr16/Quick-mart/issues).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](./LICENSE) licensed.
