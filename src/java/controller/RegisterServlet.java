package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        System.out.println("da vao day");
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String status = "1";
        int roleId = 2;

        StringBuilder jsonResponse = new StringBuilder("{");
        StringBuilder errors = new StringBuilder();
        boolean hasErrors = false;

        if (fullname == null || fullname.trim().isEmpty()) {
            if (errors.length() > 0) errors.append(",");
            errors.append("\"fullname\":\"Họ và tên không hợp lệ.\"");
            hasErrors = true;
        }
        if (email == null || email.trim().isEmpty() || !isValidEmail(email)) {
            if (errors.length() > 0) errors.append(",");
            errors.append("\"email\":\"Email không hợp lệ.\"");
            hasErrors = true;
        }
        if (phonenumber == null || phonenumber.trim().isEmpty() || !isValidPhone(phonenumber)) {
            if (errors.length() > 0) errors.append(",");
            errors.append("\"phonenumber\":\"Số điện thoại không hợp lệ\"");
            hasErrors = true;
        }
        if (username == null || username.trim().isEmpty() || !isValidUsername(username)) {
            if (errors.length() > 0) errors.append(",");
            errors.append("\"username\":\"Tên tài khoản không hợp lệ\"");
            hasErrors = true;
        }
        if (password == null || password.trim().isEmpty() || !isValidPassword(password)) {
            if (errors.length() > 0) errors.append(",");
            errors.append("\"password\":\"Mật khẩu phải bao gồm 6 kí tự, chữ hoa, chữ thường, chữ số và kí tự đặc biệt.\"");
            hasErrors = true;
        }
        if (address == null || address.trim().isEmpty()) {
            if (errors.length() > 0) errors.append(",");
            errors.append("\"address\":\"Địa chỉ không hợp lệ.\"");
            hasErrors = true;
        }

        if (hasErrors) {
            jsonResponse.append("\"status\":\"error\",\"errors\":{").append(errors).append("}}");
            try (PrintWriter out = response.getWriter()) {
                out.print(jsonResponse.toString());
            }
            return;
        }
     
        User user = new User(fullname, username, email, phonenumber, password, address, status, roleId);
        UserDAO dao = new UserDAO();
        String dbError = dao.registerUser(user);
        System.out.println("da nhay den 1");
        if (dbError == null) {
            jsonResponse.append("\"status\":\"success\"}");
        } else {
            errors = new StringBuilder();
            if (dbError.contains("Tên tài khoản đã tồn tại")) {
                errors.append("\"username\":\"").append(dbError).append("\"");
            } else if (dbError.contains("Email đã tồn tại")) {
                errors.append("\"email\":\"").append(dbError).append("\"");
            } else if (dbError.contains("Số điện thoại đã tồn tại")) {
                errors.append("\"phonenumber\":\"").append(dbError).append("\"");
            } else {
                errors.append("\"general\":\"").append(dbError).append("\"");
            }
            jsonResponse.append("\"status\":\"error\",\"errors\":{").append(errors).append("}}");
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResponse.toString());
        }
    }

    // Hàm kiểm tra email hợp lệ
    private boolean isValidEmail(String email) {
        return email != null && email.trim().matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }

    // Hàm kiểm tra số điện thoại hợp lệ
    private boolean isValidPhone(String phone) {
        return phone != null && phone.trim().matches("^0\\d{9}$");
    }

    // Hàm kiểm tra username hợp lệ
    private boolean isValidUsername(String username) {
        return username != null && username.trim().matches("^[a-zA-Z0-9_]+$");
    }

    // Hàm kiểm tra mật khẩu hợp lệ
    private boolean isValidPassword(String password) {
        return password != null && password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*(),.?\":{}|])[A-Za-z\\d!@#$%^&*(),.?\":{}|]{6,}$");
    }
}