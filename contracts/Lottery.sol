pragma solidity ^0.4.17;

contract Lottery{
    address public manager;
    address[] public players;

    function Lottery() public{
        manager=msg.sender;
    }

    function enter() public payable{
        require(msg.value>.01 ether);               //Default value is ether. We need to write it this way
        players.push(msg.sender);

    }
    //This is declared private because this method is justa helper function for us
    function random() private view returns(uint){
        //sha3 is a global variable
        //keccak256 and sha3 are the same things
        //block is a global variable. block.difficulty is a large number
        //we convert the output to a uint and then return it back
        return uint(keccak256(block.difficulty,now,players));

    }

    function pickWinner() public restricted {


        uint index = random()%players.length;
        //We can send money to this address using address.transfer()
        //To reference all the amount of ether that is stored in the contract
        //We can just use this.balance
        players[index].transfer(this.balance);       //Example address : 0x1080basdjnja156151321
        //Creates a brand new dynamic array of type address. 0 means the initial size of the array
        players=new address[](0);
    }

    modifier restricted(){
        require(msg.sender==manager);
        _;
    }

    function getPlayers() public view returns(address[]){
        return players;
    }


}