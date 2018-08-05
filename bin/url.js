const { join } = require('path');
const index = process.argv.findIndex(a => a==="CF_POLICY.json" || a==="CF_ROLE.json");
const json = require(join(__dirname, process.argv[index]));
console.log(JSON.stringify(json));