package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "UpdatePassword", urlPatterns = {"/updatepassword"})
public class UpdatePassword extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("updatepassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!currentUser.getPassword().equals(oldPassword)) {
            request.setAttribute("error", "Mật khẩu cũ không đúng.");
            request.getRequestDispatcher("updatepassword.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận không trùng khớp.");
            request.getRequestDispatcher("updatepassword.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        boolean success = dao.updatePassword(currentUser.getUsername(), newPassword);

        if (success) {
            request.setAttribute("message", "Cập nhật mật khẩu thành công. Bạn sẽ được đăng xuất sau ");
            // Store user ID in request to avoid NullPointerException in JSP
            request.setAttribute("userId", currentUser.getId());
            request.getRequestDispatcher("updatepassword.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đã xảy ra lỗi, vui lòng thử lại sau.");
            request.getRequestDispatcher("updatepassword.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles password update and logout";
    }
}