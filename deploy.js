const HDWalletProvider = require("@truffle/hdwallet-provider");
const Web3 = require("web3");
const { interface, bytecode } = require("./compile");

const mnemonicPhrase =
  "chicken feature usage nurse group motor stone enlist tray business bus north";

const provider = new HDWalletProvider({
  mnemonic: {
    phrase: mnemonicPhrase,
  },
  providerOrUrl:
    "https://ropsten.infura.io/v3/1c9785c7a04647e1804b6f6fd879c6a4",
});

const web3 = new Web3(provider);

const deploy = async () => {
  //Fetch All accounts. Always use the await keyword
  let accounts = await web3.eth.getAccounts();
  console.log(accounts);
  console.log("Attempting to deploy from :", accounts[0]);

  //Creating a new Contract. Follow the below Syntax

  const result = await new web3.eth.Contract(JSON.parse(interface))
    .deploy({ data: "0x" + bytecode }) // add 0x bytecode
    .send({ from: accounts[0] }); // remove 'gas'

  console.log(interface);
  console.log("Contract Deployed to : ", result.options.address);
};

//Calling the deploy method
deploy();
