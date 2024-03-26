// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface ISwap {
    
    function swapEthForLink (uint256 _amount) external;
    function swapLinkForEth (uint256 _amount) external;
    function swapDaiForEth (uint256 _amount) external;
    function swapEthForDai (uint256 _amount) external;
    function swapLinkToDai (uint256 _amount) external;
    function swapDaiToLink (uint256 _amount) external;
}
