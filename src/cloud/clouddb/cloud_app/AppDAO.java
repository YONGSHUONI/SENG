package cloud.clouddb.cloud_app;

import cloud.clouddb.ConnectionDAO;
import cloud.clouddb.cloud_user.User;

import java.sql.*;
import java.util.*;

public class AppDAO {
	public int getDeveloperIdByAppName(String appName){
		Connection connection = this.connect.getConnection();
		String sql = "select developer_id from Apps where app_name = ?"; 
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, appName);
			ResultSet results = statement.executeQuery();
			while(results.next()){
				return results.getInt("developer_id");
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}
		return 0;
	}
	
	public App getApp(int id, App app){
		Connection connection = this.connect.getConnection();
		String sql = "select * from Apps where id = ?"; 
		app.setApp_id(id);
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, id);
			ResultSet results = statement.executeQuery();
			
			while(results.next()){
			//	user.setPassword(results.getString("password"));
				app.setApp_name(results.getString("app_name"));
				app.setUrl(results.getString("url"));
				app.setDeveloper_id(results.getInt("developer_id"));
				app.setUse_times(results.getInt("use_times"));
				app.setPrice(results.getInt("price"));
				app.setIconUrl(results.getString("iconUrl"));
				app.setFirstImportApp(results.getString("firstImportApp"));
				app.setSecondImportApp(results.getString("secondImportApp"));
				app.setThirdImportApp(results.getString("thirdImportApp"));
				if(results.getString("description")!=null){app.setDescription(results.getString("description"));}					
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}
		return app;
	}
	
	// false-> no same name, true-> have same name
	public boolean isExistedName(String app_name){
		Connection connection  = this.connect.getConnection();
		String sql = "select * from Apps where app_name = ?";
		try{
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, app_name);
			ResultSet results = statement.executeQuery();
			while(results.next()){
				return true;
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			connect.closeConnection(connection);
		}
		
		return false;
	}	
	
	
	public Collection<App> getAllApps(){
		this.searchApps();
		return this.app_collection;
	}
	
	private void searchApps(){
		Connection connection = this.connect.getConnection();
		String sql_query = "Select * from Apps order by use_times DESC";
		try {
			PreparedStatement statement = connection.prepareStatement(sql_query);
			ResultSet results = statement.executeQuery();
			
			while(results.next()){
				App new_app = new App();
				new_app.setApp_id(results.getInt("id"));
				new_app.setApp_name(results.getString("app_name"));
				new_app.setDeveloper_id(results.getInt("developer_id"));
				new_app.setUse_times(results.getInt("use_times"));
				new_app.setPrice(results.getInt("price"));
				new_app.setUrl(results.getString("url"));
				new_app.setDescription(results.getString("description"));
				new_app.setIconUrl(results.getString("iconUrl"));
				new_app.setFirstImportApp(results.getString("firstImportApp"));
				new_app.setSecondImportApp(results.getString("secondImportApp"));
				new_app.setThirdImportApp(results.getString("thirdImportApp"));
				this.app_collection.add(new_app);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			connect.closeConnection(connection);
		}
	}
	
	public void addApp(App app){
		Connection connection = this.connect.getConnection();
		String sql_query = "Insert into Apps (app_name, developer_id, url, price, use_times,description,iconUrl,firstImportApp,"
				+ "secondImportApp,thirdImportApp) values (?,?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement statement = connection.prepareStatement(sql_query);
			statement.setString(1, app.getApp_name());
			statement.setInt(2, app.getDeveloper_id());
			statement.setString(3, app.getUrl());
			statement.setDouble(4, app.getPrice());
			statement.setInt(5, app.getUse_times());
			statement.setString(6, app.getDescription());
			statement.setString(7, app.getIconUrl());
			statement.setString(8, app.getFirstImportApp());
			statement.setString(9, app.getSecondImportApp());
			statement.setString(10, app.getThirdImportApp());
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			connect.closeConnection(connection);
		}
	}
	// add 1 use time per use
	public void addUseTime(int id){
		Connection connection = this.connect.getConnection();
		String sql = "update Apps set use_times = use_times+1 where id = ?";
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, id);
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			connect.closeConnection(connection);
		}
	}
	
	
	public void deleteApp(int id){
		Connection connection = this.connect.getConnection();
		String sql_query = "Delete from Apps where id = ?";
		try {
			PreparedStatement statement = connection.prepareStatement(sql_query);
			statement.setInt(1, id);
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			connect.closeConnection(connection);
		}	
	}
	
	
	private ConnectionDAO connect = new ConnectionDAO();
	private Collection<App> app_collection = new ArrayList<App>();
	
	
	
	public static void main(String [ ] args){

	}
}

