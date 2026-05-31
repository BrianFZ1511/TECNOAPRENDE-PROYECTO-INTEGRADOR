<%-- listaInstructores.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Logica.Usuario"%>
<%@page import="Logica.Afiliado"%>
<%@page import="Logica.Instructor"%>
<%@page import="Logica.Controladora"%>
<%@page import="java.util.List"%>
<%
    Usuario admin = (Usuario) session.getAttribute("usuarioLogueado");
    if (admin == null || !"admin".equalsIgnoreCase(admin.getRol())) {
        response.sendRedirect("loginAdmin.jsp");
        return;
    }

    String csrfToken = (String) session.getAttribute("csrfToken");
    String adminId = admin.getAfiliado() != null ? admin.getAfiliado().getIdAfiliado() : "Admin";

    Controladora control = new Controladora();
    List<Instructor> listaInstructores = control.traerInstructores();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lista de Instructores</title>
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
            <h1>Instructores Registrados <button class="registrar" onclick="abrirRegistro()">Registrar Instructor</button></h1>

            <table>
                <tr>
                    <th>ID Instructor</th><th>ID Afiliado</th><th>Nombre</th><th>Apellidos</th><th>Acciones</th>
                </tr>
                <%
                    for (Instructor ins : listaInstructores) {
                        Usuario u = ins.getUsuario();
                        if (u == null) continue;
                        Afiliado af = u.getAfiliado();
                        String idAfilEsc   = af != null ? org.apache.commons.text.StringEscapeUtils.escapeHtml4(af.getIdAfiliado()) : "";
                        String nombreEsc   = af != null ? org.apache.commons.text.StringEscapeUtils.escapeHtml4(af.getNombre()) : "";
                        String apellidoEsc = af != null ? org.apache.commons.text.StringEscapeUtils.escapeHtml4(af.getApellidos()) : "";
                %>
                <tr>
                    <td><%= ins.getIdInstructor() %></td>
                    <td><%= idAfilEsc %></td>
                    <td><%= nombreEsc %></td>
                    <td><%= apellidoEsc %></td>
                    <td>
                        <button class="editar" onclick="abrirEditar(<%= ins.getIdInstructor() %>, <%= u.getId() %>)">Editar</button>
                        <button class="eliminar" onclick="confirmarEliminar(<%= ins.getIdInstructor() %>)">Eliminar</button>
                    </td>
                </tr>
                <% } %>
            </table>

            <!-- MODAL REGISTRAR (solo idAfiliado + contraseña) -->
            <div class="modal_registro" id="modalRegistro">
                <div class="modal_content_formulario">
                    <h3>Registrar Instructor</h3>
                    <p style="font-size:0.85em; color:#555;">
                        El afiliado debe existir en el padrón con tipo <strong>instructor</strong>.
                    </p>
                    <form action="SvCrearInstructor" method="POST" accept-charset="UTF-8">
                        <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                        <p><label>ID de Afiliado:</label></p>
                        <input type="text" name="idAfiliado" placeholder="Ej: INS001"
                               maxlength="20" required
                               style="text-transform:uppercase;"
                               oninput="this.value = this.value.toUpperCase()">
                        <p><label>Contraseña inicial:</label></p>
                        <input type="password" name="contrasena"
                               placeholder="Mínimo 8 caracteres" minlength="8" maxlength="100" required>
                        <p style="font-size:0.8em; color:#888;">
                            El instructor deberá cambiar su contraseña al iniciar sesión por primera vez.
                        </p>
                        <div class="modal-buttons_lista">
                            <button type="button" onclick="cerrarModal()">Cancelar</button>
                            <button type="submit">Registrar</button>
                        </div>
                    </form>
                    <%
                        String errInst = (String) request.getAttribute("error");
                        if (errInst != null) {
                    %>
                        <p style="color:red;"><%= org.apache.commons.text.StringEscapeUtils.escapeHtml4(errInst) %></p>
                    <% } %>
                </div>
            </div>

            <!-- MODAL EDITAR (solo contraseña) -->
            <div class="modal_editar" id="modalEditar">
                <div class="modal_content_formulario">
                    <h3>Editar Instructor</h3>
                    <form action="SvEditarInstructor" method="POST" accept-charset="UTF-8">
                        <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                        <input type="hidden" name="idInstructor" id="editIdInstructor">
                        <input type="hidden" name="idUsuario" id="editIdUsuario">
                        <p><label>Nueva Contraseña (dejar vacío para no cambiar):</label></p>
                        <input type="password" name="contrasena" id="editContrasena"
                               placeholder="Nueva contraseña (opcional)" minlength="8" maxlength="100">
                        <p><label>Requerir cambio de contraseña:</label></p>
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

            <!-- MODAL ELIMINAR -->
            <div class="modal_eliminar" id="modalEliminar">
                <div class="modal_content_formulario">
                    <h3>¿Eliminar este instructor?</h3>
                    <form action="SvEliminarInstructor" method="POST">
                        <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                        <input type="hidden" name="idInstructor" id="deleteIdInstructor">
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
            function abrirRegistro() {
                document.getElementById('modalRegistro').style.display = 'flex';
            }

            function abrirEditar(idInstructor, idUsuario) {
                document.getElementById('editIdInstructor').value = idInstructor;
                document.getElementById('editIdUsuario').value = idUsuario;
                document.getElementById('editContrasena').value = '';
                document.getElementById('editRequiere').value = '';
                document.getElementById('modalEditar').style.display = 'flex';
            }

            function confirmarEliminar(idInstructor) {
                document.getElementById('deleteIdInstructor').value = idInstructor;
                document.getElementById('modalEliminar').style.display = 'flex';
            }

            function cerrarModal() {
                document.getElementById('modalRegistro').style.display = 'none';
                document.getElementById('modalEditar').style.display = 'none';
                document.getElementById('modalEliminar').style.display = 'none';
            }
        </script>
    </body>
</html>
