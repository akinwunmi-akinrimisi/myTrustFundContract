// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MyTrustFundDistribution{
    address public ownerAddress;
    uint256 public ownerBalance;
   

    struct Beneficiary{
        string beneficiaryName;
        address beneficiaryAddress;
        uint256 lastTransferTime; // Track the last transfer time
        uint256 amountSentInWindow; // Track the amount sent within the time window
    }

    // Array to store the list of all beneficiaries
    Beneficiary[] public beneficiaryList;


    // mapping to quickly check if an address is a beneficiary
    mapping(address => bool) public beneficiaryMap;

    // Mapping to store the balance of each beneficiary
    mapping(address => uint256) public beneficiaryBalances;

    // Mapping to track detailed beneficiary information
    mapping(address => Beneficiary) public beneficiaryDetails;

    constructor() payable {
        // require(msg.value<=0, "Ether is required to deploy this contract");/
        ownerAddress = msg.sender;
        ownerBalance = msg.value;
    }

    modifier onlyOwner(){
        require(msg.sender==ownerAddress, "No permission");
        _;
    }


    function addBeneficiary(address _beneficiaryAddress, string memory _beneficiaryName) public onlyOwner {
        require(!beneficiaryMap[_beneficiaryAddress], "Beneficiary already exist");
      
        Beneficiary memory newBeneficiary = Beneficiary({
            beneficiaryName: _beneficiaryName,
            beneficiaryAddress: _beneficiaryAddress, 
            lastTransferTime: block.timestamp, 
            amountSentInWindow: 0
        }) ;

        beneficiaryList.push(newBeneficiary);
        beneficiaryMap[_beneficiaryAddress] = true;
        beneficiaryDetails[_beneficiaryAddress] = newBeneficiary;
    }

    function showBeneficiary() public view returns (Beneficiary[] memory){
        return beneficiaryList;
    }

    function deposit() public payable onlyOwner{
        ownerBalance += msg.value;
    }

    function sendToBeneficiary(address payable _beneficiaryAddress, uint256 _amount) external onlyOwner {
        require(beneficiaryMap[_beneficiaryAddress], "Address not a beneficiary");
        require(ownerBalance >= _amount, "Insufficient balance");
        require(_amount <= 2 ether, "You can't get more than 2ether in a single transaction");

        Beneficiary storage beneficiary = beneficiaryDetails[_beneficiaryAddress];

        // Check if 30 days (1 month) have passed since the last transfer
        if (block.timestamp > beneficiary.lastTransferTime + 30 days){
            beneficiary.amountSentInWindow = 0;
        }

        // Ensure the amount sent in the 1-month window does not exceed 2 Ether
        require(beneficiary.amountSentInWindow + _amount <= 2 ether, "You can't send more than 2 Ether in a 1-month period");
       
        // Update the beneficiary's details
        beneficiary.lastTransferTime = block.timestamp;
        beneficiary.amountSentInWindow += _amount;

         // Perform the transfer
        ownerBalance -= _amount;
        _beneficiaryAddress.transfer(_amount);

        // Update the beneficiary's total balance received
        beneficiaryBalances[_beneficiaryAddress] += _amount;
        
    }

    function getBeneficiaryBalance(address _beneficiaryAddress) public view returns (uint256){
        require(beneficiaryMap[_beneficiaryAddress], "Address not a beneficiary");
        return beneficiaryBalances[_beneficiaryAddress];
    }

    function getOwnerBalance() public view returns(uint){
        return ownerBalance;
    }
}
