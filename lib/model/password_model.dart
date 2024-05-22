import 'package:password_administrator/src/cryptographie/Crypt.dart';

class Password {
  String site_name;
  String site_url;
  String password;
  final int id_user;
  bool isPasswordVisible;

  Password({
    required this.site_name,
    required this.site_url,
    required this.password,
    required this.id_user,
    this.isPasswordVisible = false,
  }) {
    decryptData();
  }

  Password.fromMap(Map<String, dynamic> map) : this(
      site_name: map['site_name'],
      site_url: map['site_url'],
      password: map['password'],
      id_user: map['id_user'],
      isPasswordVisible : false
  );

  decryptData() async {
    final crypt = Crypt();

    final siteNameCryptExplode =  crypt.explodeStringBox(site_name);
    if ( siteNameCryptExplode.length == 3 ) {
      site_name = await crypt.decryptString( siteNameCryptExplode['nonce'] , siteNameCryptExplode['cipherText'], siteNameCryptExplode['mac'] );
    }

    final siteUrlCryptExplode =  crypt.explodeStringBox(site_url);
    if ( siteUrlCryptExplode.length == 3 ) {
      site_url = await crypt.decryptString( siteUrlCryptExplode['nonce'] , siteUrlCryptExplode['cipherText'], siteUrlCryptExplode['mac'] );
    }

    final passwordCryptExplode =  crypt.explodeStringBox(password);
    if ( passwordCryptExplode.length == 3 ) {
      password = await crypt.decryptString( passwordCryptExplode['nonce'] , passwordCryptExplode['cipherText'], passwordCryptExplode['mac'] );
    }

  }

  Map<String, dynamic> toMap() {
    return {
      'site_name': site_name,
      'site_url': site_url,
      'password': password,
      'id_user' : id_user,
    };
  }

  Future <Map<String, Object?>> toEncryptMap() async {

    final cryptTools = Crypt();
    final encryptSiteName = cryptTools.createStringFromBox( await cryptTools.encryptString(site_name) );
    final encryptSiteUrl = cryptTools.createStringFromBox( await cryptTools.encryptString(site_url) );
    final encryptPassword = cryptTools.createStringFromBox( await cryptTools.encryptString(password) );

    return {
      'site_name': encryptSiteName,
      'site_url': encryptSiteUrl,
      'password': encryptPassword,
      'id_user' : id_user,
    };
  }

}