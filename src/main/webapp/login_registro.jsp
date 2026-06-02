<%-- login_registro.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("usuarioLogueado") != null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String csrfToken = (String) session.getAttribute("csrfToken");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Acceso / Registro — TECNOAPRENDE</title>
        <link rel="stylesheet" href="styles.css">
        <link rel="icon" href="assets/favicon.ico" type="image/x-icon">
    </head>

    <body>

        <header class="encabezado">
            <img src="images/ITSZ-LCNTEZ.png" alt="Encabezado de logos" class="imagen-encabezado">
            <img src="images/tecnoaprende.png" alt="Logo TecnoAprende" class="tecnoaprende">
            <div class="acciones">
                <a href="index.jsp"><button>Panel Principal</button></a>
            </div>
        </header>

        <div class="tabs">
            <button onclick="showTab('login')" class="active" id="tab-login">Iniciar Sesión</button>
            <button onclick="showTab('register')" id="tab-register">Registrarse</button>
        </div>

        <div class="form-wrapper">
            <div class="form-container" id="form-container">

                <%-- ===== FORMULARIO DE INICIO DE SESIÓN ===== --%>
                <div id="login" class="tab-content active">
                    <h1 class="formulario">Iniciar Sesión</h1>
                    <form action="SvInicioSesion" method="POST" accept-charset="UTF-8" autocomplete="off">

                        <% if (csrfToken != null) { %>
                            <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                        <% } %>

                        <p>
                            <label for="loginIdAfiliado">ID de Afiliado:</label>
                            <input type="text"
                                   id="loginIdAfiliado"
                                   name="idAfiliado"
                                   placeholder="Ej: 134252"
                                   maxlength="20"
                                   required
                                   autocomplete="username"
                                   style="text-transform: uppercase;">
                        </p>
                        <p>
                            <label for="loginContrasena">Contraseña:</label>
                            <input type="password"
                                   id="loginContrasena"
                                   name="contrasena"
                                   placeholder="Ingrese su Contraseña"
                                   maxlength="200"
                                   required
                                   autocomplete="current-password">
                        </p>
                        <button type="submit" class="boton_iniciosesion_registro">Iniciar sesión</button>
                    </form>

                    <%
                        String error = (String) request.getAttribute("error");
                        if (error != null) {
                    %>
                        <p style="color: red; text-align: center;"><%= org.apache.commons.text.StringEscapeUtils.escapeHtml4(error) %></p>
                    <% } %>
                </div>

                <%-- ===== FORMULARIO DE REGISTRO ===== --%>
                <div id="register" class="tab-content">
                    <h1 class="formulario">Registrarse</h1>
                    <p style="text-align:center; color:#555; font-size:0.9em;">
                        Solo afiliados registrados en el padrón pueden crear una cuenta.
                    </p>
                    <form action="SvUsuarios" id="miFormulario" method="POST"
                          accept-charset="UTF-8" autocomplete="off"
                          onsubmit="return validarFormularioRegistro()">

                        <p>
                            <label for="regIdAfiliado">ID de Afiliado:</label>
                            <input type="text"
                                   id="regIdAfiliado"
                                   name="idAfiliado"
                                   placeholder="Ej: 563461"
                                   maxlength="20"
                                   required
                                   autocomplete="off"
                                   style="text-transform: uppercase;">
                        </p>
                        <p>
                            <label for="regContrasena">Contraseña:</label>
                            <input type="password"
                                   id="regContrasena"
                                   name="contrasena"
                                   placeholder="Mínimo 8 caracteres"
                                   minlength="8"
                                   maxlength="100"
                                   required
                                   autocomplete="new-password">
                        </p>
                        <p>
                            <label for="regConfirmar">Confirmar Contraseña:</label>
                            <input type="password"
                                   id="regConfirmar"
                                   placeholder="Repita su contraseña"
                                   maxlength="100"
                                   required
                                   autocomplete="new-password">
                        </p>
                        
                        <p>
                                <label class="checkbox-terminos">

                                    <input type="checkbox"
                                           name="aceptaTerminos"
                                           id="aceptaTerminos"
                                           required>

                                    <span class="checkmark"></span>

                                    <span class="texto-terminos">
                                        He leído y acepto los
                                        <a href="docs/Terminos_y_Condiciones_TecnoAprende.pdf"
                                           target="_blank"
                                           download>
                                            Términos y Condiciones
                                        </a>
                                    </span>

                                </label>
                        </p>
                        <br>
                        <button type="submit" class="boton_iniciosesion_registro">Registrarse</button>
                    </form>

                    <%
                        String errorMessage = (String) request.getAttribute("errorMessage");
                        if (errorMessage != null) {
                    %>
                        <div style="color:red; text-align: center;"><%= org.apache.commons.text.StringEscapeUtils.escapeHtml4(errorMessage) %></div>
                    <% } %>
                </div>

            </div>
        </div>

        <script>
            function validarFormularioRegistro() {
                const contrasena = document.getElementById('regContrasena').value;
                const confirmar  = document.getElementById('regConfirmar').value;

                if (contrasena !== confirmar) {
                    alert('Las contraseñas no coinciden. Por favor, verifique.');
                    return false;
                }

                if (contrasena.length < 8) {
                    alert('La contraseña debe tener al menos 8 caracteres.');
                    return false;
                }

                return true;
            }

            function showTab(tabId) {
                document.querySelectorAll('.tab-content').forEach(div => {
                    div.classList.remove('active');
                });
                document.querySelectorAll('.tabs button').forEach(button => {
                    button.classList.remove('active');
                });

                document.getElementById(tabId).classList.add('active');
                document.getElementById('tab-' + tabId).classList.add('active');

                const container = document.getElementById('form-container');
                if (tabId === 'register') {
                    container.classList.add('slide-to-register');
                    container.classList.remove('slide-to-login');
                } else {
                    container.classList.remove('slide-to-register');
                    container.classList.add('slide-to-login');
                }
            }

            document.addEventListener('DOMContentLoaded', () => {
                const urlParams = new URLSearchParams(window.location.search);
                const initialTab = urlParams.get('tab');
                showTab(initialTab === 'register' ? 'register' : 'login');
            });

            document.getElementById('regIdAfiliado').addEventListener('input', function() {
                this.value = this.value.toUpperCase();
            });
            document.getElementById('loginIdAfiliado').addEventListener('input', function() {
                this.value = this.value.toUpperCase();
            });
        </script>
    </body>
</html>
