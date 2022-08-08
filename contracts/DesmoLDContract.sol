pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "./DesmoLdHub.sol";
import "@iexec/doracle/contracts/IexecDoracle.sol"; 
import "@iexec/solidity/contracts/ERC1154/IERC1154.sol";
import "@iexec/solidity/contracts/ERC2362/IERC2362.sol";
import "hardhat/console.sol";

contract DesmoLDContract is IexecDoracle, IOracleConsumer{
    mapping (bytes32 => bytes) private oracleValue;
    mapping (bytes => bytes) private scoreStorager;

    DesmoLDHub public desmoHub;

    event QueryResult(bytes32 indexed id, bytes _calldata);
    
    constructor (address desmoHubAddress) public IexecDoracle(0x0000000000000000000000000000000000000000) {
        desmoHub = DesmoLDHub(desmoHubAddress);
    }    

    function receiveResult(bytes32 id, bytes memory _calldata) external override {
        processQueryResult(_calldata);
        bytes memory results = _iexecDoracleGetVerifiedResult(id);
        oracleValue[id] = results;
        emit QueryResult(id, results);
    }

    function getRaw(bytes32 _oracleId) public view returns(bytes memory bytesValue) {
        return oracleValue[_oracleId];
    }

    function processQueryResult(bytes memory _payload)
    internal{
        uint256 tddSubsetRequestIDLenght;
        uint256 scoreAmount; 
        bytes memory requestID;
        bytes memory scores;
        
        tddSubsetRequestIDLenght = uint8(bytes1(_payload[0]));
        scoreAmount = uint8(bytes1(_payload[tddSubsetRequestIDLenght+1]));

        for (uint256 i = 1; i <= tddSubsetRequestIDLenght; i++){
            requestID = abi.encodePacked(requestID, _payload[i]);
        }
        for (uint256 j = tddSubsetRequestIDLenght+2; j <= tddSubsetRequestIDLenght+1+scoreAmount; j++){
            scores = abi.encodePacked(scores, _payload[j]);
        } 
        scoreStorager[requestID] = scores;
        desmoHub.updateScores(requestID, scores);
    }

    function viewScores(bytes memory requestID)
    public
    view
    returns(bytes memory){
        return scoreStorager[requestID];
    }
}