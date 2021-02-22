pragma solidity ^0.8.1;

contract StockExchange {
    
    struct Share {
        address creator;
        bytes6 id;  // 6 bytes string
        int price;
        int quantity;
    }
    // The transaction structure
    struct Transaction {
        bytes6 buyer; // 6 bytes string
        bytes6 seller; // 6 bytes string
        int quantity;
        int price;
        uint256 timestamp;
        int8 state; // 0:PENDING / 1:VALIDATED / 2:REJECTED
    }
    // shares counted/transaction count
    int transaction_count;
    int share_count;

    // map to struct
    mapping (int => Transaction) transactions;
    mapping (int => Share) shares;


    // compare 6 bytes string
    function compareStrings(bytes6 a, bytes6 b) internal pure returns (bool) {
        for (uint i = 0; i < 6; i ++) {
            if (a[i] != b[i]) {
                return false;
            }
        }
        return true;
    }
    // events stored in blockchain
    event ShareJoined(address indexed share_address, int index, bytes6 id, int quantity, int price, uint256 timestamp);
    event TransactionExecuted(address indexed buyer_address, int buyer_share_index, int seller_share_index, bytes6 buyer, 
    bytes6 seller, int quantity, int price, uint256 timestamp, int8 state);
    event ShareUpdated(address indexed share_address, int index, bytes6 id, int quantity, int price, uint256 timestamp);

    // Gets an share index in the mapping by id
    function getShareIndex(bytes6 _id) public view returns (int index) {
        for (int i = 1; i <= share_count; i++) {
            if(compareStrings(shares[i].id, _id) == true)
                return i;
        } 
        return -1;
    }
    

    // Gets shares count
    function getSharesCount() public view  returns (int uid) {
        return share_count;
    }
    // Gets transactions count
    function getTransactionsCount() public view  returns (int uid) {
        return transaction_count;
    }  
    
        // Registers a share into the shares list in the events/sends to sender
    function register(bytes6 _id, int _quantity, int _price) public payable returns (bool success) {
        int share_index = getShareIndex(_id);
        if(share_index == -1){
            share_count = share_count + 1;
            Share memory _share = Share(msg.sender, _id, _price, _quantity); 
            shares[share_count] = _share;
            emit ShareJoined(msg.sender,share_count,  _id, _quantity, _price, block.timestamp);
        } else {
            shares[share_index].quantity = _quantity; 
            shares[share_index].price = _price;
            emit ShareUpdated(msg.sender, share_index, _id, _quantity, _price, block.timestamp);
        }

        return true;
    }    
   
    // Gets an share by index in the list 
    function getShareByIndex(int i) public view returns (bytes6 id, int price, int quantity) {
        if(i >= 1 && i <= share_count)
            return (shares[i].id, shares[i].price, shares[i].quantity);
        else
            return ("DEVONM",-1,-1);
    }
    // Gets an share by id (string)
    function getShare(bytes6 _id) public view returns (bytes6 id, int price, int quantity) {
        for (int i = 1; i <= share_count; i++) {
            if(compareStrings(shares[i].id, _id) == true)
                return (shares[i].id, shares[i].price, shares[i].quantity);
        } 
        return ("DEVONM",-1,-1);
    }
    // executes a transaction where buyer buys from seller a certain quantity

    //Here a function is declared the  buyer, seller, quantity are parameters public is the visability
    function transact(bytes6 buyer, bytes6 seller, int quantity)  public payable returns (bool success) {
    //if there is no seller or buyer retun false    
        int si = getShareIndex(buyer);
        int ti = getShareIndex(seller);
        if(si == -1 || ti == -1) {
            return false;
        }
        else {
        //add a new transaction to the transaction count     
            transaction_count = transaction_count + 1;
            Transaction memory _t = Transaction(shares[si].id, shares[ti].id, quantity, shares[ti].price, block.timestamp, 0); 
            transactions[transaction_count] = _t;
        //emits if there are enough stock and update the shares accodingly 
            if((shares[ti].quantity - quantity) >= 0) { // validate transaction
                shares[ti].quantity -= quantity;
                transactions[transaction_count].state = 1;
                emit TransactionExecuted(msg.sender,si,ti, transactions[transaction_count].buyer, transactions[transaction_count].seller, transactions[transaction_count].quantity, transactions[transaction_count].price, transactions[transaction_count].timestamp, transactions[transaction_count].state);
                emit ShareUpdated(shares[ti].creator, ti, shares[ti].id, shares[ti].quantity, shares[ti].price, block.timestamp);
            }
            else if(shares[ti].quantity > 0) { // validate partial transaction 
                transactions[transaction_count].state = 1;
                transactions[transaction_count].quantity = shares[ti].quantity;
                emit TransactionExecuted(msg.sender, si, ti, transactions[transaction_count].buyer, transactions[transaction_count].seller, transactions[transaction_count].quantity, transactions[transaction_count].price, transactions[transaction_count].timestamp, transactions[transaction_count].state);

                // create the rejected transaction
                transaction_count = transaction_count + 1;
                Transaction memory _t1 = Transaction(shares[si].id, shares[ti].id, quantity - shares[ti].quantity, shares[ti].price, block.timestamp, 0); 
                transactions[transaction_count] = _t1;
                shares[ti].quantity = 0;
                transactions[transaction_count].state = 2;
                emit TransactionExecuted(msg.sender, si, ti, transactions[transaction_count].buyer, transactions[transaction_count].seller, transactions[transaction_count].quantity, transactions[transaction_count].price, transactions[transaction_count].timestamp, transactions[transaction_count].state);
                emit ShareUpdated(shares[ti].creator, ti, shares[ti].id, shares[ti].quantity, shares[ti].price, block.timestamp);
            }
            else {
                transactions[transaction_count].state = 2;
                emit TransactionExecuted(msg.sender, si, ti, transactions[transaction_count].buyer, transactions[transaction_count].seller, transactions[transaction_count].quantity, transactions[transaction_count].price, transactions[transaction_count].timestamp, transactions[transaction_count].state);
            }
        }
        return true;   
    }
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