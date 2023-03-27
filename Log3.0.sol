// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Log {
    struct LogInfo {
        uint256 blockNumber;
        address actorId;
        uint256 operation;
        string[] personalData;
        string serviceName;
    }

    LogInfo[] private   logs;
 

    mapping (uint256=>uint256) blockNumberToLogInfoIndex;

    function addLog(
        uint256 _blockNumber,
        address _actorId,
        uint256  _operation,
        string[] memory _personalData,
        string memory _serviceName
    )  external {
        logs.push(LogInfo(_blockNumber,_actorId, _operation, _personalData, _serviceName));
        blockNumberToLogInfoIndex[_blockNumber] = logs.length - 1 ;
    }


    function getActorId(uint256 _blockNumber) external view  returns(address){
        return  logs[blockNumberToLogInfoIndex[_blockNumber]].actorId;
    }

    function getOperation(uint256 _blockNumber) external view  returns(uint256){
        return  logs[blockNumberToLogInfoIndex[_blockNumber]].operation;
    }


    function getPersonalData(uint256 _blockNumber) external view  returns(string[] memory){
        return  logs[blockNumberToLogInfoIndex[_blockNumber]].personalData;
    }

    
}

