String formatNumber(double value) {
  if (value >= 1000000000) {
    return (value / 1000000000).toStringAsFixed(3) + 'B';
  } else if (value >= 1000000) {
    return (value / 1000000).toStringAsFixed(3) + 'M';
  } else if (value >= 1000) {
    return (value / 1000).toStringAsFixed(3) + 'K';
  } else {
    return value.toStringAsFixed(3);
  }
}


String obscureMiddle(String value) {
  if (value.length == 16) {
    // Show the first 3 and the last 3 characters, and hide the middle 10
    return '${value.substring(0, 3)}..........${value.substring(13)}';
  }
  return value; // Return original string if it isn't 16 characters
}

// Usage
// String myString = "1234567890123456";
// String obscuredString = obscureMiddle(myString);
// print(obscuredString); // Output: 123..........456
