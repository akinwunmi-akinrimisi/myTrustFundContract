# Trust Fund Distribution Smart Contract

## Overview

The **Trust Fund Distribution** smart contract is designed to manage a family trust fund on the Ethereum blockchain. It automates the process of distributing funds to family members (beneficiaries) according to predefined rules, ensuring fairness, transparency, and security.

### Key Features

- **Beneficiary Management**: Add and manage family members as beneficiaries.
- **Monthly Distribution Cap**: Enforce a maximum distribution of 2 Ether per beneficiary per month.
- **Fund Management**: Deposit and track funds within the contract.
- **Transparency**: Allow beneficiaries to check their balances and the trustee to view the contract's overall balance.

## Contract Details

- **Contract Name**: `TrustFundDistribution`
- **Solidity Version**: `^0.8.19`
- **License**: MIT

## How It Works

### Beneficiary Management

The trustee can add beneficiaries to the contract, each with a unique Ethereum address. The contract prevents duplicate entries and ensures that each beneficiary is correctly tracked.

### Monthly Distribution

Beneficiaries can receive a maximum of 2 Ether per month. The contract automatically resets the distribution limit after 30 days, allowing beneficiaries to receive additional funds in the next period.

### Fund Management

The trustee can deposit funds into the contract, which are then managed and distributed according to the contract's rules. The contract also tracks the balance of each beneficiary and the overall contract balance.

### Transparency

Beneficiaries can view their total received funds at any time, and the trustee can monitor the contract's balance. All transactions are logged on the blockchain, providing a transparent and immutable record.

## Contract Functions

### `addBeneficiary(address _beneficiaryAddress, string memory _beneficiaryName)`

- **Description**: Adds a new beneficiary to the contract.
- **Access**: Only callable by the contract owner (trustee).
- **Parameters**:
  - `_beneficiaryAddress`: The Ethereum address of the beneficiary.
  - `_beneficiaryName`: The name of the beneficiary.

### `sendToBeneficiary(address payable _beneficiaryAddress, uint256 _amount)`

- **Description**: Sends Ether to a registered beneficiary, enforcing the monthly limit.
- **Access**: Only callable by the contract owner (trustee).
- **Parameters**:
  - `_beneficiaryAddress`: The Ethereum address of the beneficiary.
  - `_amount`: The amount of Ether to send.

### `getBeneficiaryBalance(address _beneficiaryAddress)`

- **Description**: Returns the total amount of Ether received by a beneficiary.
- **Access**: Public, view-only.
- **Parameters**:
  - `_beneficiaryAddress`: The Ethereum address of the beneficiary.

### `getOwnerBalance()`

- **Description**: Returns the total balance of the contract.
- **Access**: Public, view-only.

