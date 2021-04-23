module bitcoin_vclient

import x.json2
import json
import encoding.base64
import net.http

/*
RPC API reference: https://developer.bitcoin.org/reference/rpc/index.html
*/
struct BitcoinClient {
        rpc_address string
        client_id   string
        auth_header string
}

pub fn new_bitcoin_client(rpc_address string, client_id string, auth_user string, auth_pass string) &BitcoinClient {
        client := &BitcoinClient{
                rpc_address: rpc_address
                client_id: client_id
                auth_header: 'Basic ' + base64.encode_str(auth_user + ':' + auth_pass)
        }

        return client
}

fn (client &BitcoinClient) call(methodName string, params ...json2.Any) ?string {
        request_data := RpcRequest{
                jsonrpc: '1.0'
                id: client.client_id
                method: methodName
                params: params
        }

        mut request := http.new_request(http.Method.post, client.rpc_address, json2.encode<RpcRequest>(request_data)) ?
        request.add_custom_header('Authorization', client.auth_header) ?
        response := request.do() ?
        // check respose status code
        if response.status_code != http.Status.ok.int() {
                return error('Server return status code:$response.status_code')
        }
        
        return response.text
}

pub fn (client &BitcoinClient) get_best_block_hash() ?RpcStringResponse {
        response_json := client.call('getbestblockhash') ?
        return json.decode(RpcStringResponse, response_json)
}

pub fn (client &BitcoinClient) get_difficulty() ?RpcFloatResponse {
        response_json := client.call('getdifficulty') ?
        return json.decode(RpcFloatResponse, response_json)
}

pub fn (client &BitcoinClient) get_block(blockHash string) ?RpcBlockResponse {
        response_json := client.call('getblock', blockHash) ?
        return json.decode(RpcBlockResponse, response_json)
}

pub fn (client &BitcoinClient) get_block_verbose(blockHash string) ?RpcBlockVerboeResponse {
        response_json := client.call('getblock', blockHash, 2) ?
        return json.decode(RpcBlockVerboeResponse, response_json)
}

