String formatNumber(double value) {
  if (value >= 1000000000) {
    return '${(value / 1000000000).toStringAsFixed(3)}B';
  } else if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(3)}M';
  } else if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(3)}K';
  } else {
    return value.toStringAsFixed(3);
  }
}

BigInt convertEthToWei(double eth) {
  const int weiPerEth = 1000000000000000000;
  return BigInt.from(weiPerEth * eth);
}

double weiToEther(BigInt wei) {
  const int weiPerEth = 1000000000000000000;

  // Convert Wei to Ether (divide by 10^18)
  return (wei.toDouble() / weiPerEth).toDouble();
}

String obscureMiddle(String value) {
  return '${value.substring(0, 6)}..........${value.substring(38)}';
}

// Usage
// String myString = "1234567890123456";
// String obscuredString = obscureMiddle(myString);
// print(obscuredString); // Output: 123..........456
