/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
@WebServlet({"/log", "/reg","/home","/profile","/password","/c_profile","/deals","/help","/thanks","/y_cart"}) // Ánh xạ nhiều URL
public class ControllerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
         
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/log":
                request.getRequestDispatcher("login.jsp").forward(request, response);
                break;
            case "/reg":
                request.getRequestDispatcher("register.jsp").forward(request, response);
                break;  
            case "/home":
            request.getRequestDispatcher("home.jsp").forward(request, response);
            break;   
            case "/profile":
                request.getRequestDispatcher("account.jsp").forward(request, response);
                break;  
            case "/password":
            request.getRequestDispatcher("updatepassword.jsp").forward(request, response);
            break;
            case "/c_profile":
                request.getRequestDispatcher("updateaccount.jsp").forward(request, response);
                break;  
            case "/deals":
                request.getRequestDispatcher("Uudai.jsp").forward(request, response);
                break;  
            case "/help":
            request.getRequestDispatcher("hotro.jsp").forward(request, response);
            break;  
            case "/thanks":
                request.getRequestDispatcher("thanks.jsp").forward(request, response);
            break;  
            case "/y_cart":
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            break;
            default:               
                break;
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
