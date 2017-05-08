package cloud.clouddb;

import java.sql.*;
import java.util.*;

public class ConnectionDAO {
	// create connection
	public Connection getConnection(){
		String connectionUrl = "jdbc:mysql://127.0.0.1:3306/SENG_DB";
		Connection connection = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(connectionUrl, "root", "team2");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
