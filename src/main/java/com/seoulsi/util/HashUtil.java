package com.seoulsi.util;

import java.security.AlgorithmParameters;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.KeySpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;


public final class HashUtil {

	
	private HashUtil() {
	}
	
	/**
	 * MD5
	 * 
	 * @param str
	 * @return
	 */
	public static String md5(String str){
		String MD5 = ""; 
		try{
			MessageDigest md = MessageDigest.getInstance("MD5"); 
			md.update(str.getBytes()); 
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			MD5 = sb.toString();
		}catch(NoSuchAlgorithmException e){
			e.printStackTrace(); 
			MD5 = null; 
		}
		return MD5;
	}

	/**
	 * SHA256
	 * 
	 * @param str
	 * @return
	 */
	public static String sha256(String str) {
		String SHA = "";
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			SHA = null;
		}
		return SHA;
	}
	public static String encryptAES(String msg,byte[] salt, byte[] iv, int iterationCount,int keySize, String key) throws Exception {

	    byte[] saltBytes = salt;

	    // Password-Based Key Derivation function 2
	    SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
	    // 70000번 해시하여 256 bit 길이의 키를 만든다.
	    PBEKeySpec spec = new PBEKeySpec(key.toCharArray(), salt, iterationCount, keySize);

	    SecretKey secretKey = factory.generateSecret(spec);
	    SecretKeySpec secret = new SecretKeySpec(secretKey.getEncoded(), "AES");

	    // 알고리즘/모드/패딩
	    // CBC : Cipher Block Chaining Mode
	    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	    cipher.init(Cipher.ENCRYPT_MODE, secret);
	    AlgorithmParameters params = cipher.getParameters();

	    // Initial Vector(1단계 암호화 블록용)
	    byte[] ivBytes = iv;
	    byte[] encryptedTextBytes = cipher.doFinal(msg.getBytes("UTF-8"));
	    byte[] buffer = new byte[saltBytes.length + ivBytes.length + encryptedTextBytes.length];
	    System.arraycopy(saltBytes, 0, buffer, 0, saltBytes.length);
	    System.arraycopy(ivBytes, 0, buffer, saltBytes.length, ivBytes.length);
	    System.arraycopy(encryptedTextBytes, 0, buffer, saltBytes.length + ivBytes.length, encryptedTextBytes.length);

	    return Base64.encodeBase64String(buffer);

	}

	public static String decryptAES(String salt, String iv, String passphrase, String ciphertext, int iterationCount, int keySize) throws Exception {        
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
        KeySpec spec = new PBEKeySpec(passphrase.toCharArray(), Hex.decodeHex(salt.toCharArray()), iterationCount, keySize);
        SecretKey key = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");        
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, key, new IvParameterSpec(Hex.decodeHex(iv.toCharArray())));        
        byte[] decrypted = cipher.doFinal(Base64.decodeBase64(ciphertext));        
        return new String(decrypted, "UTF-8");
    }
}