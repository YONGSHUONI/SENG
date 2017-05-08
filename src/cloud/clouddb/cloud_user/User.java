package cloud.clouddb.cloud_user;
import java.io.*;
import java.net.*;
import java.util.*;

public class User {
	private int id;
	private String username;
	private String password;
	
	private String email;
    private String surname;
    private String forename;
    private int account_id;
    private int role_id;
    private String user_icon;
    

	public String getUser_icon() {
		return user_icon;
	}
	public void setUser_icon(String user_icon) {
		this.user_icon = user_icon;
	}
	private boolean valid;
	
	
	public User() {
		super();
	}
	public User(int id,String username, String password) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
	}
	
	public User(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}
	
	public User(String username,String password, String forename, String surname, String email,int account_id,int role_id)
	{
		super();
		this.forename=forename;
		this.surname=surname;
		this.email=email;
		this.role_id=role_id;
		this.account_id=account_id;
	}
	
	public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getSurname() {
        return surname;
    }
    public void setSurname(String surname) {
        this.surname = surname;
    }
    public String getForename() {
        return forename;
    }
    public void setForename(String forename) {
        this.forename = forename;
    }
    public int getAccount_id() {
        return account_id;
    }
    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }
    public int getRole_id() {
        return role_id;
    }
    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }
	
	public boolean isValid()
	{ 
		return valid;
	} 
	public void setValid(boolean newValid) 
	{
		valid = newValid;
	}

}
