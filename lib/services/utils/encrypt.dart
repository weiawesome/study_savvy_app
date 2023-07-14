import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pointycastle/export.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:asn1lib/asn1lib.dart';
import 'package:study_savvy_app/models/profile/model_profile.dart';

Future<SecureData> encrypt(String text) async {

  final plainText = text;
  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(16);

  final encryptAES = Encrypter(AES(key, mode: AESMode.ecb));
  final encrypted = encryptAES.encrypt(plainText, iv: iv);

  final publicKey = await parsePublicKeyFromPemFile('assets/keys/public_key.pem');

  final encryptRSA = Encrypter(RSA(publicKey: publicKey,encoding: RSAEncoding.OAEP));
  final encryptedKey = encryptRSA.encrypt(key.base64);

  final encodedEncryptedData = base64.encode(encrypted.bytes);
  final encodedEncryptedKey = encryptedKey.base64;

  return SecureData(encodedEncryptedData, encodedEncryptedKey);
}

Future<RSAPublicKey> parsePublicKeyFromPemFile(String path) async {
  final publicKeyAsPem = await rootBundle.loadString(path);
  final publicKeyAsDer = decodePEM(publicKeyAsPem);
  final asn1Parser = ASN1Parser(publicKeyAsDer);

  final topLevelSequence = asn1Parser.nextObject() as ASN1Sequence;
  final publicKeyBitString = topLevelSequence.elements[1];

  final publicKeyAsn = ASN1Parser(publicKeyBitString.contentBytes()!);
  final asnSequence = publicKeyAsn.nextObject() as ASN1Sequence;

  final modulus = (asnSequence.elements[0] as ASN1Integer).valueAsBigInteger;
  final exponent = (asnSequence.elements[1] as ASN1Integer).valueAsBigInteger;

  return RSAPublicKey(modulus!, exponent!);
}

Uint8List decodePEM(String pem) {
  final startsWith = [
    '-----BEGIN PUBLIC KEY-----',
    '-----BEGIN RSA PUBLIC KEY-----',
  ];
  final endsWith = [
    '-----END PUBLIC KEY-----',
    '-----END RSA PUBLIC KEY-----',
  ];

  bool isOpenSSLKeys = true;

  for (var s in startsWith) {
    if (pem.startsWith(s)) {
      isOpenSSLKeys = true;
    }
  }

  for (var s in endsWith) {
    if (pem.endsWith(s)) {
      isOpenSSLKeys = true;
    }
  }

  if (isOpenSSLKeys) {
    pem = pem.replaceAll(RegExp(r'-+(BEGIN|END) PUBLIC KEY-+'), '');
  }

  pem = pem.replaceAll('\n', '').replaceAll('\r', '');
  return base64.decode(pem);
}