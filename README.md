![DESMO-LD](https://github.com/vaimee/desmo/blob/c763cec12f6c9060a9f1a3335ff4cff60ece3df2/imgs/desmo-logo.png)
# DESMO-LD Contracts

**Overview** 

> Desmo is a Smart contract that implements the IExec `IexecDoracle`. Its purpose is to serve as the main API entrypoint for DESMO-LD client Smart Contracts. Additionally, Desmo will implement the logic to randomly select a set of valid Thing Description Directories registered in the DESMOHub. The APIs will serve on-chain clients with endpoints that can search for a device inside the DESMO-LD network of Thing Description Directories, get sensor data and invoke operations on remote sensors.

## Deployement

Currently, a single instance of Desmo and DesmoHub is deployed on the viviani network. In the table you can find the contract addresses. 
| Contract  | Address  | 
|---|---|
| DesmoHub  | [0xb2766acEFFC0Ba82Ee921e34156C950B07e8760B](https://blockscout-viviani.iex.ec/address/0xb2766acEFFC0Ba82Ee921e34156C950B07e8760B/transactions)  |
| Desmo | [0xCe33c8EC9d418bB1e1095bB4C6d99834C7996BF0](https://blockscout-viviani.iex.ec/address/0xCe33c8EC9d418bB1e1095bB4C6d99834C7996BF0/transactions)  |