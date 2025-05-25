/* 
 * Document   : LoginServlet
 * Created on : May 14, 2025
 * Author     : DELL
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (java.io.PrintWriter out = response.getWriter()) {
            out.println("");
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String source = request.getParameter("source"); // Get the source of the login attempt

        try {
            UserDAO dao = new UserDAO();
            User user = dao.check(username, password);

            if (user != null) {
                request.getSession().setAttribute("user", user);
                if (user.getRoleId() == 2) {
                    response.sendRedirect("home.jsp"); // User bình thường
                } else if (user.getRoleId() == 1) {
                    response.sendRedirect("management"); // Admin
                }
            } else {
                if ("modal".equals(source)) {
                    response.sendRedirect("home.jsp?error=true");
                } else {
                    response.sendRedirect("login.jsp?error=true");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}