package com.proyectointegrador.proyectointegrador.servlets;

import Logica.Controladora;
import Logica.PasswordUtil;
import Logica.Usuario;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SvInicioSesion", urlPatterns = {"/SvInicioSesion"})
public class SvInicioSesion extends HttpServlet {

    private static final int MAX_INTENTOS = 5;
    private static final long TIEMPO_BLOQUEO_MS = 15 * 60 * 1000L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login_registro.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String idAfiliado = request.getParameter("idAfiliado");
        String contrasena = request.getParameter("contrasena");

        if (idAfiliado == null || idAfiliado.trim().isEmpty()
                || contrasena == null || contrasena.trim().isEmpty()) {
            request.setAttribute("error", "Por favor, complete todos los campos.");
            request.getRequestDispatcher("login_registro.jsp").forward(request, response);
            return;
        }

        idAfiliado = idAfiliado.trim().toUpperCase();

        if (idAfiliado.length() > 20 || contrasena.length() > 200) {
            request.setAttribute("error", "Datos inválidos.");
            request.getRequestDispatcher("login_registro.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(true);

        Integer intentosFallidos = (Integer) session.getAttribute("intentosFallidos");
        Long tiempoBloqueo = (Long) session.getAttribute("tiempoBloqueo");

        if (intentosFallidos == null) intentosFallidos = 0;

        if (tiempoBloqueo != null) {
            long tiempoRestante = tiempoBloqueo - System.currentTimeMillis();
            if (tiempoRestante > 0) {
                long minutosRestantes = (tiempoRestante / 1000 / 60) + 1;
                request.setAttribute("error",
                    "Demasiados intentos fallidos. Intente de nuevo en " + minutosRestantes + " minuto(s).");
                request.getRequestDispatcher("login_registro.jsp").forward(request, response);
                return;
            } else {
                session.removeAttribute("intentosFallidos");
                session.removeAttribute("tiempoBloqueo");
                intentosFallidos = 0;
            }
        }

        Controladora control = new Controladora();
        Usuario usuarioEncontrado = control.buscarUsuarioPorIdAfiliado(idAfiliado);

        boolean credencialesCorrectas = false;
        if (usuarioEncontrado != null) {
            credencialesCorrectas = PasswordUtil.verificar(contrasena, usuarioEncontrado.getContrasena());
        }

        if (credencialesCorrectas) {
            if ("admin".equalsIgnoreCase(usuarioEncontrado.getRol())) {
                request.setAttribute("error", "Acceso Denegado.");
                request.getRequestDispatcher("login_registro.jsp").forward(request, response);
                return;
            }

            session.invalidate();
            session = request.getSession(true);

            session.setAttribute("usuarioLogueado", usuarioEncontrado);

            String csrfToken = UUID.randomUUID().toString();
            session.setAttribute("csrfToken", csrfToken);

            session.setMaxInactiveInterval(30 * 60);

            if (usuarioEncontrado.isRequiereCambioContrasena()) {
                response.sendRedirect("cambiarContrasena.jsp");
                return;
            }

            switch (usuarioEncontrado.getRol()) {
                case "instructor":
                    response.sendRedirect("panelInstructor.jsp");
                    break;
                case "usuario":
                default:
                    response.sendRedirect("index.jsp");
                    break;
            }

        } else {
            intentosFallidos++;
            session.setAttribute("intentosFallidos", intentosFallidos);

            if (intentosFallidos >= MAX_INTENTOS) {
                session.setAttribute("tiempoBloqueo",
                    System.currentTimeMillis() + TIEMPO_BLOQUEO_MS);
                request.setAttribute("error",
                    "Cuenta bloqueada temporalmente por demasiados intentos. Intente en 15 minutos.");
            } else {
                int intentosRestantes = MAX_INTENTOS - intentosFallidos;
                request.setAttribute("error",
                    "ID de afiliado o contraseña incorrectos. Intentos restantes: " + intentosRestantes);
            }

            request.getRequestDispatcher("login_registro.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Inicia sesión por IDAFILIADO con protección BCrypt y anti-fuerza bruta";
    }
}
