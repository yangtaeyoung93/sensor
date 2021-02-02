package com.seoulsi.configuration;

import java.util.HashMap;
import java.util.Map;

public class UserRole {
    
    private Map<String, String> userRole = new HashMap<String, String>();
    
    public void setRole() {
    	this.userRole.put("SU0001", "SU");
    	this.userRole.put("SA0001", "SA");
    	this.userRole.put("UN0001", "UN");
    	this.userRole.put("UC0001", "UC");
    	this.userRole.put("AT0001", "AT");
    }
    
    public String getRole(String c) {
    	this.setRole();
    	return this.userRole.get(c);
    }

}
