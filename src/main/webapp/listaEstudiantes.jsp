<%-- listaEstudiantes.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="Logica.*"%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");

    if (usuario == null || !"instructor".equals(usuario.getRol())) {
        response.sendRedirect("login_registro.jsp");
        return;
    }

    int idCurso = Integer.parseInt(request.getParameter("idCurso"));
    Controladora control = new Controladora();
    List<Usuario> estudiantes = control.traerEstudiantesPorCurso(idCurso);

    String csrfToken = (String) session.getAttribute("csrfToken");
    String tempPass = request.getParameter("temp");
    String tempUser = request.getParameter("tempUser");
    String idAfiliado = usuario.getAfiliado() != null ? usuario.getAfiliado().getIdAfiliado() : "Instructor";
%>

<!DOCTYPE html>
<html>
<head>
    <title>Estudiantes del Curso</title>
    <meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>

<body>

<header class="encabezado">
    <img src="images/ITSZ-LCNTEZ.png" class="imagen-encabezado">
    <img src="images/tecnoaprende.png" alt="Logo TecnoAprende" class="tecnoaprende">
    <div class="acciones">
        <p>Bienvenido, 
            <strong><%= org.apache.commons.text.StringEscapeUtils.escapeHtml4(idAfiliado) %></strong> 
            (Instructor)
        </p>
        <form action="SvCerrarSesion" method="POST" style="display:inline;">
            <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") %>">
            <button type="submit">Cerrar sesión</button>
        </form>
        <a href="panelInstructor.jsp"><button>Panel Principal</button></a>
    </div>
</header>

<main class="contenedor_lista">

    <a href="listaCursosInstructor.jsp">
        <button class="registrar">Lista de Cursos</button>
    </a>

    <h1>Estudiantes</h1>

    <% if (tempPass != null && tempUser != null) { %>
        <div style="background:#d4edda;border:1px solid #c3e6cb;color:#155724;padding:12px;border-radius:6px;margin:10px 0;">
            <strong>Contraseña temporal generada para <%= tempUser %>:</strong>
            <code style="background:#fff;padding:4px 8px;border-radius:4px;font-size:1.1em;">
                <%= tempPass %>
            </code>
            <br>
            Comparte esta contraseña con el alumno. El sistema le pedirá cambiarla al iniciar sesión. Esta contraseña se muestra una sola vez.
        </div>
    <% } %>

    <ul class="lista-estudiantes">

        <% for (Usuario est : estudiantes) {

            String nombreCompleto = (est.getAfiliado() != null)
                ? est.getAfiliado().getNombre() + " " + est.getAfiliado().getApellidos()
                : "este usuario";
        %>

        <li>
            <span class="estudiante-nombre">
                <%= org.apache.commons.text.StringEscapeUtils.escapeHtml4(nombreCompleto) %>
            </span>

            <div class="acciones-estudiante">

                <button class="boton-estudiante"
                    onclick="location.href='listaProgresoInstructor.jsp?idCurso=<%=idCurso%>&idUsuario=<%=est.getId()%>'">
                    Ver Progreso
                </button>

                <form action="SvRestablecerContrasena" method="post" class="form-inline-reset"
                      onsubmit="return confirm('¿Restablecer la contraseña de <%= nombreCompleto %>? Se generará una contraseña temporal.');">

                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                    <input type="hidden" name="idUsuario" value="<%= est.getId() %>">
                    <input type="hidden" name="idCurso" value="<%= idCurso %>">

                    <button type="submit" class="boton-estudiante">
                        Restablecer contraseña
                    </button>

                </form>

            </div>
        </li>

        <% } %>

    </ul>

</main>

<footer class="pie_de_pagina">
    <div class="footer-contenido">

        <div class="instituto">
            <a href="https://zongolica.tecnm.mx/">Instituto Tecnológico Superior de Zongolica</a>
            <div class="redes">
                <a href="https://www.facebook.com/TecNMZongolica" target="_blank"><i class="fab fa-facebook"></i></a>
                <a href="https://www.youtube.com/channel/UCi0_QXTliS2p_2MDwhfF8ww" target="_blank"><i class="fab fa-youtube"></i></a>
                <a href="https://x.com/somositsz?lang=es" target="_blank"><i class="fab fa-x"></i></a>
            </div>
        </div>

        <div class="casa">
            <a href="https://lcntez.org.mx/">La Casa de los Niños de Tezonapa</a>
            <div class="redes">
                <a href="https://www.facebook.com/profile.php?id=100078645709893" target="_blank"><i class="fab fa-facebook"></i></a>
                <a href="https://www.instagram.com/ninos_tezonapa" target="_blank"><i class="fab fa-instagram"></i></a>
                <a href="https://x.com/Ninos_Tezonapa" target="_blank"><i class="fab fa-x"></i></a>
            </div>
        </div>

    </div>

    <div class="creditos-equipo">
        <a href="creditos.jsp">
            <p>© 2026 TECNOAPRENDE. Plataforma desarrollada por equipo BOX Code. Todos los derechos reservados.</p>
        </a>
    </div>
</footer>

</body>
</html>