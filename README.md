# Quick Mart

## Description
This is an OOP executable application that create a solution for the Jerry's Quick Mart excersice. 

## Jerry's Problem
Jerry requires the following functionalities:
- Select whether costumer is a Rewards Member or Regular customer.
- Add items to cart.
- Remove individual items from cart, with empty cart option.
- View cart
- Checkout and print receipt
- Cancel transaction
  
Inventory should be pass into the application in a text fil, with the item information on each line. The receipt should be printed as a .txt file, with the transaction number and date included in the file name. Inventory should be updated after checkout.

## Solution
According with the Jerry's problem the app was developed considering all of the specified requirements.

As assumption the app requires an inventory.txt file to be initialized.
To start the aplication the inventory.txt file should be placed in the `data folder`, the app already has an inventory.txt file and should be replaced for another with the same name.

Once the app runs an initial Menu is presented in the console. To select an option, the user should tipe eather the number or the name according with the displayed message.

- A user can select start transaction or exit app.
- If a transaction is selected, a user should select a costumer status (The costumer status define the unit price for an item).
- A menu with options is displayed:
  - A user can choose Add item to cart, Remove item from cart, View cart, Checkout and Print Receipt, and cancel transaction.
- For the `add item to cart option`, a user can choose select an item from a list or add item with name.
  - For the `choose item from list`, a user should introduce the number of the item in the list and the quantity he wants to add.
  - For the `add item with name`, a user should introduce the name of the item and the quantity he wants to add (The item should be present in the inventory).
- For the `remove item from cart option`, a user can choose remove individual item or remove all items.
  - For the `remove individual item, a user can introduce the number of the item in a displayed list he wants to remove.
  - The `remove all items` remove all items  form the cart.
- When a user selects the `View cart` option, information about the transaction is displayed including totals.
- For the `checkout and print receipt`option, a user starts the ending of the transaction and should introduce the cash amoutn is receiving, the change amount is displayed and the receipt is generated as .txt file whit the transaction information. The transaction number and date included is included in the file name, the receipt file appears in the root folder. The inventory and the transaction number are updated as well.
- The `cancel transaction`option ends the transaction and returns the main menu.

As a consideration for future features implementations:
- The app interface could let to users add, remove, and edit items to the inventory.
- The app could create a transactions history.
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
- Twitter: [@ReveloJ](https://twitter.com/ReveloJ)
- LinkedIn: [Jorge Ríos](https://www.linkedin.com/in/jorgeriosr/) 


## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Alexr16/Quick-mart/issues).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](./LICENSE) licensed.