# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile


# This is required to have bouncycastle working with R8/Proguard
-keep class org.bouncycastle.**

# Recommended Proguard settings
-optimizationpasses 5
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*,!code/simplification/cast
-repackageclasses ''
-allowaccessmodification


# Suppress warnings for EthereumTransaction-related classes
-dontwarn com.example.skey.ethereum.EthereumTransaction
-dontwarn com.example.skey.ethereum.EthereumTransactionData
-dontwarn com.example.skey.ethereum.ValueUnit$Ether
-dontwarn com.example.skey.ethereum.ValueUnit
-dontwarn com.example.skey.utils.Hex

# Suppress warnings for javax.naming classes
-dontwarn javax.naming.NamingEnumeration
-dontwarn javax.naming.NamingException
-dontwarn javax.naming.directory.Attribute
-dontwarn javax.naming.directory.Attributes
-dontwarn javax.naming.directory.DirContext
-dontwarn javax.naming.directory.InitialDirContext
-dontwarn javax.naming.directory.SearchControls
-dontwarn javax.naming.directory.SearchResult
