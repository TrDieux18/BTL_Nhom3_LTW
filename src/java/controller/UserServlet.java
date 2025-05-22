package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import dal.UserDAO;
import java.util.List;

@WebServlet(name = "UserServlet", urlPatterns = {"/userServlet"})
public class UserServlet extends HttpServlet {

    private UserDAO dao;

    @Override
    public void init() throws ServletException {
        dao = new UserDAO(); // Khởi tạo DAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            String idStr = request.getParameter("id");
            String fullName = request.getParameter("fullName");
            String userName = request.getParameter("userName");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");
            String roleIdStr = request.getParameter("roleId");
            String status = request.getParameter("status");

            int roleId = Integer.parseInt(roleIdStr);

            User user = new User();
            user.setFullname(fullName);
            user.setUsername(userName);
            user.setPassword(password);
            user.setEmail(email);
            user.setPhonenumber(phoneNumber);
            user.setAddress(address);
            user.setStatus(status);
            user.setRoleId(roleId);

            if (idStr != null && !idStr.isEmpty()) {
                user.setId(Integer.parseInt(idStr));
                dao.update(user);
            } else {
                dao.insert(user);
            }

            response.sendRedirect("management");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi thêm/cập nhật người dùng: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String id = request.getParameter("id");

        UserDAO userDAO = new UserDAO();

        try {
            if ("edit".equals(action)) {
                if (id != null && !id.isEmpty()) {
                    int userId = Integer.parseInt(id);
                    User getUser = userDAO.getUserById(userId); // Hàm này bạn cần viết thêm
                    if (getUser != null) {
                        request.setAttribute("getUser", getUser);
                        request.getRequestDispatcher("addUser.jsp").forward(request, response);
                        return;
                    } else {
                        response.sendRedirect("management");
                        return;
                    }
                } else {
                    response.sendRedirect("management");
                    return;
                }
            } else if ("delete".equals(action)) {
                if (id != null && !id.isEmpty()) {
                    int userId = Integer.parseInt(id);
                    userDAO.delete(userId); // Hàm này bạn cũng cần viết thêm
                }
                response.sendRedirect("management");
                return;
            } else if ("search".equals(action)) {
                // Đọc params tìm kiếm
                String fullname = request.getParameter("fullname");
                String username = request.getParameter("username");
                String address = request.getParameter("address");
                String roleIdStr = request.getParameter("roleId");
                String sortBy = request.getParameter("sortBy");

                Integer roleId = null;
                if (roleIdStr != null && !roleIdStr.isEmpty()) {
                    try {
                        roleId = Integer.parseInt(roleIdStr);
                    } catch (NumberFormatException e) {
                        roleId = null;
                    }
                }

                // Gọi hàm tìm kiếm trong DAO, bạn cần tự viết hàm này phù hợp
                List<User> users = userDAO.searchUsers(fullname, username, address, roleId, sortBy);

                request.setAttribute("users", users);

                // Set tab để UI biết hiển thị tab customer
                request.setAttribute("tab", "customer");

                request.getRequestDispatcher("management.jsp").forward(request, response);
                return;
            } else {
                response.sendRedirect("management");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý yêu cầu: " + e.getMessage());
        }
    }

}
