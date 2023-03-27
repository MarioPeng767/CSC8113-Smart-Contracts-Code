// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DataUsage{

    struct DataPurpose {
        uint256 blockNumber;
        address actorID;
        string serviceName;
        string servicePurpose;
        uint256 operation;
        string[] personalData;
    }
     
    event log(string mesaage,uint256 blockNumber);
    DataPurpose[] private  dataPurposes;


    function addDataPurpose(
        address _actorID,
        string memory _serviceName, 
        string memory _servicePurpose, 
        uint256  _operation, 
        string[] memory _personalData ) external  {
            uint256 _blockNumber = block.number;
            dataPurposes.push(DataPurpose(_blockNumber,_actorID,_serviceName,_servicePurpose,_operation,_personalData));
            emit log(" ----------block number:",_blockNumber);
    }
    

    function getDataPurposes() external view  returns (DataPurpose[] memory){
        return dataPurposes;
    }
}