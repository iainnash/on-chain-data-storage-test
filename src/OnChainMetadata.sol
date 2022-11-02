// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import {BytecodeStorage} from './BytecodeStorage.sol';

contract OnChainMetadata {
    mapping(address => address) internal metadataStorages;

    error NotACorrectTarget();

    modifier onlyTarget(address target) {
        if (target != msg.sender) {
            revert NotACorrectTarget();
        }

        _;
    }

    function setMediaData(
        address target,
        string calldata description,
        string calldata imageURI,
        string calldata animationURI
    ) public onlyTarget(target) {
        address previousTarget = metadataStorages[target];
        if (previousTarget != address(0x0)) {
            BytecodeStorage.purgeBytecode(previousTarget);
        }
        metadataStorages[target] = BytecodeStorage.writeToBytecode(abi.encode(
            description,
            imageURI,
            animationURI
        ));
    }

    function updateMediaData(
        address target,
        string calldata description,
        string calldata imageURI,
        string calldata animationURI
    ) external onlyTarget(target) {
        BytecodeStorage.purgeBytecode(metadataStorages[target]);
        setMediaData(target, description, imageURI, animationURI);
    }

}
