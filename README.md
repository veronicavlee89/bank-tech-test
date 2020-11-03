Bank tech test
=================

##Task

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

As an account holder
I want to be able to make a withdrawal of a specified amount
So that I can take money from my account when I need it

As an account holder
I want to print a statement of all transactions in my account
So that I can view the history of my deposits and withdrawals

As an account holder
I want my statement to show a running balance with each transaction
So that I can see what my account balance was at that time

As a product owner
I want to only allow amounts that are greater than 0 and up to 2 decimal places
So that the transaction data maintains integrity

As a product owner
I want all statements to have columns for date, credit, debit and balance
So that the format is standard regardless of the transactions
```

**Design**

| Objects 	    | Messages             	                |
|------------   |------------------------------------   |
| Bank account 	| deposit(amount) 	                    |
|             	| withdraw(amount)                      |
|            	| print_statement 	                    |
| Statement   	| initialize(transactions)              |
|              	| print                                 |
| Transaction   | initialize(type, amount, datetime)    |


