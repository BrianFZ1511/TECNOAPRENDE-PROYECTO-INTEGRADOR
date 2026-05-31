package com.proyectointegrador.proyectointegrador.servlets;

import Logica.Controladora;
import Logica.PasswordUtil;
import Logica.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SvEditarUsuario", urlPatterns = {"/SvEditarUsuario"})
public class SvEditarUsuario extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("panelAdmin.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        Usuario admin = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        if (admin == null || !"admin".equalsIgnoreCase(admin.getRol())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Acceso denegado.");
            return;
        }

        String csrfToken = request.getParameter("csrfToken");
        String csrfEnSession = (String) session.getAttribute("csrfToken");
        if (csrfToken == null || !csrfToken.equals(csrfEnSession)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Token CSRF inválido.");
            return;
        }

        String idStr = request.getParameter("id");
        String nuevaContrasena = request.getParameter("contrasena");
        String requiereCambioStr = request.getParameter("requiereCambio");

        if (idStr == null) {
            response.sendRedirect("listaUsuarios.jsp");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect("listaUsuarios.jsp");
            return;
        }

        Controladora control = new Controladora();
        Usuario usuario = control.traerUsuario(id);

        if (usuario != null) {
            if (nuevaContrasena != null && !nuevaContrasena.trim().isEmpty()) {
                if (nuevaContrasena.length() >= 8 && nuevaContrasena.length() <= 200) {
                    usuario.setContrasena(PasswordUtil.hashear(nuevaContrasena));
                }
            }
            if ("true".equals(requiereCambioStr)) {
                usuario.setRequiereCambioContrasena(true);
            } else if ("false".equals(requiereCambioStr)) {
                usuario.setRequiereCambioContrasena(false);
            }
            control.editarUsuario(usuario);
        }

        response.sendRedirect("listaUsuarios.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Editar contraseña de usuario con verificación de sesión y CSRF";
    }
}
