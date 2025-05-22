
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

@WebServlet(name = "UpdatePassword", urlPatterns = {"/updatepassword"})
public class UpdatePassword extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdatePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdatePassword at " + request.getContextPath() + "</h1>");
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

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra mật khẩu cũ có đúng không
        if (!currentUser.getPassword().equals(oldPassword)) {
            request.setAttribute("error", "Mật khẩu cũ không đúng.");
            request.getRequestDispatcher("updatepassword.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu mới và xác nhận có khớp không
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận không trùng khớp.");
            request.getRequestDispatcher("updatepassword.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu
        currentUser.setPassword(newPassword);
        UserDAO dao = new UserDAO();
        boolean success = dao.updatePassword(currentUser.getUsername(), currentUser.getPassword());

        if (success) {
            request.setAttribute("message", "Cập nhật mật khẩu thành công.");
        } else {
            request.setAttribute("error", "Đã xảy ra lỗi, vui lòng thử lại sau.");
        }

        request.getRequestDispatcher("updatepassword.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
