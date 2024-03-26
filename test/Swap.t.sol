// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/Swap.sol";
import "../src/interface/ISwap.sol";
import "../src/interface/IERC20.sol";

contract SwapContractTest is Test {

    IERC20 public daiTokenAddr;
    IERC20 public linkTokenAddr;
    IERC20 public wethTokenAddr;
    ISwap swap;

    address AddrEth = address(0x477b144FbB1cE15554927587f18a27b241126FBC);    
    address AddrDai = address(0xe902aC65D282829C7a0c42CAe165D3eE33482b9f);
    address AddrLink = address(0x6a37809BdFC0aC7b73355E82c1284333159bc5F0);


    function setUp() public {
        daiTokenAddr =  IERC20(0x3e622317f8C93f7328350cF0B56d9eD4C620C5d6);
        linkTokenAddr =  IERC20(0x779877A7B0D9E8603169DdbD7836e478b4624789);
        wethTokenAddr =  IERC20(0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9);
        swap = ISwap(0x7e1AbBc05A9aC613B46eD1Fe9c887e370624876E);
    }


    // function testSwapEthDai() public {

    //     switchSigner(AddrDai);
    //     uint256 balance= dai.balanceOf(AddrDai);
    //     dai.transfer(address(swap), balance);

    //     switchSigner(AddrLink);
    //     uint balanceOfLinkBeforeSwap = link.balanceOf(AddrLink);
    //     link.approve(address(swap), 1);

    //     swap.swapLinkToDai(1);

    //     uint balanceOfLinkAfterSwap = dai.balanceOf(AddrDai);

    //     assertGt(balanceOfLinkAfterSwap, balanceOfLinkBeforeSwap);

    // }

     function testSwapEthLink() public {
        switchSigner(AddrLink);
        console.log(AddrLink);
        uint256 balance= linkTokenAddr.balanceOf(AddrLink);
        linkTokenAddr.transfer(address(swap), balance);

        switchSigner(AddrEth);
        uint balanceOfLinkBeforeSwap = linkTokenAddr.balanceOf(AddrEth);
        wethTokenAddr.approve(address(swap), 1);
        console.log("balanceOfLinkBeforeSwap", balanceOfLinkBeforeSwap);
        swap.swapEthForLink(1);

        uint balanceOflinkAfterSwap = linkTokenAddr.balanceOf(AddrEth);

        console.log(balanceOflinkAfterSwap, balanceOfLinkBeforeSwap);

        assertGt(balanceOflinkAfterSwap, balanceOfLinkBeforeSwap);

    }

     function testSwapLinkDai() public {
        switchSigner(AddrDai);
        uint256 balance= daiTokenAddr.balanceOf(AddrDai);
        daiTokenAddr.transfer(address(swap), balance);

        switchSigner(AddrLink);
        uint balanceOfDaiBeforeSwap = daiTokenAddr.balanceOf(AddrLink);
        linkTokenAddr.approve(address(swap), 1);

        swap.swapLinkToDai(1);

        uint balanceOfDaiAfterSwap = daiTokenAddr.balanceOf(AddrLink);

        assertGt(balanceOfDaiAfterSwap, balanceOfDaiBeforeSwap);

    }

    //  function testSwapLinkEth() public {
        
    //     switchSigner(AddrEth);
    //     uint256 balance= eth.balanceOf(AddrEth);
    //     eth.transfer(address(swapContract), balance);

    //     switchSigner(AddrLink);
    //     uint balanceOfLinkBeforeSwap = eth.balanceOf(AddrLink);
    //     link.approve(address(swapContract), 1);

    //     swapContract.swapLinkEth(1);

    //     uint balanceOfLinkAfterSwap = eth.balanceOf(AddrLink);

    //     assertGt(balanceOfLinkAfterSwap, balanceOfLinkBeforeSwap);

    // }

    //  function testSwapDaiLink() public {
    //     switchSigner(AddrLink);
    //     uint256 balance= link.balanceOf(AddrLink);
    //     link.transfer(address(swapContract), balance);

    //     switchSigner(AddrDai);
    //     uint balanceOfLinkBeforeSwap = link.balanceOf(AddrDai);
    //     dai.approve(address(swapContract), 1);

    //     swapContract.swapDaiLink(1);

    //     uint balanceOfLinkAfterSwap = link.balanceOf(AddrDai);

    //     assertGt(balanceOfLinkAfterSwap, balanceOfLinkBeforeSwap);

    // }

    //  function testSwapDaiEth() public {
    //     switchSigner(AddrEth);
    //     uint256 balance= eth.balanceOf(AddrEth);
    //     eth.transfer(address(swapContract), balance);

    //     switchSigner(AddrDai);
    //     uint balanceOfEthBeforeSwap = eth.balanceOf(AddrDai);
    //     dai.approve(address(swapContract), 1);

    //     swapContract.swapDaiEth(1);

    //     uint balanceOfEthAfterSwap = eth.balanceOf(AddrDai);

    //     assertGt(balanceOfEthAfterSwap, balanceOfEthBeforeSwap);

    // }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }

    function switchSigner(address _newSigner) public {
        address foundrySigner = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;
        if (msg.sender == foundrySigner) {
            vm.startPrank(_newSigner);
        } else {
            vm.stopPrank();
            vm.startPrank(_newSigner);
        }
    }

    
}