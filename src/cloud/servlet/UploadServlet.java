package cloud.servlet;

import java.io.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;

import java.util.Enumeration;
//import java.util.Enumeration;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;
import cloud.clouddb.cloud_app.*;
import cloud.clouddb.cloud_user.*;

/**
 * Servlet implementation class UploadServlet
 */
@WebServlet("/UploadServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, maxFileSize=1024*1024*10, maxRequestSize=1024*1024*50)
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//private static final String SAVE_DIR = "uploadedFiles";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// get app parameters from request
		HttpSession session = request.getSession();
		AppDAO appDAO = new AppDAO();
	    App newApp = new App();
	    String app_name = request.getParameter("AppsName");
	    String firstImportApp = request.getParameter("firstImportApp");
	    String secondImportApp = request.getParameter("secondImportApp");
	    String thirdImportApp = request.getParameter("thirdImportApp");
	    if (appDAO.isExistedName(app_name)||app_name.equals("null")){
	    	session.setAttribute("existAppName",app_name);
	    	response.sendRedirect("upload.jsp");
	    }else if(firstImportApp.equals("")==false && appDAO.isExistedName(firstImportApp)==false){
	    	session.setAttribute("noFirstApp",firstImportApp);
	    	response.sendRedirect("upload.jsp");
	    }else if(secondImportApp.equals("")==false && appDAO.isExistedName(secondImportApp)==false){
	    	session.setAttribute("noSecondApp",secondImportApp);
	    	response.sendRedirect("upload.jsp");
	    }else if(thirdImportApp.equals("")==false && appDAO.isExistedName(thirdImportApp)==false){
	    	session.setAttribute("noSecondApp",thirdImportApp);
	    	response.sendRedirect("upload.jsp");
	    }else{
		    newApp.setApp_name(app_name);
		    newApp.setPrice(Integer.parseInt(request.getParameter("price")));
		    newApp.setDescription(request.getParameter("description"));
		    newApp.setUse_times(0);
		    newApp.setFirstImportApp(firstImportApp);
		    newApp.setSecondImportApp(secondImportApp);
		    newApp.setThirdImportApp(secondImportApp);
		    //get user object from session
		    User developer = (User)session.getAttribute("currentSessionUser");
		    newApp.setDeveloper_id(developer.getId());
			//String appPath = request.getServletContext().getContextPath();	
		    // Create path to the directory to save uploaded file
			// ********************************************************************************************************************
			//String savePath = "appPath"+File.separator+request.getParameter("AppsName");  
			String appPath = request.getServletContext().getRealPath("");
			String savePath = "/var/lib/tomcat8/webapps"+File.separator+app_name; 
			String iconsPath = appPath + File.separator+"icons";
			String appIconPath = iconsPath +File.separator+app_name;
			File iconsDir = new File(iconsPath);
			File fileSaveDir = new File(savePath);
			File appIconDir = new File(appIconPath);
			// Create the save directory for application if it does not exist
			if (!fileSaveDir.exists())
				fileSaveDir.mkdir();
			// Create the save directory for icon images if it does not exist
			if(!iconsDir.exists()) iconsDir.mkdir();
			if(!appIconDir.exists()) appIconDir.mkdir();
			// get icon image and store into the server
			Part iconPart = request.getPart("icon_file");
			String iconName = extractFileName(iconPart);
			String iconUrl = appIconPath + File.separator + iconName;
			iconPart.write(iconUrl);
			
			// get app file, store it to the server and extract
			Part appPart = request.getPart("app_file");
			String fileName = extractFileName(appPart);
			String appUrl = savePath + File.separator + fileName;
			appPart.write(appUrl);
			jarExtractor(appUrl,savePath);

			newApp.setUrl("../"+app_name+File.separator);
			newApp.setIconUrl("icons"+File.separator+app_name+File.separator+iconName);
			appDAO.addApp(newApp);
			
			response.sendRedirect("index.jsp");
	    }
	}
	private String extractFileName(Part part) {
	    String contentDisp = part.getHeader("content-disposition");
	    String[] items = contentDisp.split(";");
	    for (String s : items) {
	      if (s.trim().startsWith("filename")) {
	        return s.substring(s.indexOf("=") + 2, s.length()-1);
	      }
	    }
	    return "";
	  }


	  	// Main method extracts a jarfile to a set of
	  	// directories under the target/path/ directory

	  	public void jarExtractor(String jarpath, String destdir) throws IOException {
	  		JarFile jarfile = new JarFile(jarpath);   
		  	for (Enumeration<JarEntry> iter = jarfile.entries(); 
		  			iter.hasMoreElements();) {   
		  		JarEntry entry = iter.nextElement();   
		  	    System.out.println("Processing: " + entry.getName());  
		  	    File outfile = new File(destdir, entry.getName());
		  	    if (! outfile.exists())
		  	    	outfile.getParentFile().mkdirs(); // create dir structure

		  	    // method body continued on next slide...
		  	    // continuation of main method

		  	    if (! entry.isDirectory()) {
		  	      InputStream instream = jarfile.getInputStream(entry);
		  	      FileOutputStream outstream = new FileOutputStream(outfile);
		  	      while (instream.available() > 0) { 
		  	          outstream.write(instream.read());
		  	      }
		  	      outstream.close();
		  	      instream.close();
		  	    }  // end if
		  	  }  // end for
		  	  jarfile.close();
		  	}  //  end class


}