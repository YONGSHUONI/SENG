package cloud.clouddb.cloud_user;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class Hash {
	
	public static String hashFunction(String pswd) throws NoSuchAlgorithmException, InvalidKeySpecException
	{
		//Created a byte array
		byte[] salt = new byte[16];
		
		//code for byte array.
		String str="team2cloudcomput";
		salt=str.getBytes();
		
		//KeySpec created for encryption
		KeySpec spec = new PBEKeySpec(pswd.toCharArray(), salt, 65536, 128);
		
		//Encryption algorithm
		SecretKeyFactory f = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		//hash value
		byte[] hash = f.generateSecret(spec).getEncoded();
		Base64.Encoder enc = Base64.getEncoder();
		//encode and return it.
		pswd=enc.encodeToString(hash);
		return pswd;
	}

}
