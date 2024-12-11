// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract Transfer {
    string private s_name;
    string private s_description;
    string private s_image;

    address private s_seller;
    address private s_buyer;
    uint256 private s_price;
    StateOfTransfer public s_currentStatus;

    enum StateOfTransfer {
        Created,
        Locked,
        Delivered,
        Received,
        Finalized,
        Cancelled
    }

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(string memory name, string memory description, string memory image, address seller, uint256 price) {
        s_name = name;
        s_description = description;
        s_image = image;
        s_seller = seller;
        s_price = price;
        s_currentStatus = StateOfTransfer.Created;
    }

     /*//////////////////////////////////////////////////////////////
                           PRIVATE FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function lock() private {
        s_currentStatus = StateOfTransfer.Locked;
    }

    function deliver() private {
        s_currentStatus = StateOfTransfer.Delivered;
    }

    function received() private {
        s_currentStatus = StateOfTransfer.Received;
    }

    function finalize() private {
        s_currentStatus = StateOfTransfer.Finalized;
    }

    function cancel() private {
        s_currentStatus = StateOfTransfer.Cancelled;
    }

    /*//////////////////////////////////////////////////////////////
                            PUBLIC FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function pay(uint256 amount) public {
        require(s_currentStatus == StateOfTransfer.Created, "Transfer is not in Created state");
        require(amount == s_price, "Amount is not equal to price");
        s_buyer = msg.sender;
        lock();
    }



    /*//////////////////////////////////////////////////////////////
                                GETTERS
    //////////////////////////////////////////////////////////////*/

    function getName() public view returns (string memory) {
        return s_name;
    }

    function getDescription() public view returns (string memory) {
        return s_description;
    }

    function getImage() public view returns (string memory) {
        return s_image;
    }

    function getPrice() public view returns (uint256) {
        return s_price;
    }

    function getSeller() public view returns (address) {
        return s_seller;
    }

    function getBuyer() public view returns (address) {
        return s_buyer;
    }

    function getState() public view returns (StateOfTransfer) {
        return s_currentStatus;
    }
}
