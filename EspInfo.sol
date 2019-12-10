pragma solidity >=0.4.21 < 0.6.0;


contract EspInfo {
    address public owner;
        
   struct CL{ 
        address CLaddr;// address of the CL
        string name; // CL name
        string macNumber;//CL MAC Number
        int weight;
        //bytes result; // ESPs result
        //string comments; //Comments on CL
        //bytes password;//CL password
        //bytes userpulickey; // CL public key
        //bytes privateKey; //CL private key
        //bytes profileHash; // CL profile hash value
        //bytes usersignature;// CL signature
   }
   
    //struct initialDataChainTx { // create a temporary storage for the CL in datachain
        //address addr; // sender address
       // address permision; // CL with right permission
       // bytes timestamp; // time of transaction
       // uint8 PermissionLevel; // CL permission level
        //address [] l2permissionUser; // store address of all users with permission level 2
        //string message; // Data to share
    //}

    struct ESP{ 
        address addr;// address of the ESP
        string name; // ESP name
        string macNumber;//ESP MAC Number
        uint result; // ESPs result
        string comments; //Comments on ESP  
        int weight;
    }

    //struct ESPservices{ 
      //  address addr;// address of the ESP services
        //bytes name; // ESP service name name
        //bytes result; // ESPs service result
        //bytes comments; //Comments on ESP services
    //}
    
    address CSPserver;

    constructor()public {
        CSPserver = msg.sender;
    }// 
   
    mapping(address => ESP) ESPMap;

    function registerESP(address _ESP, string memory _name, string memory _macNumber) public {
    assert(msg.sender == CSPserver);
    //assert(!ESPMap[ESP].registered);
        ESPMap[_ESP].addr = _ESP;
        ESPMap[_ESP].macNumber = _macNumber;
        ESPMap[_ESP].name= _name;
    }

    mapping(address => CL) CLMap;

    function registerCL(address _CL, string memory _name, string memory _macNumber) public {
    assert(msg.sender == CSPserver);
   // assert(!CLMap[CL].registered);

        CLMap[_CL].CLaddr = _CL;
        CLMap[_CL].macNumber = _macNumber;
        CLMap[_CL].name= _name;
    }

    function checkForESP(address _ESP) public {
        // If the first argument of `require` evaluates
        // to `false`, execution terminates and all
        // changes to the state and to Ether balances
        // are reverted.
        // This used to consume all gas in old EVM versions, but
        // not anymore.
        // It is often a good idea to use `require` to check if
        // functions are called correctly.
        // As a second argument, you can also provide an
        // explanation about what went wrong.
        require(
            msg.sender == CSPserver,
            "Only server can give right to usage."
        );
        require(ESPMap[_ESP].addr == msg.sender,
            "The ESP is already registered."
        );
        require(ESPMap[_ESP].weight == 0);
        ESPMap[_ESP].weight = 1;
    }

    function checkForCL(address _CL) public {
        // If the first argument of `require` evaluates
        // to `false`, execution terminates and all
        // changes to the state and to Ether balances
        // are reverted.
        // This used to consume all gas in old EVM versions, but
        // not anymore.
        // It is often a good idea to use `require` to check if
        // functions are called correctly.
        // As a second argument, you can also provide an
        // explanation about what went wrong.
        require(
            msg.sender == CSPserver,
            "Only server can give right to usage."
        );
        require(CLMap[_CL].CLaddr == msg.sender ,
            "The ESP is already registered."
        );
        require(CLMap[_CL].weight == 0);
        CLMap[_CL].weight = 1;
    }

    function ESPDetails (address _ESP) public returns(address, string memory, string memory, uint, string memory){
        if (ESPMap[_ESP].addr == _ESP){
            ESPMap[_ESP].result =1;
            ESPMap[_ESP].comments= "legitimate ESP and Service";
        }else{
            ESPMap[_ESP].result =0;
            ESPMap[_ESP].comments= " Not legitimate ESP and Service";
        }
        return (ESPMap[_ESP].addr, ESPMap[_ESP].macNumber, ESPMap[_ESP].name, ESPMap[_ESP].result, ESPMap[_ESP].comments);
    }
}
    