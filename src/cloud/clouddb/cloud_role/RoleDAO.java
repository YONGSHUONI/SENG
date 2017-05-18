package cloud.clouddb.cloud_role;

import cloud.clouddb.*;
import cloud.clouddb.cloud_account.Account;
import cloud.clouddb.cloud_user.*;

import java.sql.*;
import java.util.*;

public class RoleDAO{
	private ConnectionDAO connect = new ConnectionDAO();
	
	// initialize role, return role id
	public int initRole(int user_id){
		Role role = new Role();
		role.setRole_name("developer");
		
		Connection connection = this.connect.getConnection();
		
		try {
			String sql = "insert into Roles (role_name,user_id) values('developer',?)"; 
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1,user_id);
			statement.execute();
			
			sql = "select * from Roles where user_id = ?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1,user_id);
			ResultSet results = statement.executeQuery();
			while(results.next()){
				role.setId(results.getInt("id"));
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}		
		return role.getId();	
	}
	
	
	public boolean setRole(User user, String rolename){
		Connection connection = this.connect.getConnection();
		String sql = "select * from Users where id = ?"; 
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, user.getId());
			ResultSet results = statement.executeQuery();
			
			while(results.next()){
				sql = "UPDATE Roles SET role_name = ? where user_id = ?";
				statement = connection.prepareStatement(sql);
				statement.setString(1, rolename);
				statement.setInt(2, results.getInt("id"));
				statement.execute();
			}
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}
		return false;
	}
	
	public static void main(String[] args){
		User user = new User();
		user.setUsername("sefa");
		user.setRole_id(1);
		user.setId(2);
		
		Role role = new Role();
		role.setUser_id(2);
		
		RoleDAO roleDAO = new RoleDAO();
		System.out.println(roleDAO.initRole(3));
	}
	
}