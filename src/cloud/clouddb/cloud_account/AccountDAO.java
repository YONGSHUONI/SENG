package cloud.clouddb.cloud_account;

import cloud.clouddb.*;
import cloud.clouddb.cloud_user.*;

import java.sql.*;
import java.util.*;

public class AccountDAO{
	ConnectionDAO connect = new ConnectionDAO();
	TransactionDAO td = new TransactionDAO();
	
	public int initAccount(int user_id){
		Account account = new Account();
		account.setBalance(50);
		
		Connection connection = this.connect.getConnection();
		
		try {
			String sql = "insert into Account (balance,user_id) values(50,?)"; 
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1,user_id);
			statement.execute();
			
			sql = "select * from Account where user_id = ?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1,user_id);
			ResultSet results = statement.executeQuery();
			while(results.next()){
				account.setId(results.getInt("id"));
				break;
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}		
		return account.getId();	
	}
	public boolean addDia(double diamond, int userId){
        Connection connection = this.connect.getConnection();
        String sql = "select * from Users where id = ?"; 
        
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            ResultSet results = statement.executeQuery();
             
            while(results.next()){
                int account_id = results.getInt("account_id");
                sql = "select * from Account where id = ?";
                try {
                    statement = connection.prepareStatement(sql);
                    statement.setInt(1, account_id);
                    ResultSet results_account = statement.executeQuery();
                     
                    while(results_account.next()){
                        double balance = results_account.getDouble("balance");
                        balance += diamond;
                        balance = (double)Math.round(balance*100)/100;
                        td.insertTransaction(diamond, userId);
                        
                        sql = "UPDATE Account SET balance = ? where id = ?";
                        statement = connection.prepareStatement(sql);
                        statement.setDouble(1, balance);
                        statement.setInt(2, account_id);
                        statement.execute();
                        
                    }
                    return true;
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            this.connect.closeConnection(connection);
        }
        return false;
       
    }
	
	public boolean addDia(double diamond, User user){
        Connection connection = this.connect.getConnection();
        String sql = "select * from Users where username = ?"; 
        
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, user.getUsername());
            ResultSet results = statement.executeQuery();
             
            while(results.next()){
                int account_id = results.getInt("account_id");
                sql = "select * from Account where id = ?";
                 
                try {
                    statement = connection.prepareStatement(sql);
                    statement.setInt(1, account_id);
                    ResultSet results_account = statement.executeQuery();
                     
                    while(results_account.next()){
                        double balance = results_account.getDouble("balance");
                        balance += diamond;
                        balance = (double)Math.round(balance*100)/100;
                        td.insertTransaction(diamond, user.getId()); 
                        
                        sql = "UPDATE Account SET balance = ? where id = ?";
                        statement = connection.prepareStatement(sql);
                        statement.setDouble(1, balance);
                        statement.setInt(2, account_id);
                        statement.execute();
                        
                    }
                    return true;
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                 
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            this.connect.closeConnection(connection);
        }
        return false;
       
    }
	public void addPlatformAccount(double diamond){
		Connection connection = this.connect.getConnection();
		String sql = "select * from Account where user_id = 0";
        
        try {
        	
        	PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet results_account = statement.executeQuery();
             
            while(results_account.next()){
                double balance = results_account.getDouble("balance");
                balance += diamond;
                balance = (double)Math.round(balance*100)/100;
                td.insertTransaction(diamond, 0);
                
                sql = "UPDATE Account SET balance = ? where user_id = 0";
                statement = connection.prepareStatement(sql);
                statement.setDouble(1, balance);
                statement.execute();
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            this.connect.closeConnection(connection);
        }
	}
	
	// true reduce balance successfully, false balance not enough
	public boolean deductDia(double diamond, int userId){
		Connection connection = this.connect.getConnection();
		String sql = "select * from Users where id = ?"; 
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, userId);
			ResultSet results = statement.executeQuery();
			
			while(results.next()){
				int account_id = results.getInt("account_id");
				sql = "select * from Account where id = ?";
				
				try {
					statement = connection.prepareStatement(sql);
					statement.setInt(1, account_id);
					ResultSet results_account = statement.executeQuery();
					
					while(results_account.next()){
						double balance = results_account.getDouble("balance");
						if(balance>=diamond){
							balance -= diamond;
							balance = (double)Math.round(balance*100)/100;
							
							sql = "UPDATE Account SET balance = ? where id = ?";
							statement = connection.prepareStatement(sql);
							statement.setDouble(1, balance);
							statement.setInt(2, account_id);
							statement.execute();
							td.insertTransaction(-diamond, userId);
							return true;
						}else{
							return false;
						}
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}	
		return false;
	}
	
	public double getBalanceById(int userId){
		Connection connection = this.connect.getConnection();
		String sql = "select balance from Account where user_id = ?"; 
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, userId);
			ResultSet results = statement.executeQuery();
			
			while(results.next()){
				return results.getDouble("balance");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}	
		return 0;
	}
//	public double getBalanceByUser(User user){
//		Connection connection = this.connect.getConnection();
//		String sql = "select balance from Account where user_id = ?"; 
//		
//		try {
//			PreparedStatement statement = connection.prepareStatement(sql);
//			statement.setInt(1, user.getId());
//			ResultSet results = statement.executeQuery();
//			
//			while(results.next()){
//				return results.getInt("balance");
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}finally{
//			this.connect.closeConnection(connection);
//		}	
//		return 0;
//	}
	
	
	
	public void clearAccount(int user_id){
		Connection connection = this.connect.getConnection();
		String sql = "delete from Account where user_id = ?"; 
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1,user_id);
			statement.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			this.connect.closeConnection(connection);
		}	
	}
	
	public static void main(String [] args){
//		User user = new User();
//		user.setUsername("niyongshuo");
//		user.setId(12);
//		AccountDAO a = new AccountDAO();
//		
//		System.out.println(a.getBalanceById(user));
	}	
}
