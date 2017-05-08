package cloud.clouddb.cloud_app;

public class App{
	private String App_name;
	private int App_id;
	private int Developer_id;
	private int use_times;
	private double price;
	private String Url;
	private String iconUrl;
	private String description;
	private String firstImportApp;
	private String secondImportApp;
	private String thirdImportApp;
	
	public String getFirstImportApp() {
		return firstImportApp;
	}
	public void setFirstImportApp(String firstImportApp) {
		this.firstImportApp = firstImportApp;
	}
	public String getSecondImportApp() {
		return secondImportApp;
	}
	public void setSecondImportApp(String secondImportApp) {
		this.secondImportApp = secondImportApp;
	}
	public String getThirdImportApp() {
		return thirdImportApp;
	}
	public void setThirdImportApp(String thirdImportApp) {
		this.thirdImportApp = thirdImportApp;
	}
	public String getApp_name() {
		return App_name;
	}
	public void setApp_name(String app_name) {
		this.App_name = app_name;
	}
	public int getApp_id() {
		return App_id;
	}
	public void setApp_id(int app_id) {
		this.App_id = app_id;
	}
	public int getDeveloper_id() {
		return Developer_id;
	}
	public void setDeveloper_id(int developer_id) {
		this.Developer_id = developer_id;
	}
	public int getUse_times() {
		return use_times;
	}
	public void setUse_times(int use_times) {
		this.use_times = use_times;
	}
	public String getUrl() {
		return Url;
	}
	public void setUrl(String url) {
		this.Url = url;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getIconUrl() {
		return iconUrl;
	}
	public void setIconUrl(String imageUrl) {
		this.iconUrl = imageUrl;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public String toString()
	{
		String str=this.App_id +" - "+ this.App_name;
		return str;
	}
}
