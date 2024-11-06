package com.example.skey.ethereum;

import android.util.Log;

import com.example.skey.utils.Hex;
import com.idemia.bchain.util.crypto.CryptoHelper;

import org.web3j.crypto.RawTransaction;

import java.math.BigInteger;


public class EthereumTransactionData {
    private final String to;
    private final BigInteger gasPrice;
    private final BigInteger gasLimit;
    private final BigInteger value;
    private final BigInteger nonce;
    private final Long chainId;
    private final byte[] data;


    public EthereumTransactionData(String to, BigInteger gasPrice, BigInteger gasLimit, ValueUnit value, BigInteger nonce, Long chainId, byte[] data) {
        this.to = to;
        this.gasPrice = gasPrice;
        this.gasLimit = gasLimit;
        this.value = value.toWei().toBigInteger();
        this.nonce = nonce;
        this.chainId = chainId;
        this.data = data;
    }

    public BigInteger getGasLimit() {
        return gasLimit;
    }

    public BigInteger getGasPrice() {
        return gasPrice;
    }

    public BigInteger getNonce() {
        return nonce;
    }

    public BigInteger getValue() {
        return value;
    }

    public Long getChainId() {
        return chainId;
    }

    public String getTo() {
        return to;
    }

    public byte[] getData() {
        return data;
    }


    public RawTransaction toRaw() {
        return CryptoHelper.buildRawTransaction(to,
                gasPrice,
                gasLimit,
                value,
                nonce);
    }
    public RawTransaction toContractRaw() {
        Log.i("Contract", "Contract data Raw Called");
        return RawTransaction.createTransaction(nonce, gasPrice, gasLimit, to, Hex.encode(data));
    }

}
