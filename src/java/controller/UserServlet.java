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
                user.setId(idStr);
                dao.update(user);
//                request.setAttribute("message", "Cập nhật người dùng thành công.");
                User getUser = dao.getUserById(idStr);

                request.setAttribute("message", "Cập nhật người dùng thành công.");

                request.setAttribute("getUser", getUser);
            } else {
                dao.insert(user);
                request.setAttribute("message", "Thêm người dùng thành công.");
            }

            request.getRequestDispatcher("addUser.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi thêm/cập nhật người dùng: " + e.getMessage());
            request.getRequestDispatcher("addUser.jsp").forward(request, response);
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
                    String userId = id;
                    User getUser = userDAO.getUserById(userId);
                    if (getUser != null) {
                        request.setAttribute("currentUser", getUser);
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
                    String userId = id;
                    userDAO.delete(userId);
                }
                response.sendRedirect("management");
                return;
            } else if ("search".equals(action)) {
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

                List<User> users = userDAO.searchUsers(fullname, username, address, roleId, sortBy);

                request.setAttribute("users", users);
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