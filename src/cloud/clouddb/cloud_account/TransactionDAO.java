package cloud.clouddb.cloud_account;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import cloud.clouddb.ConnectionDAO;

// 

public class TransactionDAO {
	ConnectionDAO connect = new ConnectionDAO();
	public void insertTransaction(double diamond, int userId){		
		Connection connection = this.connect.getConnection();
		Date date = new Date();
		long time = date.getTime();
		String sql = "insert into Transaction (amount,user_id, date) values(?,?,?)"; 
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setDouble(1, diamond);
			statement.setInt(2, userId);
			statement.setLong(3, time);
			statement.execute();			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}
	}
	public Collection<Transaction> searchTransaction(int userId){
		Connection connection = this.connect.getConnection();
		String sql = "select * from Transaction where user_id = ? order by date DESC";
		
		Collection<Transaction> transaction_collection = new ArrayList<Transaction>();
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, userId);
			ResultSet results = statement.executeQuery();
			while(results.next()){
				Transaction t = new Transaction();
				double amount = (double)Math.round(results.getDouble("amount")*100)/100;
				t.setAmout(amount);
				t.setUser_id(userId);
				t.setId(results.getInt("id"));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/ HH:mm:ss");
				String timeStr = sdf.format(results.getLong("date"));
				t.setDate(timeStr);
				transaction_collection.add(t);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}
		return transaction_collection;
	}
	public Collection<Transaction> searchPlatformTransaction(){
		Connection connection = this.connect.getConnection();
		String sql = "select * from Transaction where user_id = 0 order by date DESC";
		
		Collection<Transaction> transaction_collection = new ArrayList<Transaction>();
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet results = statement.executeQuery();
			while(results.next()){
				Transaction t = new Transaction();
				t.setAmout(results.getDouble("amount"));
				t.setUser_id(0);
				t.setId(results.getInt("id"));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/ HH:mm:ss");
				String timeStr = sdf.format(results.getLong("date"));
				t.setDate(timeStr);
				transaction_collection.add(t);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}
		return transaction_collection;
	}
	
	public static void main(String[] args){
		TransactionDAO td = new TransactionDAO();
		double a = 1;
		td.insertTransaction(-a, 0);
		
		Collection<Transaction> trancaction_collection = td.searchTransaction(0);
		if(trancaction_collection!=null){
			Iterator t_c = trancaction_collection.iterator();
			while(t_c.hasNext()){
				Transaction t = (Transaction)t_c.next();
				System.out.println(t.getAmout());
			}
		}
	}
	
	
}
