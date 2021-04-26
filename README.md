## Vlang Bitcoin RPC client

```
client := new_bitcoin_client(test_rpc_host, test_client_name, test_user, test_pass)
response := client.get_best_block_hash() or {
	panic(err) 
}
println('result: $response.result')
```

```
result: 00000000000000000009455e1ccb8dcfd5aa0a348984790e0c5303cdee72cde7
```

# Supported methods:
* getbestblockhash
* getblock (verbosity)
* getdifficulty
* gettxout