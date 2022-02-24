package com.seoulsi.util;

import org.apache.xmlbeans.impl.util.Base64;

public class SeedScrtyUtil {
    private static String PBUserKey = "sdot12345678sdot";
    private static String DEFAULT_IV = "1234567890123456";

    /**
     * <PRE>
     * 1. MethodName : encryptCBCText
     * 2. ClassName  : SeedScrtyUtil
     * 3. Comment   : 암호화
     * </PRE>
     *
     * @param orgnStr
     * @return
     */
    public static String encryptCBCText(String orgnStr) {
        String encryptStr = "";

        try {

            byte[] enc = KISA_SEED_CBC.SEED_CBC_Encrypt(PBUserKey.getBytes(), DEFAULT_IV.getBytes(),
                    orgnStr.getBytes("UTF-8"), 0, orgnStr.getBytes("UTF-8").length);
            encryptStr = new String(Base64.encode(enc), "UTF-8");

        } catch (Exception e) {
           e.printStackTrace();
        }

        return encryptStr;
    }

    /**
     * <PRE>
     * 1. MethodName : decryptCBCText
     * 2. ClassName  : SeedScrtyUtil
     * 3. Comment   : 복호화
     * </PRE>
     *
     * @param orgnStr
     * @return
     */
    public static String decryptCBCText(String orgnStr) {
        String decryptStr = "";

        try {
            byte[] str = Base64.decode(orgnStr.getBytes("UTF-8"));
            byte[] dec = KISA_SEED_CBC.SEED_CBC_Decrypt(PBUserKey.getBytes(), DEFAULT_IV.getBytes(), str, 0,
                    str.length);
            decryptStr = new String(dec, "UTF-8");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return decryptStr;
    }

}
