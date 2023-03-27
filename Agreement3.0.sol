// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Agreement {

    struct VoteData {
        bytes32 hashAddress;
        uint256 blockNumber; 
        address userId;
        bool consent;
    }

    VoteData[] private  voteDatas;

    mapping (uint256=>uint256) blockNumberToVoteDataIndex;

    function addVote(
        uint256 _blockNumber,
        address _userId,
        bool _consent
       ) external {
        //voteDatas.push(VoteData(0x30908ace0d183b7443af831063622c1fcab170f97b715e9c8b8152d3a1010d2c,_blockNumber,_userId,_consent));
        voteDatas.push(VoteData(blockhash(_blockNumber),_blockNumber,_userId,_consent));
        blockNumberToVoteDataIndex[_blockNumber] = voteDatas.length -1;
    } 

    function getIsConsent( uint256 _blockNumber) external view returns (bool) {
        return voteDatas[blockNumberToVoteDataIndex[_blockNumber]].consent;
    }


 


}
