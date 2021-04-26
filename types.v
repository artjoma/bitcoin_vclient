module bitcoin_vclient

import x.json2

struct RpcRequest {
        jsonrpc string
        id      string
        method  string
        params  []json2.Any
}

fn (request RpcRequest) to_json() string {
        mut obj := map[string]json2.Any{}
        obj['jsonrpc'] = request.jsonrpc
        obj['id'] = request.id
        obj['method'] = request.method
        obj['params'] = request.params
        return obj.str()
}

struct RpcStringResponse {
        result string [json: result]
        error  string [json: error]
        id     string [json: id]
}

struct RpcFloatResponse {
        result f64    [json: result]
        error  string [json: error]
        id     string [json: id]
}

struct RpcBlockResponse {
        result Block  [json: result]
        error  string [json: error]
        id     string [json: id]
}

struct RpcBlockVerboseResponse {
        result BlockVerbose [json: result]
        error  string       [json: error]
        id     string       [json: id]
}

struct RpcGetTxOutResponse {
        result TxOutResponse [json: result]
        error  string       [json: error]
        id     string       [json: id]
}

struct TxOutResponse {
        bestblock string [json: bestblock]
        confirmations u64 [json: confirmations]
        value f64 [json: value]
        script_pub_key ScriptPubKey [json: 'scriptPubKey']
        coinbase bool [json: coinbase]
}

struct Block {
        hash              string   [json: hash]
        confirmations     u32      [json: confirmations]
        size              u64      [json: size]
        strippedsize      u64      [json: strippedsize]
        weight            u64      [json: weight]
        height            u64      [json: height]
        version           u32      [json: version]
        version_hex       string   [json: versionHex]
        merkleroot        string   [json: merkleroot]
        tx                []string [json: tx]
        time              u64      [json: time]
        mediantime        u64      [json: mediantime]
        nonce             u64      [json: nonce]
        bits              string   [json: bits]
        difficulty        f64      [json: difficulty]
        chainwork         string   [json: chainwork]
        n_tx              u16      [json: nTx]
        previousblockhash string   [json: previousblockhash]
        nextblockhash     string   [json: nextblockhash]
}

struct BlockVerbose {
        hash              string        [json: hash]
        confirmations     u32           [json: confirmations]
        size              u32           [json: size]
        strippedsize      u32           [json: strippedsize]
        weight            u64           [json: weight]
        height            u64           [json: height]
        version           u32           [json: version]
        version_hex       string        [json: versionHex]
        merkleroot        string        [json: merkleroot]
        tx                []Transaction [json: tx]
        time              u64           [json: time]
        mediantime        u64           [json: mediantime]
        nonce             u64           [json: nonce]
        bits              string        [json: bits]
        difficulty        f64           [json: difficulty]
        chainwork         string        [json: chainwork]
        n_tx              u16           [json: nTx]
        previousblockhash string        [json: previousblockhash]
        nextblockhash     string        [json: nextblockhash]
}

struct Transaction {
        in_active_chain bool   [json: in_active_chain]
        hex             string [json: hex]
        txid            string [json: txid]
        hash            string [json: hash]
        size            u32    [json: size]
        vsize           u32    [json: vsize]
        weight          u32    [json: weight]
        version         u32    [json: version]
        locktime        u64    [json: locktime]
        vin             []Vin  [json: vin]
        vout            []Vout [json: vout]
        blockhash       string [json: blockhash]
        confirmations   u32    [json: confirmations]
        blocktime       u64    [json: blocktime]
        time            u64    [json: time]
}

struct Vin {
        txid        string        [json: txid]
        vout        u16           [json: vout]
        script_sig  ScriptSig     [json: scriptSig]
        sequence    u64           [json: sequence]
        txinwitness []TxInWitness [json: txinwitness]
}

struct ScriptSig {
        asm_sig string [json: 'asm']
        hex     string [json: hex]
}

struct TxInWitness {
        hex string [json: hex]
}

struct Vout {
        value          f64          [json: value]
        n              u16          [json: n]
        script_pub_key ScriptPubKey [json: scriptPubKey]
}

struct ScriptPubKey {
        asm_script  string   [json: 'asm']
        hex         string   [json: hex]
        req_sigs    u16      [json: reqSigs]
        type_script string   [json: 'type']
        addresses   []string [json: addresses]
}

