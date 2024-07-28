// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**

 ███████████   ██████████ ██████████   ██████   ██████ █████ █████       █████    ███████   
░░███░░░░░███ ░░███░░░░░█░░███░░░░███ ░░██████ ██████ ░░███ ░░███       ░░███   ███░░░░░███ 
 ░███    ░███  ░███  █ ░  ░███   ░░███ ░███░█████░███  ░███  ░███        ░███  ███     ░░███
 ░██████████   ░██████    ░███    ░███ ░███░░███ ░███  ░███  ░███        ░███ ░███      ░███
 ░███░░░░░███  ░███░░█    ░███    ░███ ░███ ░░░  ░███  ░███  ░███        ░███ ░███      ░███
 ░███    ░███  ░███ ░   █ ░███    ███  ░███      ░███  ░███  ░███      █ ░███ ░░███     ███ 
 █████   █████ ██████████ ██████████   █████     █████ █████ ███████████ █████ ░░░███████░  
░░░░░   ░░░░░ ░░░░░░░░░░ ░░░░░░░░░░   ░░░░░     ░░░░░ ░░░░░ ░░░░░░░░░░░ ░░░░░    ░░░░░░░    
                                                                                            
                                                                                            
                                                                                            
 █████   █████ ██████████ ███████████      ███████    ██████████  █████████                 
░░███   ░░███ ░░███░░░░░█░░███░░░░░███   ███░░░░░███ ░░███░░░░░█ ███░░░░░███                
 ░███    ░███  ░███  █ ░  ░███    ░███  ███     ░░███ ░███  █ ░ ░███    ░░░                 
 ░███████████  ░██████    ░██████████  ░███      ░███ ░██████   ░░█████████                 
 ░███░░░░░███  ░███░░█    ░███░░░░░███ ░███      ░███ ░███░░█    ░░░░░░░░███                
 ░███    ░███  ░███ ░   █ ░███    ░███ ░░███     ███  ░███ ░   █ ███    ░███                
 █████   █████ ██████████ █████   █████ ░░░███████░   ██████████░░█████████                 
░░░░░   ░░░░░ ░░░░░░░░░░ ░░░░░   ░░░░░    ░░░░░░░    ░░░░░░░░░░  ░░░░░░░░░                  
                                                                                                                                                                                                   
                                                                                                       

    @title: Redmilio Heroes NFT
    @author: [sambot](https://twitter.com/nomad_lw)

 */


import "@openzeppelin/contracts/access/Ownable.sol";
import "@erc721a-4.3.0/contracts/ERC721A.sol";

contract RedmilioHeroesNFT is ERC721A, Ownable {
    
    uint256 public constant MAX_SUPPLY = 24;

    string public baseURI;

    constructor( string memory _name, string memory _symbol, string memory _initialBaseURI ) ERC721A(_name, _symbol) Ownable(msg.sender) {
        baseURI = _initialBaseURI;
    }

    // mint NFTs (only owner)
    function mint(uint256 quantity) external onlyOwner {
        require(totalSupply() + quantity <= MAX_SUPPLY, "Exceeds max supply");
        _safeMint(msg.sender, quantity);
    }

    // mint and airdrop tokens
    function mintAndAirdrop(
        address[] calldata recipients,
        uint256[] calldata quantities
    ) external onlyOwner {
        require(
            recipients.length == quantities.length,
            "Mismatched recipients and quantities"
        );
        uint256 totalQuantity = 0;
        for (uint256 i = 0; i < recipients.length; i++) {
            totalQuantity += quantities[i];
        }

        require(
            totalSupply() + totalQuantity <= MAX_SUPPLY,
            "Exceeds max supply"
        );

        for (uint256 i = 0; i < recipients.length; i++) {
            _safeMint(recipients[i], quantities[i]);
        }
    }

    // Override _baseURI to return the base URI for the metadata
    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    // Owner can set the base URI (e.g., if metadata is on Arweave or gateway needs to be updated)
    function setBaseURI(string memory _newBaseURI) external onlyOwner {
        baseURI = _newBaseURI;
    }

    // Function to get the token URI
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721A: URI query for nonexistent token");

        string memory base = _baseURI();
        return bytes(base).length > 0 ? string(abi.encodePacked(base, _toString(tokenId), ".json")) : "";
    }

    // Start tokenId at 1
    function _startTokenId() internal view virtual override returns (uint256) {
        return 1;
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
