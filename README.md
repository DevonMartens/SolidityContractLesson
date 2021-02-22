# Solidity Contract Lesson

![Etherum](https://github.com/DevonMartens/SolidityContractLesson/blob/main/Photo/etherum.jpg?raw=true)

This a lesson on writing a smart contract in Solidity. In order to understand smart contracts, you first need to know what the Ethereum blockchain is and how it works. It does not have a centralized source like a cloud platform such as Google Cloud or Amazon Web Services would. Developers run Ethereum on their machines and are paid in cryptocurrencies called ether. A cryptocurrency is essentially a digital asset. The ledger that tracks these assets is the Ethereum blockchain (there are other types of blockchain that also serve as ledgers for cryptocurrencies). The Ethereum blockchain is the database that tracks what is owed, stored, and runs smart contracts.

Developers who run the Ethereum blockchain on their machine for ether are called miners. Gas is the cost necessary to perform transactions on the network based on the amount of memory your contract uses. Miners who use their computer to run the Ethereum Blockchain (virual machine) set these costs based on supply and demand. The network that all these computers are running on to mine is the Ethereum virtual machine. That is the network that the Ethereum Blockchain runs on. It is in your best interest to ensure that your program uses the least amount of memory and data to save money, or gas.

A contract that runs on the Ethereum blockchain automatically executes when all the conditions are met. Since, digital assets can be transfer and contracts can be written this is valueable because it eliminates the need for a lawyer to write a contract and a bank to transfer money. 

# Challenge Instructions

You are a developer, creating a contract that is monitoring stock exchanges for a corporate client, your code will need the following:
 
•	A share to be exchanged.
•	A transaction to occur.
•	A count for each transaction and assets. Don’t lose track of money here!  
•	Track each new stock or share of stock added and update the blockchain network accordingly each time a transaction happens, a new type stock is added, or the quantity of the stock shares and price change. Remember the events and emit.  	

•	Your boss asked that this contract ensures that a transaction won’t occur if there are not enough shares of the requested stock in the network. She also does not want to lose business if the transaction is able to partially execute.

 Logistics:
•	We will need to reference list of list assets and transactions throughout this process.
•	A way to check for the correct stock in our program (something to reference the our shares id). A comparing function!
•	A function to change the count of the transaction and assets.
 
The starter code in the starter_code folder can be downloaded or copied. Each portion of the activity is broken down into parts(i.e. functions, structs, ect). There are more comments early on in the code than later. This is to avoid repetition. These comments are hints, and there are more hints in each step. Good luck! 


# What's in the repository 
In the Solution Folder there is a written smart contract.

If you want to try it on your own first there is a starter code file and instructions in the starter code on what to do. 

In the lesson folder there is a guide to writing in solidity which talks about syntax, the Ethereum blockchain is better explained there as well, and the solution at the end of the lesson is explained step by step.

# Key take aways from this Lesson:

1.	Why blockchain developers are so valuable
2.	Ethereum blockchain fundamentals
   	How the Network works
 	Mining and what it is
	Gas
    Ether
3.	Smart Contracts and how they work!
4.	Solidity fundamentals including:
  	Declare the version of Solidity for the compiler to use with pragma.
   	Create a contract.
   	Events (declare and emit)
   	Functions
   	Variables
   	Returns
   	If/else statements
   	For loops
   	Mapping
5.	The remix IDE
   	How to write/compile a contract on remix
![Etherum](https://101blockchains.com/wp-content/uploads/2018/07/The_Future_Of_Smart_Contracts.jpg)
# The next lesson will be about:
In our next lesson we will learn how to deploy contracts and create and use real addresses for contracts on the Ethereum network.



