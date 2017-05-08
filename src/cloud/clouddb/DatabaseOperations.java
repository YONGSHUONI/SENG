package cloud.clouddb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Statement;

import cloud.clouddb.cloud_user.UserDAO;

public class DatabaseOperations {
	
	private ConnectionDAO connect = new ConnectionDAO();
	
	public boolean checkDbNameExist(String dbName){
		Connection connection = this.connect.getConnection();
        String sql = "select * from User_db where dbname = ?"; 
        try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1,dbName);
			ResultSet results = statement.executeQuery();
			while(results.next()){
				return true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
        
		return false;
	}
	
	
	
	//Check the given user name exist or not as a mysql user
	public boolean checkDbUserExist(String username)
	{
		Connection connection = this.connect.getConnection();
        String sql = "SELECT User from mysql.user where User = ?"; 
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            ResultSet results = statement.executeQuery();
             
            if(results.next()){
                return true;
            }else{
                return false;
            }
             
        } catch (SQLException e) {
            e.printStackTrace();
        } finally{
            this.connect.closeConnection(connection);
        }
        return true;
	}
	
	//Create the database according to given database name
	public void createDatabase(String dbName, String uname)
	{
		Connection connection = this.connect.getConnection();
		String sql ="CREATE DATABASE "+dbName;
		
		try
		{
			Statement statement =(Statement) connection.createStatement();
			
			statement.executeUpdate(sql);
			
			UserDAO userdao = new UserDAO();
			userdao.insertUserDB(uname, dbName);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			this.connect.closeConnection(connection);
		}
	}
	
	//Create mysql user according to given user name
	public void createUser(String username)
	{
		Connection connection = this.connect.getConnection();
		String sql= "CREATE USER '" +username+"'@'%'";

		try
		{
			Statement statement =null;
			statement=(Statement) connection.createStatement();
			statement.executeUpdate(sql);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			this.connect.closeConnection(connection);
		}
	}
	
	//Assign the given database privileges to given user 
	public void assignPriviliges(String dbName , String username)
	{
		Connection connection = this.connect.getConnection();
		username = "'"+username +"'@'%'";   //******************************************** change from 'localhost' to '%'
		String sql= "GRANT CREATE,SELECT,INSERT,UPDATE,DELETE,DROP ON " +dbName+ ".* to "+username;

		try
		{
			Statement statement =null;
			statement=(Statement) connection.createStatement();
			statement.executeUpdate(sql);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			this.connect.closeConnection(connection);
		}

         
	}

}
