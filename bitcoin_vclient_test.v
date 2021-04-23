module bitcoin_vclient

const (
        test_rpc_host    = 'http://10.20.90.105:18338'
        test_client_name = 'vclient'
        test_user        = 'someUser1'
        test_pass        = 'jh85gbw409gh30'
)

fn test_println() {
        client := new_bitcoin_client(test_rpc_host, test_client_name, test_user, test_pass)
        response := client.get_best_block_hash() or { panic(err) }
        println('result: $response.result')
}

fn test_get_best_block_hash() {
        client := new_bitcoin_client(test_rpc_host, test_client_name, test_user, test_pass)
        result := client.get_best_block_hash() or { panic(err) }
        assert result.result.len == 64
        // println('result $result')
}

fn test_get_difficulty() {
        client := new_bitcoin_client(test_rpc_host, test_client_name, test_user, test_pass)
        resposne := client.get_difficulty() or { panic(err) }
        assert resposne.result > 1
        // println('result $resposne')
}

fn test_get_block() {
        client := new_bitcoin_client(test_rpc_host, test_client_name, test_user, test_pass)
        head_hash_resp := client.get_best_block_hash() or { panic(err) }
        resposne := client.get_block(head_hash_resp.result) or { panic(err) }
        assert head_hash_resp.result == resposne.result.hash
        assert resposne.result.tx.len > 0
        // println('result $resposne')
}

fn test_get_block_verbose() {
        client := new_bitcoin_client(test_rpc_host, test_client_name, test_user, test_pass)
        head_hash_resp := client.get_best_block_hash() or { panic(err) }
        resposne := client.get_block_verbose(head_hash_resp.result) or { panic(err) }

        assert head_hash_resp.result == resposne.result.hash
        assert resposne.result.tx.len > 0
        assert resposne.result.tx[0].vin.len > 0
        assert resposne.result.tx[0].vout.len > 0
        // println('result $resposne')
}