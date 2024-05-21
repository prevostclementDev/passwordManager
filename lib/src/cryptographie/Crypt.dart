import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:dotenv/dotenv.dart' as dotenv;

class Crypt {

  late SecretKey masterKey;

  final algorithm = AesCtr.with256bits(
    macAlgorithm: Hmac.sha256(),
  );

  Crypt() {
    final env = dotenv.DotEnv()..load();
    final masterKeyBase64 = env['SECRET_KEY'];
    final masterKeyBytes = base64Decode(masterKeyBase64!);
    masterKey = SecretKey(masterKeyBytes);
  }

  // create string for database to recreate secretBox
  createStringFromBox(SecretBox secretBox) {
    return '${base64Encode(secretBox.nonce)}-${base64Encode(secretBox.cipherText)}-${base64Encode(secretBox.mac.bytes)}';
  }

  // explode string box to
  // return { nonce, cipherText, mac }
  explodeStringBox(String stringBox) {
    final splitted = stringBox.split('-');
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
  Future decryptString(List<int> nonce, List<int> cipherText, List<int> mac ) async {
    final secretBox = SecretBox(cipherText, nonce: nonce, mac: Mac(mac));
    final clearText = await algorithm.decrypt(
        secretBox,
        secretKey: masterKey
    );
    return String.fromCharCodes(clearText);
  }

}