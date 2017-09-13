package com.thinkgem.jeesite;

import java.io.UnsupportedEncodingException;
import java.util.Arrays;

import org.apache.shiro.codec.Base64;
import org.springframework.util.Base64Utils;

import com.thinkgem.jeesite.common.security.Cryptos;
import com.thinkgem.jeesite.common.utils.Encodes;

public class Test {

	public static void main(String[] args) throws UnsupportedEncodingException {
    	//System.out.println(Cryptos.aesDecrypt("4AvVhmFLUs0KTA3Kprsdag=="));
    	System.out.println(Encodes.encodeBase64(Arrays.copyOf("jeesite".getBytes("UTF-8"), 16)));
        System.out.println(Base64Utils.encodeToString("jeesite".getBytes("UTF-8")));
	}

}