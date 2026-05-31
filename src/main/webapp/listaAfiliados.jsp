<%-- listaAfiliados.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Logica.Usuario"%>
<%@page import="Logica.Afiliado"%>
<%@page import="Logica.Controladora"%>
<%@page import="java.util.List"%>
<%
    Usuario admin = (Usuario) session.getAttribute("usuarioLogueado");
    if (admin == null || !"admin".equalsIgnoreCase(admin.getRol())) {
        response.sendRedirect("loginAdmin.jsp");
        return;
    }
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String csrfToken = (String) session.getAttribute("csrfToken");
    String adminId   = admin.getAfiliado() != null
                       ? admin.getAfiliado().getIdAfiliado() : "Admin";

    Controladora control = new Controladora();
    List<Afiliado> lista = control.traerAfiliados();

    String mensajeOk    = (String) session.getAttribute("afiliadoOk");
    String mensajeError = (String) session.getAttribute("afiliadoError");
    session.removeAttribute("afiliadoOk");
    session.removeAttribute("afiliadoError");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Afiliados — TECNOAPRENDE</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .badge-afiliado      { background:#198754; color:#fff; padding:2px 10px; border-radius:20px; font-size:.8em; }
        .badge-instructor    { background:#0d6efd; color:#fff; padding:2px 10px; border-radius:20px; font-size:.8em; }
        .badge-administrador { background:#dc3545; color:#fff; padding:2px 10px; border-radius:20px; font-size:.8em; }
        .filtro-tipo { display:flex; gap:8px; flex-wrap:wrap; margin-bottom:16px; align-items:center; }
        .filtro-tipo button  { padding:5px 14px; border-radius:20px; border:1px solid #ccc;
                               background:#f8f9fa; cursor:pointer; font-size:.87em; }
        .filtro-tipo button.activo { background:#0d6efd; color:#fff; border-color:#0d6efd; }
        #buscador { padding:6px 12px; border:1px solid #ccc; border-radius:6px; font-size:.9em; width:240px; }
    </style>
</head>
<body>
    <header class="encabezado">
        <img src="images/ITSZ-LCNTEZ.png" alt="logos" class="imagen-encabezado">
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

        <h1>
            Gestión de Afiliados
            <button class="registrar" onclick="abrirRegistro()">
                <i class="fas fa-plus"></i> Nuevo Afiliado
            </button>
        </h1>

        <%-- Notificaciones --%>
        <% if (mensajeOk != null) { %>
        <div style="background:#d1e7dd;border:1px solid #a3cfbb;color:#0a3622;padding:10px 16px;
                    border-radius:6px;margin-bottom:14px;">
            <i class="fas fa-check-circle"></i>
            <%= org.apache.commons.text.StringEscapeUtils.escapeHtml4(mensajeOk) %>
        </div>
        <% } %>
        <% if (mensajeError != null) { %>
        <div style="background:#f8d7da;border:1px solid #f1aeb5;color:#58151c;padding:10px 16px;
                    border-radius:6px;margin-bottom:14px;">
            <i class="fas fa-exclamation-circle"></i>
            <%= org.apache.commons.text.StringEscapeUtils.escapeHtml4(mensajeError) %>
        </div>
        <% } %>

        <%-- Buscador y filtros --%>
        <div class="filtro-tipo">
            <input type="text" id="buscador" placeholder="Buscar por ID o nombre..." oninput="filtrar()">
            <button class="activo" onclick="setFiltro('todos', this)">Todos (<%= lista.size() %>)</button>
            <button onclick="setFiltro('afiliado', this)">
                Estudiantes (<%= lista.stream().filter(a -> "afiliado".equals(a.getTipoPersona())).count() %>)
            </button>
            <button onclick="setFiltro('instructor', this)">
                Instructores (<%= lista.stream().filter(a -> "instructor".equals(a.getTipoPersona())).count() %>)
            </button>
            <button onclick="setFiltro('administrador', this)">
                Administradores (<%= lista.stream().filter(a -> "administrador".equals(a.getTipoPersona())).count() %>)
            </button>
        </div>

        <table id="tablaAfiliados">
            <thead>
                <tr>
                    <th>ID Afiliado</th>
                    <th>Nombre</th>
                    <th>Apellidos</th>
                    <th>Tipo</th>
                    <th>¿Tiene cuenta?</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Afiliado af : lista) {
                    boolean tieneCuenta = control.afiliadoTieneUsuario(af.getIdAfiliado());
                    String idEsc  = org.apache.commons.text.StringEscapeUtils.escapeHtml4(af.getIdAfiliado());
                    String nomEsc = org.apache.commons.text.StringEscapeUtils.escapeHtml4(af.getNombre());
                    String apEsc  = org.apache.commons.text.StringEscapeUtils.escapeHtml4(af.getApellidos());
                    String tipo   = af.getTipoPersona() != null ? af.getTipoPersona() : "";
            %>
            <tr data-tipo="<%= tipo %>">
                <td><strong><%= idEsc %></strong></td>
                <td><%= nomEsc %></td>
                <td><%= apEsc %></td>
                <td>
                    <span class="badge-<%= tipo %>"><%= tipo %></span>
                </td>
                <td style="text-align:center;">
                    <% if (tieneCuenta) { %>
                        <i class="fas fa-check-circle" style="color:#198754;" title="Sí"></i>
                    <% } else { %>
                        <i class="fas fa-times-circle" style="color:#aaa;" title="No"></i>
                    <% } %>
                </td>
                <td>
                    <button class="editar"
                        onclick="abrirEditar('<%= idEsc %>', '<%= nomEsc %>', '<%= apEsc %>', '<%= tipo %>')">
                        <i class="fas fa-edit"></i> Editar
                    </button>
                    <button class="eliminar" <%= tieneCuenta ? "disabled title='Tiene cuenta vinculada'" : "" %>
                        onclick="confirmarEliminar('<%= idEsc %>')">
                        <i class="fas fa-trash-alt"></i> Eliminar
                    </button>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <p id="sinResultados" style="display:none; text-align:center; color:#888; padding:20px;">
            No se encontraron afiliados con ese criterio.
        </p>

        <%-- ===== MODAL CREAR ===== --%>
        <div class="modal_registro" id="modalRegistro">
            <div class="modal_content_formulario">
                <h3><i class="fas fa-user-plus"></i> Nuevo Afiliado</h3>
                <form action="SvAfiliados" method="POST" accept-charset="UTF-8"
                      onsubmit="return validarFormAfiliado('crear')">
                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                    <input type="hidden" name="accion" value="crear">

                    <p><label>ID de Afiliado <span style="color:red">*</span></label></p>
                    <input type="text" name="idAfiliado" id="crearId"
                           placeholder="Ej: AF001" maxlength="20" required
                           style="text-transform:uppercase;"
                           oninput="this.value = this.value.toUpperCase()">

                    <p><label>Nombre <span style="color:red">*</span></label></p>
                    <input type="text" name="nombre" id="crearNombre"
                           placeholder="Nombre(s)" maxlength="100" required>

                    <p><label>Apellidos <span style="color:red">*</span></label></p>
                    <input type="text" name="apellidos" id="crearApellidos"
                           placeholder="Apellidos" maxlength="100" required>

                    <p><label>Tipo de persona <span style="color:red">*</span></label></p>
                    <select name="tipoPersona" id="crearTipo" required>
                        <option value="">— Selecciona —</option>
                        <option value="afiliado">Afiliado (estudiante)</option>
                        <option value="instructor">Instructor</option>
                        <option value="administrador">Administrador</option>
                    </select>

                    <div class="modal-buttons_lista" style="margin-top:16px;">
                        <button type="button" onclick="cerrarModal()">Cancelar</button>
                        <button type="submit"><i class="fas fa-save"></i> Guardar</button>
                    </div>
                </form>
            </div>
        </div>

        <%-- ===== MODAL EDITAR ===== --%>
        <div class="modal_editar" id="modalEditar">
            <div class="modal_content_formulario">
                <h3><i class="fas fa-edit"></i> Editar Afiliado</h3>
                <form action="SvAfiliados" method="POST" accept-charset="UTF-8">
                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                    <input type="hidden" name="accion" value="editar">
                    <input type="hidden" name="idAfiliado" id="editId">

                    <p><label>ID de Afiliado</label></p>
                    <input type="text" id="editIdDisplay" disabled
                           style="background:#f0f0f0; color:#666;">

                    <p><label>Nombre <span style="color:red">*</span></label></p>
                    <input type="text" name="nombre" id="editNombre"
                           placeholder="Nombre(s)" maxlength="100" required>

                    <p><label>Apellidos <span style="color:red">*</span></label></p>
                    <input type="text" name="apellidos" id="editApellidos"
                           placeholder="Apellidos" maxlength="100" required>

                    <p><label>Tipo de persona <span style="color:red">*</span></label></p>
                    <select name="tipoPersona" id="editTipo" required>
                        <option value="afiliado">Afiliado (estudiante)</option>
                        <option value="instructor">Instructor</option>
                        <option value="administrador">Administrador</option>
                    </select>

                    <div class="modal-buttons_lista" style="margin-top:16px;">
                        <button type="button" onclick="cerrarModal()">Cancelar</button>
                        <button type="submit"><i class="fas fa-save"></i> Guardar cambios</button>
                    </div>
                </form>
            </div>
        </div>

        <%-- ===== MODAL ELIMINAR ===== --%>
        <div class="modal_eliminar" id="modalEliminar">
            <div class="modal_content_formulario">
                <h3><i class="fas fa-trash-alt"></i> Eliminar Afiliado</h3>
                <p>¿Confirmas que deseas eliminar al afiliado
                   <strong id="eliminarIdLabel"></strong>?
                   <br>
                   <span style="color:#888; font-size:.9em;">
                       Solo se puede eliminar si no tiene cuenta de usuario vinculada.
                   </span>
                </p>
                <form action="SvAfiliados" method="POST">
                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                    <input type="hidden" name="accion" value="eliminar">
                    <input type="hidden" name="idAfiliado" id="eliminarId">
                    <div class="modal-buttons_lista" style="margin-top:16px;">
                        <button type="button" onclick="cerrarModal()">No, cancelar</button>
                        <button type="submit" class="eliminar">Sí, eliminar</button>
                    </div>
                </form>
            </div>
        </div>

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
            <a href="creditos.jsp"><p>© 2026 TECNOAPRENDE. Plataforma desarrollada por equipo BOX Code. Todos los derechos reservados.</p></a>
        </div>
    </footer>

    <script>
        let filtroActual = 'todos';

        function abrirRegistro() {
            document.getElementById('modalRegistro').style.display = 'flex';
        }

        function abrirEditar(id, nombre, apellidos, tipo) {
            document.getElementById('editId').value          = id;
            document.getElementById('editIdDisplay').value   = id;
            document.getElementById('editNombre').value      = nombre;
            document.getElementById('editApellidos').value   = apellidos;
            document.getElementById('editTipo').value        = tipo;
            document.getElementById('modalEditar').style.display = 'flex';
        }

        function confirmarEliminar(id) {
            document.getElementById('eliminarId').value        = id;
            document.getElementById('eliminarIdLabel').textContent = id;
            document.getElementById('modalEliminar').style.display = 'flex';
        }

        function cerrarModal() {
            document.getElementById('modalRegistro').style.display = 'none';
            document.getElementById('modalEditar').style.display   = 'none';
            document.getElementById('modalEliminar').style.display = 'none';
        }

        function setFiltro(tipo, btn) {
            filtroActual = tipo;
            document.querySelectorAll('.filtro-tipo button').forEach(b => b.classList.remove('activo'));
            btn.classList.add('activo');
            filtrar();
        }

        function filtrar() {
            const texto = document.getElementById('buscador').value.toLowerCase();
            const filas = document.querySelectorAll('#tablaAfiliados tbody tr');
            let visibles = 0;

            filas.forEach(fila => {
                const tipo      = fila.dataset.tipo || '';
                const contenido = fila.textContent.toLowerCase();
                const pasaTipo  = (filtroActual === 'todos' || tipo === filtroActual);
                const pasaTexto = (texto === '' || contenido.includes(texto));

                if (pasaTipo && pasaTexto) {
                    fila.style.display = '';
                    visibles++;
                } else {
                    fila.style.display = 'none';
                }
            });

            document.getElementById('sinResultados').style.display = (visibles === 0) ? 'block' : 'none';
        }

        function validarFormAfiliado(modo) {
            const idField = document.getElementById('crearId');
            if (idField && !/^[A-Z0-9_-]{1,20}$/.test(idField.value)) {
                alert('El ID solo puede contener letras mayúsculas, números, guiones y guiones bajos (máx. 20 caracteres).');
                return false;
            }
            return true;
        }

        // Cerrar modal al hacer clic fuera
        window.addEventListener('click', function(e) {
            ['modalRegistro','modalEditar','modalEliminar'].forEach(id => {
                const modal = document.getElementById(id);
                if (e.target === modal) cerrarModal();
            });
        });
    </script>
</body>
</html>
