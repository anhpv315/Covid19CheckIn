import "package:encrypt/encrypt.dart";//pubspec.yaml->encrypt: ^4.1.0


String key = "aesEncryptionKey";
String iv = "aesEncryptionIV!";

Encrypted encrypt(String plainText){
  final key1 = Key.fromUtf8(key);
  final iv1 = IV.fromUtf8(iv);
  final encrypter = Encrypter(AES(key1));
  print("Dart Output…!!!");
  print("IV: " + iv1.bytes.toString());
  print("Key: " + key1.bytes.toString());
  final encrypted = encrypter.encrypt(plainText, iv: iv1);
  print("Encrypted: "+ encrypted.bytes.toString());
  print("Base64: "+encrypted.base64);
  return encrypted;
}
String decrypt(Encrypted encrypted){
  final key1 = Key.fromUtf8(key);
  final iv1 = IV.fromUtf8(iv);
  final encrypter = Encrypter(AES(key1));
  final decrypted = encrypter.decrypt(encrypted, iv: iv1);
  print("Decrypted: "+ decrypted);
  return decrypted;
}