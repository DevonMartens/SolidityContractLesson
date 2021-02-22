// add pragma to specify Solidity version
pragma solidity ^0.8.1;
//Name the contract it begins here
contract StockExchange {
/* the share it is safe to say that we will need a quantity/price and address to be sent and
an identifier (struct)*/  
    struct Share {
        address creator;
        bytes6 id;  // 6 bytes string
        int price;
        int quantity;
    }
    // Ton DO: create struct for transaction struct begins here
  	/* a transaction needs a price/quantity also, we should track when it occurred, if it was successful
  	and the buyer and seller*/
   
	
    // let's use int or numbers to count our transactions and shares (create variables)
  
	// mapping for each struct so we can access our transaction and shares
 
//TO DO: write your first function
 
/*Your first function! The function is declared with the word function it passes in two strings as parameters a & b.
This function is pure which ensures it does not modify the state or the strings that are passed into it in the future
The word internal means that this function can only be accessed within the contract.  We are returning a true or false or a
bool */
 
    	//TO DO: add a for loop to your function
 
    	/* The for loop has 3 arguments. They are separated by a ;
    	1. The first is the starting value the unsigned int is = to 0.
    	2. the second (i < 6) is a test statement. Until this is no longer true the loop will execute
    	3. the final statement is adding 1 to i with ++ which starts at 0. The loop will execute 6 times.
    	One for each of the previously declared bytes */
 
    	/* the if statement will check if a is not equal to b with the != operator. The index(or total string) of
    	a and b is passed in with [i] and will return false*/
         
 
       //otherwise it will return true
    
 	//TO: add events here. 3 of them with parameters passed in including address index(es) price quantity timestamp
 	//buyer seller if applicable
 
  /* TO DO: Write a function that gets an asset index in the mapping by id
  -the function will be public is used because we are storing some of this into block chain
  -View is used here because it does not modify the state*/
  
 	//TO DO: write a for loop that references asset count. I starts at 1 rather than the zero index      
     
 	//TO: add an if statement to check the id and if it is correct return the inedec
         
 	//If it is not return -1 for false this ends the function
   
 
	// TO DO: write a function that returns assets count
 
	//TO DO: write a function that returns
   
   //TO DO: write a function that registers an asset into the assets list
 
   /* This function registers an asset into the assets list(it is payable because it allows ether to be added to the network)
   it is public because we need to access blockchain and modify the available assets.
   if else statement will be sucheck if this a new asset or if we are updating an assets price and quantity. We are emitting the
   events for either case with the emit statement.
   */
 
    	//get the real number using asset_count
          
    	//the memory keyword is used here because this is not being saved to blockchain
        
    	//count
  	   
    	//update blockchain with all in. msg.sender represents the address of the current user
         
    	//if we already have that id in place we will change the quantity and price   
         
        
	// TO DO: write a function that gets an asset by index in the list
  
	//TO DO: Gets an asset by id (string)
 
 
 
	//TO DO: write a function is declared the  source, target, quantity are parameters public is the visibility
  
    	//if there is no target or source return false   
       
    	//else
    
    	//add a new transaction to the transaction count    
         
    	//if statement emits if there are enough stock and update the shares accordingly
            	// validate transaction
            	//set a new quantity
             
            	//tell the count this worked
               
            	//update logs with transaction and share information
              
        	// validate partial transaction  where only some of the stocks wanted were sold- still a transaction and the remainder is rejected
           
            	// create the rejected transaction
               
               
        	//otherwise the transaction is rejected but still executed
         
    	//return true
    
 
    // Get transaction by index
    function getTransactionByIndex(int i) public view
        returns (bytes6 buyer, bytes6 seller, int quantity, int price, uint256 timestamp, int8 state ) {
       if  (i >= 1 && i <= transaction_count)
           return (transactions[i].buyer, transactions[i].seller,
            	 transactions[i].quantity, transactions[i].price, transactions[i].timestamp, transactions[i].state);
           else
        	return ("DEVONM", "DEVONM",-1,-1, 0, 2);
	}   
    // Get the next transaction index involving an share
    function getNextTransactionIdInvolvingShare(bytes6 id, int start) public view  returns (int) {
    	if (start < 1 || start > transaction_count)
        	    return -1;
           
    	for (int i = start; i <= transaction_count; i++) {
        	    if (compareStrings(transactions[i].buyer, id) == true || compareStrings(transactions[i].seller, id))
       	         return i;
    	}
    	return -1;
	}
}