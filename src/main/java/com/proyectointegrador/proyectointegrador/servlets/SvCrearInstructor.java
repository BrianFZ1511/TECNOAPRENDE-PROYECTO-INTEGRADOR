package com.proyectointegrador.proyectointegrador.servlets;

import Logica.Afiliado;
import Logica.Controladora;
import Logica.Instructor;
import Logica.PasswordUtil;
import Logica.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SvCrearInstructor", urlPatterns = {"/SvCrearInstructor"})
public class SvCrearInstructor extends HttpServlet {

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

        String idAfiliado = request.getParameter("idAfiliado");
        String contrasena = request.getParameter("contrasena");

        if (idAfiliado == null || idAfiliado.trim().isEmpty()
                || contrasena == null || contrasena.trim().isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("listaInstructores.jsp").forward(request, response);
            return;
        }

        idAfiliado = idAfiliado.trim().toUpperCase();

        if (idAfiliado.length() > 20) {
            request.setAttribute("error", "El ID de afiliado no puede superar 20 caracteres.");
            request.getRequestDispatcher("listaInstructores.jsp").forward(request, response);
            return;
        }

        if (contrasena.length() < 8 || contrasena.length() > 200) {
            request.setAttribute("error", "La contraseña debe tener entre 8 y 200 caracteres.");
            request.getRequestDispatcher("listaInstructores.jsp").forward(request, response);
            return;
        }

        Controladora control = new Controladora();

        Afiliado afiliado = control.traerAfiliado(idAfiliado);
        if (afiliado == null) {
            request.setAttribute("error", "El ID de afiliado no existe en el padrón.");
            request.getRequestDispatcher("listaInstructores.jsp").forward(request, response);
            return;
        }

        if (!"instructor".equalsIgnoreCase(afiliado.getTipoPersona())
                && !"administrador".equalsIgnoreCase(afiliado.getTipoPersona())) {
            request.setAttribute("error",
                "El afiliado seleccionado no tiene tipo 'instructor' o 'administrador'.");
            request.getRequestDispatcher("listaInstructores.jsp").forward(request, response);
            return;
        }

        if (control.afiliadoTieneUsuario(idAfiliado)) {
            request.setAttribute("error", "Este ID de afiliado ya tiene una cuenta registrada.");
            request.getRequestDispatcher("listaInstructores.jsp").forward(request, response);
            return;
        }

        String contrasenaHasheada = PasswordUtil.hashear(contrasena);

        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setAfiliado(afiliado);
        nuevoUsuario.setContrasena(contrasenaHasheada);
        nuevoUsuario.setRol("instructor");
        nuevoUsuario.setRequiereCambioContrasena(true);

        control.crearUsuario(nuevoUsuario);

        Usuario usuarioGuardado = control.buscarUsuarioPorIdAfiliado(idAfiliado);
        if (usuarioGuardado != null) {
            Instructor nuevoInstructor = new Instructor();
            nuevoInstructor.setUsuario(usuarioGuardado);
            control.crearInstructor(nuevoInstructor);
        }

        response.sendRedirect("listaInstructores.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Crear instructor desde padrón de afiliados con verificación de sesión y CSRF";
    }
}
