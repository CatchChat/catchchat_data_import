## to generate draft contracts for node api

```shell
bundle exec ruby lib/generate.rb
```

Then edit the generated contracts in directory node\_api\_contracts, remember
to add the auth header info

## to verify the api against the contracts

``` shell
bundle exec rspec
```

## to run a fake server provide data in contracts:
```shell
bundle exec pacto-server -sv --contracts_dir node_api_contracts --port 9001 --stub
```
Then you can get a response from the fake server access endpoint using postman: http://localhost:9001/v2/users/messages
## to proxy the traffic to the real service
```shell
bundle exec pacto-server -sv --contracts_dir node_api_contracts --port 9000 --live https://chat.catch.la
```

## to proxy the traffic to the real service and generate contracts
```shell
bundle exec pacto-server -sv --contracts_dir node_api_contracts --port 9000 --generate --live https://chat.catch.la
```

