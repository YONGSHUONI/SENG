package cloud.servlet;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cloud.clouddb.cloud_user.*;

/**
 * Servlet implementation class ForgetPasswordServlet
 */
@WebServlet("/ForgetPasswordServlet")
public class ForgetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgetPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException
    {
        
    }
    
    
    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        System.out.println("hi");
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class",
                  "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        
        Session session = Session.getDefaultInstance(props,
                                                     new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("sengplatformservice@gmail.com","sengteam2");
            }
        });
        
        try {
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("sengplatformservice@gmail.com"));
            
            UserDAO userdao=new UserDAO();
            User user =new User();
            user=userdao.getUser(request.getParameter("username"), user);
            String email=user.getEmail();
            String url = "http://143.167.9.237:8080/SENG/conPass.html?"+ URLEncoder.encode(request.getParameter("username"),"UTF-8")+"=&";
            // receiver address
            message.setRecipients(Message.RecipientType.TO,
                                  InternetAddress.parse(email));
            
            message.setSubject("Testing Subject");
            message.setText("Dear SENG user,\n\n" 
            				+"Please go to this link to change your password: \n"
            				+url+ 
                            "\n\n Thank you for using SENG, we always be responsible for your best experience here.");
            
            Transport.send(message);
            response.setContentType("text/plain");
            response.getWriter().write("{}");
            
            
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
        
        
    }
    
}
