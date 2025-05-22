/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author DELL
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");

    String fullname = request.getParameter("fullname");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String phonenumber = request.getParameter("phonenumber");
    String password = request.getParameter("password");
    String address = request.getParameter("address");
    String status = "1";
    Integer roleId = 2;

    // Kiểm tra dữ liệu đầu vào
    if (fullname == null || fullname.trim().isEmpty() ||
        username == null || username.trim().isEmpty() ||
        email == null || email.trim().isEmpty() ||
        password == null || password.trim().isEmpty()) {

        request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc.");
        request.getRequestDispatcher("register.jsp").forward(request, response);
        return;
    }

    User user = new User(fullname, username, email, phonenumber, password, address, status, roleId);
    UserDAO dao = new UserDAO();

    try {
        if (dao.registerUser(user)) {
            response.sendRedirect("login.jsp");
        } else {
            System.out.println("Đăng ký thất bại: username/email có thể đã tồn tại.");
            request.setAttribute("error", "Tên tài khoản đã tồn tại hoặc có lỗi.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
