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
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author manhdung
 */
@WebServlet(name = "UpdateAccountServlet", urlPatterns = {"/updateaccount"})
public class UpdateAccountServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateAccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAccountServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phonenumber");
        String address = request.getParameter("address");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser != null) {

            currentUser.setFullname(fullname);
            currentUser.setEmail(email);
            currentUser.setPhonenumber(phone);
            currentUser.setAddress(address);

            // Cập nhật thông tin vào DB (nếu có)
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.updateUser(currentUser);

            if (success) {
                session.setAttribute("user", currentUser);
                response.sendRedirect("account.jsp");
            } else {
                response.getWriter().write("Cập nhật thất bại. Vui lòng thử lại sau.");
            }
        } else {
            response.sendRedirect("login.jsp");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
