package common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SecurityUtil {
	public String encryptSHA256(String str){
    String sha = "";
    try{
       MessageDigest sh = MessageDigest.getInstance("SHA-256");
       
       // 숫자 솔트키 추가하기 (자릿수를 맞추는 게 좋음)
       // int salt = (int)(Math.random()*100) + 1;

       // 여섯자리로 맞춘 솔트키
       // int salt = (int)(Math.random()*(999999+1-100000) + 100000);
       // str += salt;
        
       sh.update(str.getBytes());
       byte byteData[] = sh.digest();
       StringBuffer sb = new StringBuffer();
       for(int i = 0 ; i < byteData.length ; i++){
           sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
       }
       sha = sb.toString();
   }catch(NoSuchAlgorithmException e){
       System.out.println("Encrypt Error - NoSuchAlgorithmException");
       sha = null;
   }
   return sha;
 } 
}
