/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.DAOTokenForget;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.TokenForgetPassword;
import model.User;
import model.resetService;

/**
 *
 * @author DELL
 */
@WebServlet(name="ResetPassword", urlPatterns={"/resetPassword"})
public class ResetPassword extends HttpServlet {
    DAOTokenForget DAOToken = new DAOTokenForget();
    UserDAO userDAO = new UserDAO();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ResetPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPassword at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String token = request.getParameter("token");    
        HttpSession session = request.getSession(); 
        if(token != null){
            TokenForgetPassword tokenForgetPassword = DAOToken.getTokenPassword(token);
            resetService ser = new resetService();
            if(tokenForgetPassword==null){
                request.setAttribute("mess", "Tài khoản không hợp lệ.");
                request.getRequestDispatcher("requestPassword.jsp").forward(request, response);
                return;
            }
            if(tokenForgetPassword.isUsed()){
                request.setAttribute("mess", "Tài khoản đã được sử dụng.");
                request.getRequestDispatcher("requestPassword.jsp").forward(request, response);
                return;
            }
            if(ser.isExpireTime(tokenForgetPassword.getExpiryTime())){
                request.setAttribute("mess", "Link kích hoạt đã hết hiệu lực vui lòng thử lại.");
                request.getRequestDispatcher("requestPassword.jsp").forward(request, response);
                return;
            }
            User user = userDAO.getUserById(tokenForgetPassword.getUser_id());
            request.setAttribute("email", user.getEmail());
            session.setAttribute("token", tokenForgetPassword.getToken());
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        }else {
            request.getRequestDispatcher("requestPassword.jsp").forward(request, response);
        }
       
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        //validate password
        if(!password.equals(confirmPassword)){
            request.setAttribute("mess", "Mật Khẩu không khớp");
            request.setAttribute("email", email);
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }
            HttpSession session = request.getSession();
            String tokenStr = (String)session.getAttribute("token");
            resetService ser = new resetService();
            TokenForgetPassword tokenForgetPassword = DAOToken.getTokenPassword(tokenStr);
            if(tokenForgetPassword==null){
                request.setAttribute("mess", "Tài khoản không hợp lệ.");
                request.getRequestDispatcher("requestPassword.jsp").forward(request, response);
                return;
            }
            if(tokenForgetPassword.isUsed()){
                request.setAttribute("mess", "Tài khoản đã được sử dụng.");
                request.getRequestDispatcher("requestPassword.jsp").forward(request, response);
                return;
            }
            if(ser.isExpireTime(tokenForgetPassword.getExpiryTime())){
                request.setAttribute("mess", "Link kích hoạt đã hết hiệu lực vui lòng thử lại.");
                request.getRequestDispatcher("requestPassword.jsp").forward(request, response);
                return;
            }
        
        //update is used of token
        tokenForgetPassword.setToken(tokenStr);
        tokenForgetPassword.setUsed(true);
        userDAO.updatePassword2(email, password);
        DAOToken.updateStatus(tokenForgetPassword);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
