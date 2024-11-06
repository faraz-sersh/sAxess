package com.example.skey.ethereum;

import com.idemia.bchain.sdk.data.SignedData;
import com.idemia.bchain.util.crypto.CryptoHelper;

import org.web3j.crypto.RawTransaction;
import org.web3j.crypto.Sign;
import org.web3j.crypto.TransactionEncoder;

public class EthereumTransaction {

    /**
     * Generate transaction message for ethereum transaction
     *
     * @param transactionData
     * @return
     */
    public static byte[] generateTransactionMessage(EthereumTransactionData transactionData) {

        RawTransaction rawTransaction = transactionData.toRaw();
        if (transactionData.getData().length != 0) {
            rawTransaction = transactionData.toContractRaw();
        }
        // Generate RLP data structure
        if (transactionData.getChainId() != null) { // If chain id given
            return TransactionEncoder.encode(rawTransaction, transactionData.getChainId());
        } else {
            return TransactionEncoder.encode(rawTransaction);
        }
    }

    /**
     * Hash transaction message
     *
     * @param message
     * @return
     */
    public static byte[] hashTransactionMessage(byte[] message) {
        return CryptoHelper.hashTransaction(message); // Make hash
    }

    /**
     * Wrap signature with transaction data
     *
     * @param transactionData
     * @param signature
     * @return
     */
    public static byte[] wrapSignatureWithTransaction(EthereumTransactionData transactionData, SignedData signature) {
        RawTransaction rawTransaction = transactionData.toRaw();
        if (transactionData.getData().length != 0) {
            rawTransaction = transactionData.toContractRaw();
        }
        Sign.SignatureData fixedSignature = new Sign.SignatureData(signature.getV(), signature.getR(), signature.getS());

        // Build RLP Signature data
        if (transactionData.getChainId() != null) {  // If chain id given
            Sign.SignatureData eip155Signature = TransactionEncoder.createEip155SignatureData(fixedSignature, transactionData.getChainId());
            return TransactionEncoder.encode(rawTransaction, eip155Signature);
        } else {
            return TransactionEncoder.encode(rawTransaction, fixedSignature);
        }
    }

}
