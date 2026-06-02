package com.proyectointegrador.proyectointegrador.servlets;

import Logica.Afiliado;
import Logica.Usuario;
import Logica.Controladora;
import Logica.PasswordUtil;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SvUsuarios", urlPatterns = {"/SvUsuarios"})
public class SvUsuarios extends HttpServlet {

    private static final int MIN_LONGITUD_CONTRASENA = 8;
    private static final int MAX_LONGITUD_CONTRASENA = 100;

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
        String aceptaTerminos = request.getParameter("aceptaTerminos");

        // --- 1. VALIDACIÓN DE CAMPOS OBLIGATORIOS ---
        if (esVacio(idAfiliado) || esVacio(contrasena)) {
            request.setAttribute("errorMessage", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("/login_registro.jsp").forward(request, response);
            return;
        }
        
        if (aceptaTerminos == null) {
            request.setAttribute("errorMessage",
                "Debes aceptar los Términos y Condiciones para registrarte.");
            request.getRequestDispatcher("/login_registro.jsp").forward(request, response);
            return;
        }

        idAfiliado = idAfiliado.trim().toUpperCase();

        if (idAfiliado.length() > 20) {
            request.setAttribute("errorMessage", "El ID de afiliado no puede superar 20 caracteres.");
            request.getRequestDispatcher("/login_registro.jsp").forward(request, response);
            return;
        }

        if (contrasena.length() < MIN_LONGITUD_CONTRASENA) {
            request.setAttribute("errorMessage",
                "La contraseña debe tener al menos " + MIN_LONGITUD_CONTRASENA + " caracteres.");
            request.getRequestDispatcher("/login_registro.jsp").forward(request, response);
            return;
        }

        if (contrasena.length() > MAX_LONGITUD_CONTRASENA) {
            request.setAttribute("errorMessage", "La contraseña es demasiado larga.");
            request.getRequestDispatcher("/login_registro.jsp").forward(request, response);
            return;
        }

        Controladora control = new Controladora();

        // --- 2. VERIFICAR QUE EL AFILIADO EXISTA EN EL PADRÓN ---
        Afiliado afiliado = control.traerAfiliado(idAfiliado);
        if (afiliado == null) {
            request.setAttribute("errorMessage",
                "El ID de afiliado no existe en el padrón. Verifique el dato e intente de nuevo.");
            request.getRequestDispatcher("/login_registro.jsp").forward(request, response);
            return;
        }

        // --- 3. VERIFICAR QUE NO TENGA YA UN USUARIO REGISTRADO ---
        if (control.afiliadoTieneUsuario(idAfiliado)) {
            request.setAttribute("errorMessage",
                "Este ID de afiliado ya tiene una cuenta registrada.");
            request.getRequestDispatcher("/login_registro.jsp").forward(request, response);
            return;
        }

        // --- 4. VERIFICAR QUE EL TIPO DE PERSONA SEA 'afiliado' ---
        if (!"afiliado".equalsIgnoreCase(afiliado.getTipoPersona())) {
            request.setAttribute("errorMessage",
                "Este ID no corresponde a un afiliado. El registro público es exclusivo para afiliados.");
            request.getRequestDispatcher("/login_registro.jsp").forward(request, response);
            return;
        }

        // --- 5. HASHEAR LA CONTRASEÑA Y CREAR EL USUARIO ---
        String contrasenaHasheada = PasswordUtil.hashear(contrasena);

        Usuario usuario = new Usuario();
        usuario.setAfiliado(afiliado);
        usuario.setContrasena(contrasenaHasheada);
        usuario.setRol("usuario");
        usuario.setRequiereCambioContrasena(false);

        control.crearUsuario(usuario);

        int idNuevoUsuario = usuario.getId();
        control.inicializarProgresoParaUsuario(idNuevoUsuario);

        // --- 6. INICIAR SESIÓN AUTOMÁTICAMENTE TRAS EL REGISTRO ---
        HttpSession session = request.getSession(true);
        session.setAttribute("usuarioLogueado", usuario);

        String csrfToken = UUID.randomUUID().toString();
        session.setAttribute("csrfToken", csrfToken);
        session.setMaxInactiveInterval(30 * 60);

        response.sendRedirect("index.jsp");
    }

    private boolean esVacio(String valor) {
        return valor == null || valor.trim().isEmpty();
    }

    @Override
    public String getServletInfo() {
        return "Registra usuarios del padrón (afiliado) con validación, BCrypt y progreso inicial";
    }
}
