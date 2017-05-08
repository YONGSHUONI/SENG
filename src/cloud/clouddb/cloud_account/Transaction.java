package cloud.clouddb.cloud_account;

public class Transaction{
	private int id;
	private int user_id;
	private double amout;
	private String date;
	
	public double getAmout() {
		return amout;
	}
	public void setAmout(double amout) {
		this.amout = amout;
	}

	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
}
