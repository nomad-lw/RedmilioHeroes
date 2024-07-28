// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {RedmilioHeroesNFT} from "../src/RedmilioHeroesNFT.sol";

contract RedmilioHeroesNFTScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        RedmilioHeroesNFT nft = new RedmilioHeroesNFT("RedmilioHeroes", "REDMHERO", "BASE_URI");

        vm.stopBroadcast();
    }
}
