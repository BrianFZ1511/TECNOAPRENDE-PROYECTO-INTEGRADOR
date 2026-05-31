package com.proyectointegrador.proyectointegrador.servlets;

import Logica.Afiliado;
import Logica.Controladora;
import Logica.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SvAfiliados", urlPatterns = {"/SvAfiliados"})
public class SvAfiliados extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("listaAfiliados.jsp");
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

        String accion = request.getParameter("accion");
        if (accion == null) {
            response.sendRedirect("listaAfiliados.jsp");
            return;
        }

        Controladora control = new Controladora();

        switch (accion) {
            case "crear":
                crearAfiliado(request, response, control, session);
                break;
            case "editar":
                editarAfiliado(request, response, control, session);
                break;
            case "eliminar":
                eliminarAfiliado(request, response, control, session);
                break;
            default:
                response.sendRedirect("listaAfiliados.jsp");
        }
    }

    private void crearAfiliado(HttpServletRequest request, HttpServletResponse response,
            Controladora control, HttpSession session)
            throws IOException, ServletException {

        String idAfiliado  = sanitizar(request.getParameter("idAfiliado"));
        String nombre      = sanitizar(request.getParameter("nombre"));
        String apellidos   = sanitizar(request.getParameter("apellidos"));
        String tipoPersona = sanitizar(request.getParameter("tipoPersona"));

        if (idAfiliado.isEmpty() || nombre.isEmpty() || apellidos.isEmpty() || tipoPersona.isEmpty()) {
            session.setAttribute("afiliadoError", "Todos los campos son obligatorios.");
            response.sendRedirect("listaAfiliados.jsp");
            return;
        }

        if (!tipoPersona.matches("afiliado|instructor|administrador")) {
            session.setAttribute("afiliadoError", "Tipo de persona no válido.");
            response.sendRedirect("listaAfiliados.jsp");
            return;
        }

        if (idAfiliado.length() > 20 || nombre.length() > 100 || apellidos.length() > 100) {
            session.setAttribute("afiliadoError", "Uno o más campos exceden la longitud permitida.");
            response.sendRedirect("listaAfiliados.jsp");
            return;
        }

        if (control.existeAfiliado(idAfiliado)) {
            session.setAttribute("afiliadoError", "Ya existe un afiliado con ese ID.");
            response.sendRedirect("listaAfiliados.jsp");
            return;
        }

        Afiliado nuevo = new Afiliado();
        nuevo.setIdAfiliado(idAfiliado.toUpperCase());
        nuevo.setNombre(nombre);
        nuevo.setApellidos(apellidos);
        nuevo.setTipoPersona(tipoPersona);
        control.crearAfiliado(nuevo);

        session.setAttribute("afiliadoOk", "Afiliado '" + idAfiliado.toUpperCase() + "' creado correctamente.");
        response.sendRedirect("listaAfiliados.jsp");
    }

    private void editarAfiliado(HttpServletRequest request, HttpServletResponse response,
            Controladora control, HttpSession session)
            throws IOException, ServletException {

        String idAfiliado  = sanitizar(request.getParameter("idAfiliado"));
        String nombre      = sanitizar(request.getParameter("nombre"));
        String apellidos   = sanitizar(request.getParameter("apellidos"));
        String tipoPersona = sanitizar(request.getParameter("tipoPersona"));

        if (idAfiliado.isEmpty() || nombre.isEmpty() || apellidos.isEmpty() || tipoPersona.isEmpty()) {
            session.setAttribute("afiliadoError", "Todos los campos son obligatorios.");
            response.sendRedirect("listaAfiliados.jsp");
            return;
        }

        if (!tipoPersona.matches("afiliado|instructor|administrador")) {
            session.setAttribute("afiliadoError", "Tipo de persona no válido.");
            response.sendRedirect("listaAfiliados.jsp");
            return;
        }

        Afiliado af = control.traerAfiliado(idAfiliado);
        if (af == null) {
            session.setAttribute("afiliadoError", "Afiliado no encontrado.");
            response.sendRedirect("listaAfiliados.jsp");
            return;
        }

        af.setNombre(nombre);
        af.setApellidos(apellidos);
        af.setTipoPersona(tipoPersona);
        control.editarAfiliado(af);

        session.setAttribute("afiliadoOk", "Afiliado '" + idAfiliado + "' actualizado correctamente.");
        response.sendRedirect("listaAfiliados.jsp");
    }

    private void eliminarAfiliado(HttpServletRequest request, HttpServletResponse response,
            Controladora control, HttpSession session)
            throws IOException, ServletException {

        String idAfiliado = sanitizar(request.getParameter("idAfiliado"));

        if (idAfiliado.isEmpty()) {
            session.setAttribute("afiliadoError", "ID de afiliado requerido.");
            response.sendRedirect("listaAfiliados.jsp");
            return;
        }

        if (control.afiliadoTieneUsuario(idAfiliado)) {
            session.setAttribute("afiliadoError",
                "No se puede eliminar: el afiliado '" + idAfiliado + "' ya tiene una cuenta de usuario vinculada.");
            response.sendRedirect("listaAfiliados.jsp");
            return;
        }

        control.borrarAfiliado(idAfiliado);
        session.setAttribute("afiliadoOk", "Afiliado '" + idAfiliado + "' eliminado.");
        response.sendRedirect("listaAfiliados.jsp");
    }

    private String sanitizar(String valor) {
        if (valor == null) return "";
        return valor.trim().replaceAll("[<>\"']", "");
    }

    @Override
    public String getServletInfo() {
        return "Gestión CRUD de afiliados";
    }
}
