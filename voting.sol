// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract election{

    event CandidateVoted(uint8 candidateId);
    event CandidateAdded(uint8 candidateId);

    struct candidate{
        uint8 id;
        string name;
        uint count;
    }
    mapping(address => bool) public voters;
    mapping(uint8 => candidate) public candidates;

    uint8 candidates_count;

    constructor(){
        add_candidate("zisan");
        add_candidate("johson");
        add_candidate("jane");
    }

    function add_candidate(string memory name) public {
        candidates_count +=1;
        candidates[candidates_count] = candidate(candidates_count, name, 0);
        emit CandidateAdded(candidates_count);
    }
    function vote(uint8 candidateId) public payable{
        require(!voters[msg.sender]);
        require(candidateId >0 && candidateId < candidates_count);
        candidates[candidateId].count += 1;
        emit CandidateVoted(candidateId);
        voters[msg.sender] = true;
        
    }
    function win() public view returns(string memory){
        uint max = candidates[1].count;
        string memory name;
        for(uint8 item =2; item<= candidates_count; item++){
            if(candidates[item].count > max){
                max = candidates[item].count;
                name = candidates[item].name;
            }            
        }
        return name;
    }

}