// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DataUsage3.0.sol";
import "./Agreement3.0.sol";
import "./Log3.0.sol";
contract Verification {

    DataUsage private dataUsage;
    Agreement private userAgreement;
    Log private logs;

    address[]  vioActor;

    mapping(string => bool) map;
    

    address  CurrAgreeAddr ;
    address  CurrLogAddr ;
    address  CurrUsageAddr ;

    function updateAddress(address _usageAddr,address _agreeAddr,address _logAddr ) public {
        if(CurrAgreeAddr != _agreeAddr){CurrAgreeAddr = _agreeAddr;}
        if (CurrLogAddr != _logAddr){CurrLogAddr = _logAddr;}
        if (CurrUsageAddr != _usageAddr){CurrUsageAddr = _usageAddr;}
    }

    function verification() public  returns (address[] memory){
        dataUsage = DataUsage(CurrUsageAddr);
        userAgreement = Agreement(CurrAgreeAddr); 
        logs = Log(CurrLogAddr);

        DataUsage.DataPurpose[] memory dataPurposeList = dataUsage.getDataPurposes();

        for(uint i=0; i<dataPurposeList.length ; i++){

            DataUsage.DataPurpose memory dataPurpose = dataPurposeList[i] ;

            uint blockNumber = dataPurpose.blockNumber;
            address  LogActorId = logs.getActorId(blockNumber);
            bool consent = userAgreement.getIsConsent(blockNumber);
            uint op = logs.getOperation(blockNumber);
            string[] memory personal = logs.getPersonalData(blockNumber);
          
            if((!consent) && (personal.length != 0) && (op != 0)){
                vioActor.push(LogActorId); 
                continue;
            }
            else { 
                if(dataPurpose.actorID != logs.getActorId(blockNumber)){
                    vioActor.push(LogActorId);
                    continue;
                }else if(dataPurpose.operation < logs.getOperation(blockNumber)){
                    vioActor.push(LogActorId); 
                    continue;
                }else if(!isSubset(logs.getPersonalData(blockNumber),dataPurpose.personalData)){
                    vioActor.push(LogActorId);
                    continue;
                }
            }
        }
        return vioActor;
    }

    function isSubset(string[] memory _subset, string[] memory _fatherSet) public pure  returns (bool) {
            for(uint i =0; i< _fatherSet.length;i++){
                if(isEmpty(_fatherSet[i])== false && isEmpty(_subset[i])== true){
                    return false;
                }
            }
        
        return true;
    }
 
     function isEmpty(string memory _value) public pure  returns(bool){
          if (keccak256(abi.encodePacked(_value)) == keccak256(abi.encodePacked(""))) {
               return false;
          }
               return  true;
    }

    function getVioActor() public view returns (uint256 numVioActor,address[] memory ){
        return (vioActor.length,vioActor);
    }
    
    

}



        



