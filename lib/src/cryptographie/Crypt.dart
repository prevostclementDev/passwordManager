import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import '../../globals.dart';

class Crypt {

  late SecretKey masterKey;

  final algorithm = AesCtr.with256bits(
    macAlgorithm: Hmac.sha256(),
  );

  Crypt() {
    final masterKeyBase64 = Globals.env['SECRET_KEY'];
    final masterKeyBytes = base64Decode(masterKeyBase64!);
    masterKey = SecretKey(masterKeyBytes);
  }

  // create string for database to recreate secretBox
  String createStringFromBox(SecretBox secretBox) {
    return '${base64Encode(secretBox.nonce)}-${base64Encode(secretBox.cipherText)}-${base64Encode(secretBox.mac.bytes)}';
  }

  // explode string box to
  // return { nonce, cipherText, mac }
  explodeStringBox(String stringBox) {
    final splitted = stringBox.split('-');

    if ( splitted.length != 3 ) return stringBox;

    return {
      'nonce' : base64Decode(splitted[0]),
      'cipherText' : base64Decode(splitted[1]),
      'mac' : base64Decode(splitted[2])
    };
  }

  // create secretBox
  Future encryptString(String message) async {
    return await algorithm.encrypt(
      message.codeUnits,
      secretKey: masterKey,
    );
  }

  // get content of secretBox
  Future <String> decryptString(List<int> nonce, List<int> cipherText, List<int> mac ) async {
    final secretBox = SecretBox(cipherText, nonce: nonce, mac: Mac(mac));
    final clearText = await algorithm.decrypt(
        secretBox,
        secretKey: masterKey
    );
    return String.fromCharCodes(clearText);
  }

  // Hash password
  Future hashPassword(String password) async {
    final algorithm = Argon2id(
      memory: 10*1000, // 10 MB
      parallelism: 2, // Use maximum two CPU cores.
      iterations: 1, // For more security, you should usually raise memory parameter, not iterations.
      hashLength: 32, // Number of bytes in the returned hash
    );

    final secretKey = await algorithm.deriveKeyFromPassword(
      password: password,
      nonce: [1, 2, 3],
    );
    final secretKeyBytes = await secretKey.extractBytes();

    return secretKeyBytes.join(':');
  }

}