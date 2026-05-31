<%-- listaUsuarios.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Logica.Usuario"%>
<%@page import="Logica.Afiliado"%>
<%@page import="java.util.List"%>
<%@page import="Logica.Controladora"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    Usuario admin = (Usuario) session.getAttribute("usuarioLogueado");
    if (admin == null || !"admin".equalsIgnoreCase(admin.getRol())) {
        response.sendRedirect("loginAdmin.jsp");
        return;
    }

    String csrfToken = (String) session.getAttribute("csrfToken");
    String adminId = admin.getAfiliado() != null ? admin.getAfiliado().getIdAfiliado() : "Admin";

    Controladora control = new Controladora();
    List<Usuario> listaUsuarios = control.traerUsuarios();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lista de Usuarios</title>
        <link rel="stylesheet" href="styles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <header class="encabezado">
            <img src="images/ITSZ-LCNTEZ.png" alt="Encabezado de logos" class="imagen-encabezado">
            <img src="images/tecnoaprende.png" alt="Logo TecnoAprende" class="tecnoaprende">
            <div class="acciones">
                <p><strong><%= org.apache.commons.text.StringEscapeUtils.escapeHtml4(adminId) %></strong></p>
                <form action="SvCerrarSesion" method="POST" style="display:inline;">
                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                    <button type="submit">Cerrar sesión</button>
                </form>
                <a href="panelAdmin.jsp"><button>Panel Principal</button></a>
            </div>
        </header>

        <main class="contenedor_lista">
            <h1>Usuarios Registrados</h1>
            <table>
                <tr>
                    <th>ID</th><th>ID Afiliado</th><th>Nombre</th><th>Apellidos</th><th>Rol</th><th>Acciones</th>
                </tr>
                <%
                    for (Usuario u : listaUsuarios) {
                        if ("usuario".equalsIgnoreCase(u.getRol())) {
                            Afiliado af = u.getAfiliado();
                            String idAfilEsc  = af != null ? org.apache.commons.text.StringEscapeUtils.escapeHtml4(af.getIdAfiliado()) : "";
                            String nombreEsc  = af != null ? org.apache.commons.text.StringEscapeUtils.escapeHtml4(af.getNombre()) : "";
                            String apellidoEsc= af != null ? org.apache.commons.text.StringEscapeUtils.escapeHtml4(af.getApellidos()) : "";
                %>
                <tr>
                    <td><%= u.getId() %></td>
                    <td><%= idAfilEsc %></td>
                    <td><%= nombreEsc %></td>
                    <td><%= apellidoEsc %></td>
                    <td><%= u.getRol() %></td>
                    <td>
                        <button class="editar" onclick="abrirEditar(<%= u.getId() %>)">Editar</button>
                        <button class="eliminar" onclick="confirmarEliminar(<%= u.getId() %>)">Eliminar</button>
                    </td>
                </tr>
                <% } } %>
            </table>

            <!-- MODAL DE EDICIÓN (solo contraseña) -->
            <div class="modal_editar" id="modalEditar">
                <div class="modal_content_formulario">
                    <h3>Editar Usuario</h3>
                    <form action="SvEditarUsuario" method="POST" accept-charset="UTF-8">
                        <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                        <input type="hidden" name="id" id="editId">
                        <p><label>Nueva Contraseña (dejar vacío para no cambiar):</label></p>
                        <input type="password" name="contrasena" id="editContrasena"
                               placeholder="Nueva contraseña (opcional)" minlength="8" maxlength="100">
                        <p><label>Requerir cambio de contraseña al iniciar sesión:</label></p>
                        <select name="requiereCambio" id="editRequiere">
                            <option value="">— Sin cambio —</option>
                            <option value="true">Sí</option>
                            <option value="false">No</option>
                        </select>
                        <div class="modal-buttons_lista">
                            <button type="button" onclick="cerrarModal()">Cancelar</button>
                            <button type="submit">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- MODAL DE CONFIRMACIÓN DE ELIMINACIÓN -->
            <div class="modal_eliminar" id="modalEliminar">
                <div class="modal_content_formulario">
                    <h3>¿Estás seguro de eliminar este usuario?</h3>
                    <form action="SvEliminar" method="POST">
                        <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                        <input type="hidden" name="id" id="deleteId">
                        <div class="modal-buttons_lista">
                            <button type="button" onclick="cerrarModal()">No</button>
                            <button type="submit">Sí, eliminar</button>
                        </div>
                    </form>
                </div>
            </div>
        </main>

        <!-- Pie de página -->
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
                    <a href="https://www.instagram.com/ninos_tezonapa?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw%3D%3D" target="_blank"><i class="fab fa-instagram"></i></a>
                    <a href="https://x.com/Ninos_Tezonapa" target="_blank"><i class="fab fa-x"></i></a>
                </div>
            </div>
            </div>
            <div class="creditos-equipo">
                <a href="creditos.jsp"><p>© 2026 TECNOAPRENDE. Plataforma desarrollada por equipo BOX Code. Todos los derechos reservados.</p></a>
            </div>
        </footer>

        <script>
            function abrirEditar(id) {
                document.getElementById('editId').value = id;
                document.getElementById('editContrasena').value = '';
                document.getElementById('editRequiere').value = '';
                document.getElementById('modalEditar').style.display = 'flex';
            }

            function confirmarEliminar(id) {
                document.getElementById('deleteId').value = id;
                document.getElementById('modalEliminar').style.display = 'flex';
            }

            function cerrarModal() {
                document.getElementById('modalEditar').style.display = 'none';
                document.getElementById('modalEliminar').style.display = 'none';
            }
        </script>
    </body>
</html>
