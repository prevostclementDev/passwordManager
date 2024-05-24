import 'dart:ffi';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:password_administrator/src/cryptographie/Crypt.dart';

void main() {

  group('Crypt hashPassword()', () {

    test('should hashPassword() return string', () async {
      final crypt = Crypt();
      final password = await crypt.hashPassword('123456');

      expect(password, isA<String>());
    });

    test('should hashPassword() return exact string' , () async {
      final crypt = Crypt();
      final password = await crypt.hashPassword('123456');

      expect(password, '143:142:84:2:148:35:226:125:245:200:112:77:178:69:0:227:88:196:24:134:201:14:64:206:158:161:201:145:198:80:79:30');
    });

    test('should hashPassword() return false string' , () async {
      final crypt = Crypt();
      final password = await crypt.hashPassword('123456');

      expect(password, isNot('146:143:12:534:148:35:226:125:245:200:112:77:178:69:0:227:88:196:24:134:201:14:64:206:158:161:201:145:198:80:79:36'));
    });

  });

  group('Crypt encrypt string', () {

    test('should encryptString() return secretBox', () async {
      final crypt = Crypt();
      final secretBox = await crypt.encryptString('data');

      expect(secretBox, isA<SecretBox>());
    });

    test('should createStringFromBox() return string', () async {
      final crypt = Crypt();
      final string = await crypt.createStringFromBox( await crypt.encryptString('data') );

      expect(string, isA<String>());
    });

    test('should createStringFromBox() return string with three part', () async {
      final crypt = Crypt();
      final string = await crypt.createStringFromBox( await crypt.encryptString('data') );

      final part = string.split('-');

      expect(part.length, 3);
    });

    test('should explodeStringBox() return string if string is not in three part', () async {
      final crypt = Crypt();
      final string = crypt.explodeStringBox('test');

      expect(string, isA<String>());
    });

    test('should explodeStringBox() return map if string is in three part', () async {
      final crypt = Crypt();
      final string = crypt.explodeStringBox('test-test-test');

      expect(string, isA<Map<String, List<int>>>());
    });

    test('should decryptString() return exact string', () async {
      final crypt = Crypt();
      final cryptMessage = await crypt.encryptString('mon message crypté');

      final messageUnCrypt = await crypt.decryptString(cryptMessage.nonce, cryptMessage.cipherText, cryptMessage.mac.bytes);
      expect(messageUnCrypt, 'mon message crypté');
    });

  });

}