Bank tech test
=================

## Task

The task was to build a program that meets the following specification:

#### Requirements

* You should be able to interact with your code via a REPL like IRB or the JavaScript console.  (You don't need to implement a command line interface that takes input from STDIN.)
* Deposits, withdrawal.
* Account statement (date, amount, balance) printing.
* Data can be kept in memory (it doesn't need to be stored to a database or anything).

#### Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2012  
**And** a deposit of 2000 on 13-01-2012  
**And** a withdrawal of 500 on 14-01-2012  
**When** she prints her bank statement  
**Then** she would see

```
date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
```

### How to use:
This program has been built in Ruby and is run via IRB in a terminal.

- Clone this repo and navigate to the directory in your terminal
- Run `irb`
- Require the bank_account file
    `require './lib/bank_account'`
```
2.7.0 :001 > require './lib/bank_account'
 => true
```

#### Create an account
```
2.7.0 :002 > account = BankAccount.new
```

#### Make a deposit
```
2.7.0 :005 > account.deposit(1000)
 => #<Transaction:0x00007fa997b15d30 @type=:credit, @amount=1000, @datetime=2020-11-03 12:37:14.222086 +0000>
```

#### Make a withdrawal
```
2.7.0 :006 > account.withdraw(300)
 => #<Transaction:0x00007fa997ad74b8 @type=:debit, @amount=300, @datetime=2020-11-03 12:37:41.188815 +0000>
```

#### Print your statement

```
2.7.0 :007 > account.print_statement
date || credit || debit || balance
03/11/2020 || || 300.00 || 700.00
03/11/2020 || 1000.00 || || 1000.00
 => nil
```
##### Statement customisation
**Date format**  
The default date format is dd/mm/yyyy, however you can choose to use mm/dd/yyyy by  
specifying a date_format of ':mm_dd'  
 `account.print_statement(date_format: :mm_dd)`

### How to test:

As this program is written in Ruby, rspec has been used for the tests.  
Once you have cloned the repo:
- Navigate to the directory in your terminal
- Run `rspec`

Analysis and design
---------
**Analysis**
* Broke down the requirements to the following user stories. 
```
As an account holder
I want to be able to make a deposit of a specified amount
So that I can put money into my account for safe keeping

As a user
I want to be able to make a withdrawal of a specified amount
So that I can take money from my account when I need it

As a user
I want to be able to specify a transaction date in the past (canot be in the future)
So that I can manually backdate transactions that were missed

As a user
I want to print a statement of all transactions in my account
So that I can view the history of my deposits and withdrawals

As a user
I want my statement to show a running balance with each transaction
So that I can see what my account balance was at that time

As a user
I want my statement to print the transactions in reverse chronological order
So that I can easily follow the transactions when reading

As a user
I want all statements to have columns for date, credit, debit and balance
So that the format is standard regardless of the transactions

As a product owner
I want the option of printing a statement with the date format of mm/dd/yyyy
So that it's suitable for customers in other regions (e.g. American format)

As a product owner
I want to only allow amounts that are greater than 0 and up to 2 decimal places
So that the transaction data maintains integrity
```

* Assumption was made that an account has an overdraft and can go into a negative balance.
* I have used a datetime on the transaction rather than just date, so ordering will handle when multiple transactions  
are made in the same day.

**Design**

| Objects 	    | Messages             	                |
|------------   |------------------------------------   |
| BankAccount 	| deposit(amount, date(optional)) 	    |
|             	| withdraw(amount, date(optional))      |
|            	| print_statement(date_format(optional))| 	                    |
| Statement   	| initialize(transactions)              |
|              	| print                                 |
| Transaction   | initialize(type, amount, datetime)    |


