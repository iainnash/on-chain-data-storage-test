// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract StorageMetadata {
    struct MediaInfo {
        string description;
        string animationURI;
        string imageURI;
    }
    mapping(address => MediaInfo) internal metadataStorages;

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
    ) external onlyTarget(target) {
        delete metadataStorages[target];
        metadataStorages[target] = MediaInfo({
            description: description,
            imageURI: imageURI,
            animationURI: animationURI
        });
    }

    function updateMediaData(
        address target,
        string calldata description,
        string calldata imageURI,
        string calldata animationURI
    ) external onlyTarget(target) {
        delete metadataStorages[target];
        metadataStorages[target] = MediaInfo({
            description: description,
            imageURI: imageURI,
            animationURI: animationURI
        });
    }
}
