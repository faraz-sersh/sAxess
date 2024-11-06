package com.example.skey.utils;

public class Hex {

    public static String encode(byte[] bytes) {
        if(bytes == null) return "";
        final char[] hexArray = "0123456789ABCDEF".toCharArray();
        char[] hexChars = new char[bytes.length * 2];
        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 0xFF;
            hexChars[j * 2] = hexArray[v >>> 4];
            hexChars[j * 2 + 1] = hexArray[v & 0x0F];
        }
        return new String(hexChars);
    }

    public static byte[] decode(String hex) {
        if(hex == null) return new byte[0];
        hex = hex.replace(" ", ""); // remove white space
        if(hex.length() % 2 == 1) { // if odd
            hex = "0" + hex;
        }
        int len = hex.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(hex.charAt(i), 16) << 4)  + Character.digit(hex.charAt(i+1), 16));
        }
        return data;
    }

}
