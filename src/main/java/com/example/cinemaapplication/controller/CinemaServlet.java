package com.example.cinemaapplication.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CinemaServlet", value = "")
public class CinemaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "login":
                showLoginForm(req, resp);
                break;
            default:
                showHomePage(req, resp);
        }
    }

    private void showHomePage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("view/home-page.jsp").forward(req, resp);
    }

    private void showLoginForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("view/login.jsp").forward(request, response);
    }



    //  ============================================================================================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "login":
                processLogin(req, resp);
                break;
            case "signup":
                processSignup(req, resp);
                break;
            case "logout":
                logout(req, resp);
                break;
            default:
                showHomePage(req, resp);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        try {
            response.sendRedirect("/");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void processLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        request.getRequestDispatcher("view/login.jsp").forward(request, response);
    }

    private void processSignup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty() || 
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("message", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("message", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
            return;
        }

        request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
        request.getRequestDispatcher("view/login.jsp").forward(request, response);
    }
}
