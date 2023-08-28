// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "../lib/Auth.sol";

contract The404 is ERC20, Auth {
    using Address for address;

    string private _name = "The404";
    string private _symbol = "TH3";
    uint8 private _decimals = 18;
    uint256 public maxSupply = 750_000_000 * 10 ** 18;

    address private wallet_community = address(0xBB97a6BEbbECCD1617e7b402AAE9E9688E1C98F8);
    address private wallet_dev = address(0xBB97a6BEbbECCD1617e7b402AAE9E9688E1C98F8);
    address private wallet_marketing = address(0xdE186721df2D737c7d3cc578f324c856Fb9a1F7b);

    uint256 private p_community = 5;
    uint256 private p_dev = 5;
    uint256 private p_marketing = 2;

    constructor() ERC20(_name, _symbol) Auth(msg.sender) {
        _mint(wallet_community, p_community * maxSupply / 100);
        _mint(wallet_dev, p_dev * maxSupply / 100);
        _mint(wallet_marketing, p_marketing * maxSupply / 100);
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    function mint(address _to, uint256 _amount) public authorized {
        _mint(_to, _amount);
    }

    function burn(uint256 _amount) public authorized {
        _burn(_msgSender(), _amount);
    }
}