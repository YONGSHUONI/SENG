package cloud.clouddb.cloud_user;

import cloud.clouddb.*;
import cloud.clouddb.cloud_account.*;
import cloud.clouddb.cloud_role.*;

import java.io.File;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.*;
import java.util.*;


public class UserDAO {
	private ConnectionDAO connect = new ConnectionDAO();
	private Collection<UserDB> db_collection = new ArrayList<UserDB>();
	
	// get username known id
	public String getUsernameFromId(int user_id){
		String username = null;
		Connection connection = this.connect.getConnection();
		String sql = "select * from Users where id = ?"; 
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, user_id);
			ResultSet results = statement.executeQuery();
			while(results.next()){
				username = results.getString("username");
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}
		return username;
	}
	
	
	// get user all information from his username
	public User getUser(String username, User user){
		Connection connection = this.connect.getConnection();
		String sql = "select * from Users where username = ?"; 
		user.setUsername(username);
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, username);
			ResultSet results = statement.executeQuery();
			
			while(results.next()){
				user.setId(results.getInt("id"));
			//	user.setPassword(results.getString("password"));
				if(results.getString("email")!=null){user.setEmail(results.getString("email"));}
				if(results.getString("surname")!=null){user.setSurname(results.getString("surname"));}
				if(results.getString("forename")!=null){user.setForename(results.getString("forename"));}
				if(results.getInt("account_id")!=0){user.setAccount_id(results.getInt("account_id"));}
				if(results.getInt("role_id")!=0){user.setRole_id(results.getInt("role_id"));}
				user.setUser_icon(results.getString("user_icon"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}
		return user;
	}
	
	// Login, verify password with username
	public boolean verifyPassword(User user){
		Connection connection = this.connect.getConnection();
		String sql = "select * from Users where username = ?"; 
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, user.getUsername());
			ResultSet results = statement.executeQuery();
			
			while(results.next()){
				if(results.getString("password").equals(user.getPassword())){
					return true;
				}
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}
		return false;
	}
	
	// Sign up, use for check if username is same
	public boolean ifSameUsername(User user){
		Connection connection = this.connect.getConnection();
		String sql = "select * from Users where username = ?"; 
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, user.getUsername());
			ResultSet results = statement.executeQuery();
			
			if(results.next()){
				return false;
			}else{
				return true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			this.connect.closeConnection(connection);
		}
		return false;
	}
	
	//Sign up, store new user. 
	 public boolean storeUser(User user){
	        Connection connection = this.connect.getConnection();
	        String sql = "insert into Users (password,username,email,surname,forename,user_icon) values(?,?,?,?,?,?)";
	         
	        // replace placeholder ?
	        try {
	            PreparedStatement statement = connection.prepareStatement(sql);
	            statement.setString(1, user.getPassword());
	            statement.setString(2, user.getUsername());
	            statement.setString(3, user.getEmail());
	            statement.setString(4, user.getSurname());
	            statement.setString(5, user.getForename());
	            Random r = new Random();
	            int i = r.nextInt(10)+1;
	            String icon_url = "usericon"+File.separator+Integer.toString(i)+".jpg";
	            statement.setString(6, icon_url);
//	          statement.setInt(6, user.getAccount_id());
//	          statement.setInt(7, user.getRole_id());
	            // execute insert statement
	            statement.execute();
	             
	            sql = "select * from Users where username = ?";
	            statement = connection.prepareStatement(sql);
	            statement.setString(1, user.getUsername());
	            ResultSet results = statement.executeQuery();
	             
	            while(results.next()){
	                user.setId(results.getInt("id"));
	            }
	             
	            AccountDAO acc = new AccountDAO();
	            RoleDAO role = new RoleDAO();
	            user.setAccount_id(acc.initAccount(user.getId()));
	            user.setRole_id(role.initRole(user.getId()));
	             
	            sql = "UPDATE Users SET account_id = ?, role_id = ? where id = ?";
	            statement = connection.prepareStatement(sql);
	            statement.setInt(1,user.getAccount_id());
	            statement.setInt(2, user.getRole_id());
	            statement.setInt(3, user.getId());
	            statement.execute();
	             
	            return true;
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally{
	            this.connect.closeConnection(connection);
	        }
	        return false;
	    }
	 
	// by Sefa
		 public void updateUserPassword(User user) throws NoSuchAlgorithmException, InvalidKeySpecException
	     {
	    	 Connection connection = this.connect.getConnection();
	         String sql ="UPDATE Users SET password = ? where username = ?";
	         user.setPassword(Hash.hashFunction(user.getPassword()));
	         
	         try
	         {
	        	 PreparedStatement statement = connection.prepareStatement(sql);
	        	 
	        	 
	        	 statement = connection.prepareStatement(sql);
	             statement.setString(1, user.getPassword());
	             statement.setString(2, user.getUsername());
	           
	             statement.executeUpdate(); 
	         }
	         catch (Exception e) {
	        	 e.printStackTrace();
	        	 
			}
	         finally {
	        	 this.connect.closeConnection(connection);
			}
	        
	     }
		 
		 
		 public User updateUser(User user)
	     {
	    	 Connection connection = this.connect.getConnection();
	         String sql ="UPDATE Users SET forename = ? , surname = ? , email = ? where username = ?";
	         
	         try
	         {
	        	 PreparedStatement statement = connection.prepareStatement(sql);
	        	 
	        	 
	        	 statement = connection.prepareStatement(sql);
	             statement.setString(1, user.getForename());
	             statement.setString(2, user.getSurname());
	             statement.setString(3, user.getEmail());
	             statement.setString(4, user.getUsername());
	             statement.setString(5, user.getUser_icon());
	           
	             statement.executeUpdate(); 
	             
	             user = getUser(user.getUsername(), user);
	         }
	         catch (Exception e) {
	        	 e.printStackTrace();
	        	 
			}
	         finally {
	        	 this.connect.closeConnection(connection);
			}
	         return user;
	        
	     }
		 
		 public User insertUserDB(String username , String dbName)
		 {
			 Connection connection = this.connect.getConnection();
			 String sql ="insert into User_db (dbname , user_id) values (?, ?)";
			 User user = new User();
			  try
		      {
				 
				 user.setUsername(username);
		         user = getUser(username, user);
		         PreparedStatement statement = connection.prepareStatement(sql);
	        	 
	        	 
	        	 statement = connection.prepareStatement(sql);
	             statement.setString(1, dbName);
	             statement.setInt(2, user.getId());	 
	             
	             statement.execute();
		      }
			  catch (Exception e) {
				// TODO: handle exception
			}
			finally {
		        	 this.connect.closeConnection(connection);
			}
			  
			 return user;
			 
		 }
		 
		 public Collection<UserDB> getdbCollection(int user_id)
		 {
			 Connection connection = this.connect.getConnection();
				String sql = "Select * from User_db where user_id= ?";
				try {
					PreparedStatement statement = connection.prepareStatement(sql);
					statement.setInt(1, user_id);
					ResultSet results = statement.executeQuery();
					
					while(results.next()){
						UserDB userdb = new UserDB();
						userdb.setDbName(results.getString("dbname"));
						
						this.db_collection.add(userdb);
						}
				}catch (SQLException e) {
					e.printStackTrace();
				}finally{
					connect.closeConnection(connection);
				}
				
				return this.db_collection;
		 }
		 
		 


}
