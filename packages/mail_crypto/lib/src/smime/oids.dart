/// Object identifiers of X.509, CMS (RFC 5652, 5083, 5753, 8551) and PKCS#12.
library;

abstract final class Oid {
  // CMS content types.
  static const data = '1.2.840.113549.1.7.1';
  static const signedData = '1.2.840.113549.1.7.2';
  static const envelopedData = '1.2.840.113549.1.7.3';
  static const encryptedData = '1.2.840.113549.1.7.6';
  static const authEnvelopedData = '1.2.840.113549.1.9.16.1.23';

  // Attributes.
  static const contentType = '1.2.840.113549.1.9.3';
  static const messageDigest = '1.2.840.113549.1.9.4';
  static const signingTime = '1.2.840.113549.1.9.5';
  static const smimeCapabilities = '1.2.840.113549.1.9.15';
  static const encryptionKeyPreference = '1.2.840.113549.1.9.16.2.11';
  static const msEncryptionKeyPreference = '1.3.6.1.4.1.311.16.4';
  static const friendlyName = '1.2.840.113549.1.9.20';
  static const localKeyId = '1.2.840.113549.1.9.21';
  static const emailAddress = '1.2.840.113549.1.9.1';

  // Digests.
  static const sha1 = '1.3.14.3.2.26';
  static const sha224 = '2.16.840.1.101.3.4.2.4';
  static const sha256 = '2.16.840.1.101.3.4.2.1';
  static const sha384 = '2.16.840.1.101.3.4.2.2';
  static const sha512 = '2.16.840.1.101.3.4.2.3';
  static const md5 = '1.2.840.113549.2.5';

  // Public keys and signatures.
  static const rsaEncryption = '1.2.840.113549.1.1.1';
  static const rsaesOaep = '1.2.840.113549.1.1.7';
  static const mgf1 = '1.2.840.113549.1.1.8';
  static const rsassaPss = '1.2.840.113549.1.1.10';
  static const sha1WithRsa = '1.2.840.113549.1.1.5';
  static const sha224WithRsa = '1.2.840.113549.1.1.14';
  static const sha256WithRsa = '1.2.840.113549.1.1.11';
  static const sha384WithRsa = '1.2.840.113549.1.1.12';
  static const sha512WithRsa = '1.2.840.113549.1.1.13';
  static const md5WithRsa = '1.2.840.113549.1.1.4';
  static const ecPublicKey = '1.2.840.10045.2.1';
  static const ecdsaWithSha1 = '1.2.840.10045.4.1';
  static const ecdsaWithSha224 = '1.2.840.10045.4.3.1';
  static const ecdsaWithSha256 = '1.2.840.10045.4.3.2';
  static const ecdsaWithSha384 = '1.2.840.10045.4.3.3';
  static const ecdsaWithSha512 = '1.2.840.10045.4.3.4';

  // Curves.
  static const secp256r1 = '1.2.840.10045.3.1.7';
  static const secp384r1 = '1.3.132.0.34';
  static const secp521r1 = '1.3.132.0.35';
  static const brainpoolP256r1 = '1.3.36.3.3.2.8.1.1.7';
  static const brainpoolP384r1 = '1.3.36.3.3.2.8.1.1.11';
  static const brainpoolP512r1 = '1.3.36.3.3.2.8.1.1.13';

  // Content encryption.
  static const aes128Cbc = '2.16.840.1.101.3.4.1.2';
  static const aes192Cbc = '2.16.840.1.101.3.4.1.22';
  static const aes256Cbc = '2.16.840.1.101.3.4.1.42';
  static const aes128Gcm = '2.16.840.1.101.3.4.1.6';
  static const aes192Gcm = '2.16.840.1.101.3.4.1.26';
  static const aes256Gcm = '2.16.840.1.101.3.4.1.46';
  static const desEde3Cbc = '1.2.840.113549.3.7';
  static const rc2Cbc = '1.2.840.113549.3.2';

  // Key wrap and key agreement (RFC 3394, 5753).
  static const aes128Wrap = '2.16.840.1.101.3.4.1.5';
  static const aes192Wrap = '2.16.840.1.101.3.4.1.25';
  static const aes256Wrap = '2.16.840.1.101.3.4.1.45';
  static const ecdhSha1Kdf = '1.3.133.16.840.63.0.2';
  static const ecdhSha224Kdf = '1.3.132.1.11.0';
  static const ecdhSha256Kdf = '1.3.132.1.11.1';
  static const ecdhSha384Kdf = '1.3.132.1.11.2';
  static const ecdhSha512Kdf = '1.3.132.1.11.3';
  static const ecdhCofactorSha1Kdf = '1.3.133.16.840.63.0.3';
  static const ecdhCofactorSha224Kdf = '1.3.132.1.14.0';
  static const ecdhCofactorSha256Kdf = '1.3.132.1.14.1';
  static const ecdhCofactorSha384Kdf = '1.3.132.1.14.2';
  static const ecdhCofactorSha512Kdf = '1.3.132.1.14.3';

  // PKCS#5 and PKCS#12.
  static const pbes2 = '1.2.840.113549.1.5.13';
  static const pbkdf2 = '1.2.840.113549.1.5.12';
  static const pbmac1 = '1.2.840.113549.1.5.14';
  static const hmacSha1 = '1.2.840.113549.2.7';
  static const hmacSha224 = '1.2.840.113549.2.8';
  static const hmacSha256 = '1.2.840.113549.2.9';
  static const hmacSha384 = '1.2.840.113549.2.10';
  static const hmacSha512 = '1.2.840.113549.2.11';
  static const pbeSha1Rc4128 = '1.2.840.113549.1.12.1.1';
  static const pbeSha1Rc440 = '1.2.840.113549.1.12.1.2';
  static const pbeSha13Des = '1.2.840.113549.1.12.1.3';
  static const pbeSha12Des = '1.2.840.113549.1.12.1.4';
  static const pbeSha1Rc2128 = '1.2.840.113549.1.12.1.5';
  static const pbeSha1Rc240 = '1.2.840.113549.1.12.1.6';
  static const keyBag = '1.2.840.113549.1.12.10.1.1';
  static const pkcs8ShroudedKeyBag = '1.2.840.113549.1.12.10.1.2';
  static const certBag = '1.2.840.113549.1.12.10.1.3';
  static const x509Certificate = '1.2.840.113549.1.9.22.1';

  // X.509 names and extensions.
  static const commonName = '2.5.4.3';
  static const surname = '2.5.4.4';
  static const serialNumber = '2.5.4.5';
  static const country = '2.5.4.6';
  static const locality = '2.5.4.7';
  static const state = '2.5.4.8';
  static const organization = '2.5.4.10';
  static const organizationalUnit = '2.5.4.11';
  static const givenName = '2.5.4.42';
  static const domainComponent = '0.9.2342.19200300.100.1.25';
  static const subjectKeyIdentifier = '2.5.29.14';
  static const keyUsage = '2.5.29.15';
  static const subjectAltName = '2.5.29.17';
  static const basicConstraints = '2.5.29.19';
  static const certificatePolicies = '2.5.29.32';
  static const authorityKeyIdentifier = '2.5.29.35';
  static const extKeyUsage = '2.5.29.37';
  static const nameConstraints = '2.5.29.30';
  static const policyConstraints = '2.5.29.36';
  static const inhibitAnyPolicy = '2.5.29.54';
  static const crlDistributionPoints = '2.5.29.31';
  static const authorityInfoAccess = '1.3.6.1.5.5.7.1.1';
  static const anyExtendedKeyUsage = '2.5.29.37.0';
  static const emailProtection = '1.3.6.1.5.5.7.3.4';

  // Revocation (RFC 6960 OCSP, RFC 5280 CRLs).
  static const ocspSigning = '1.3.6.1.5.5.7.3.9';
  static const accessOcsp = '1.3.6.1.5.5.7.48.1';
  static const accessCaIssuers = '1.3.6.1.5.5.7.48.2';
  static const ocspBasic = '1.3.6.1.5.5.7.48.1.1';
  static const ocspNonce = '1.3.6.1.5.5.7.48.1.2';
  static const ocspNoCheck = '1.3.6.1.5.5.7.48.1.5';
  static const crlNumber = '2.5.29.20';
  static const crlReason = '2.5.29.21';
  static const invalidityDate = '2.5.29.24';
  static const deltaCrlIndicator = '2.5.29.27';
  static const issuingDistributionPoint = '2.5.29.28';
  static const certificateIssuer = '2.5.29.29';
  static const freshestCrl = '2.5.29.46';
}
