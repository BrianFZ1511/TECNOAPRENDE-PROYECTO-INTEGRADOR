<%-- index.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="Logica.Usuario"%>
<%
    // No cache
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
%>


<!DOCTYPE html>
<html lang="es">
    <head>
      <meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
      <title>TECNOAPRENDE</title>
      <link rel="stylesheet" href="styles.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
      <link rel="icon" href="assets/favicon.ico" type="image/x-icon">
    </head>
    <body>
        <!-- Encabezado -->
        <header class="encabezado">
          <img src="images/ITSZ-LCNTEZ.png" alt="Encabezado de logos" class="imagen-encabezado">
          <img src="images/tecnoaprende.png" alt="Logo TecnoAprende" class="tecnoaprende">
          <div class="acciones">
              <c:choose>
                <c:when test="${sessionScope.usuarioLogueado == null}">
                    <a href="login_registro.jsp"><button>Iniciar sesión</button></a>
                    <a href="login_registro.jsp?tab=register"><button>Registrarse</button></a>
                </c:when>

                <c:otherwise>
                    <p>Bienvenido, 
                       <strong>${fn:escapeXml(sessionScope.usuarioLogueado.afiliado.idAfiliado)}</strong>
                    </p>

                    <form action="SvCerrarSesion" method="POST" style="display:inline;">
                        <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") %>">
                        <button type="submit">Cerrar sesión</button>
                    </form>
                </c:otherwise>
            </c:choose>
          </div>
        </header>
          
        <!-- Barra de navegación tipo Capacítate -->
        <nav class="barra-pasos">
            <div class="paso paso1" onclick="abrirModalBienvenida()" style="cursor:pointer;">
                <span class="numero">1</span>
                <span class="texto">Bienvenida</span>
            </div>
            <div class="paso paso2">
                <span class="numero">2</span>
                <span class="texto">Inscríbete</span>
            </div>
            <div class="paso paso3">
                <span class="numero">3</span>
                <span class="texto">Cursos</span>
            </div>
            <div class="paso paso4">
                <span class="numero">4</span>
                <span class="texto">Más información...</span>
            </div>
        </nav>

        <section class="carrusel">

            <!-- Flecha izquierda -->
            <button class="flecha flecha-izquierda" onclick="cambiarSlide(-1)">
                &#10094;
            </button>

            <div class="slides">
                <div class="slide activo">
                    <img src="images/slide1.png" alt="Cursos TIC">
                    <div class="texto-slide">
                        <h2>Aprende e impulsa tus habilidades digitales</h2>
                        <p>Cursos gratuitos de TICs para todos</p>
                    </div>
                </div>

                <div class="slide">
                    <img src="images/slide2.png" alt="Certificados">
                    <div class="texto-slide">
                        <h2>TecnoAprende</h2>
                        <p>Tu lugar de apoyo</p>
                    </div>
                </div>

                <div class="slide">
                    <img src="images/slide3.png" alt="Educación">
                    <div class="texto-slide">
                        <h2>Colaboración TecNM Zongolica y LCNTEZ</h2>
                        <p>Todo para tí</p>
                    </div>
                </div>
            </div>

            <!-- Flecha derecha -->
            <button class="flecha flecha-derecha" onclick="cambiarSlide(1)">
                &#10095;
            </button>

            <div class="indicadores">
                <span class="dot activo" onclick="irASlide(0)"></span>
                <span class="dot" onclick="irASlide(1)"></span>
                <span class="dot" onclick="irASlide(2)"></span>
            </div>

        </section>
        
      <!-- Cursos -->
        <section class="tarjetas-home">
            <% if (usuario != null) { %>

            <div class="tarjeta">
                <i class="fas fa-user-graduate"></i>
                <h3>Curso Principiante</h3>
                <p>Aprende desde cero las bases de las TIC.</p>
                <button onclick="location.href='cursoPrincipiante.jsp'">Ver curso</button>
            </div>

            <div class="tarjeta">
                <i class="fas fa-laptop-code"></i>
                <h3>Curso Avanzado</h3>
                <p>Refuerza tus conocimientos y habilidades digitales.</p>
                <button onclick="location.href='cursoAvanzado.jsp'">Ver curso</button>
            </div>

            <div class="tarjeta">
                <i class="fas fa-circle-info"></i>
                <h3>Más información</h3>
                <p>Conoce más sobre la plataforma TecnoAprende.</p>
                <button onclick="location.href='informacion_adicional.jsp'">Ver más</button>
            </div>

            <% } else { %>

            <div class="tarjeta">
                <i class="fas fa-user-graduate"></i>
                <h3>Curso Principiante</h3>
                <p>Inicia sesión para acceder al contenido.</p>
                <button onclick="location.href='login_registro.jsp'">Iniciar sesión</button>
            </div>

            <div class="tarjeta">
                <i class="fas fa-laptop-code"></i>
                <h3>Curso Avanzado</h3>
                <p>Regístrate para continuar aprendiendo.</p>
                <button onclick="location.href='login_registro.jsp'">Registrarse</button>
            </div>

            <div class="tarjeta">
                <i class="fas fa-circle-info"></i>
                <h3>Más información</h3>
                <p>Descubre qué es TecnoAprende.</p>
                <button onclick="location.href='login_registro.jsp'">Ver información</button>
            </div>

            <% } %>
        </section>
        
    <!-- MODAL BIENVENIDA -->
    <div id="modalBienvenida" class="modal-bienvenida">

        <div class="contenido-modal-bienvenida">

            <button class="cerrar-modal-bienvenida" onclick="cerrarModalBienvenida()">
                &times;
            </button>

            <h2>¡Bienvenido a TECNOAPRENDE!</h2>

            <div class="video-bienvenida">
                <iframe
                    id="youtubeVideo"
                    src="https://www.youtube.com/embed/eCSLyArFII4"
                    title="Video de Bienvenida"
                    frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen>
                </iframe>
            </div>

        </div>
    </div>

    <!-- Pie de página -->
    <footer class="pie_de_pagina">
        <div class="footer-contenido">
        <div class="instituto">
            <a href="https://zongolica.tecnm.mx/">Instituto Tecnológico Superior de Zongolica</a>
            <div class="redes">
                <a href="https://www.facebook.com/TecNMZongolica" target="_blank">
                    <i class="fab fa-facebook"></i>
                </a>
                <a href="https://www.youtube.com/channel/UCi0_QXTliS2p_2MDwhfF8ww" target="_blank">
                    <i class="fab fa-youtube"></i>
                </a>
                <a href="https://x.com/somositsz?lang=es" target="_blank">
                    <i class="fab fa-x"></i>
                </a>
            </div>
        </div>

        <div class="casa">
            <a href="https://lcntez.org.mx/">La Casa de los Niños de Tezonapa</a>
            <div class="redes">
                <a href="https://www.facebook.com/profile.php?id=100078645709893" target="_blank">
                    <i class="fab fa-facebook"></i>
                </a>
                <a href="https://www.instagram.com/ninos_tezonapa?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw%3D%3D" target="_blank">
                    <i class="fab fa-instagram"></i>
                </a>
                <a href="https://x.com/Ninos_Tezonapa" target="_blank">
                    <i class="fab fa-x"></i>
                </a>
            </div>
        </div>
        </div>
        <div class="creditos-equipo">
            <a href="creditos.jsp"><p>© 2026 TECNOAPRENDE. Plataforma desarrollada por equipo BOX Code. Todos los derechos reservados.</p></a>
            </div>
    </footer>
    <script>
        let index = 0;

        const slides = document.querySelectorAll(".slide");
        const dots = document.querySelectorAll(".dot");

        let intervalo = setInterval(siguienteSlide, 5000);

        function mostrarSlide(n) {

            slides.forEach(slide =>
                slide.classList.remove("activo")
            );

            dots.forEach(dot =>
                dot.classList.remove("activo")
            );

            slides[n].classList.add("activo");
            dots[n].classList.add("activo");

            index = n;
        }

        function siguienteSlide() {

            let nuevo = (index + 1) % slides.length;
            mostrarSlide(nuevo);
        }

        function cambiarSlide(direccion) {

            let nuevo = index + direccion;

            if (nuevo < 0) {
                nuevo = slides.length - 1;
            }

            if (nuevo >= slides.length) {
                nuevo = 0;
            }

            mostrarSlide(nuevo);

            reiniciarCarrusel();
        }

        function irASlide(n) {

            mostrarSlide(n);

            reiniciarCarrusel();
        }

        function reiniciarCarrusel() {

            clearInterval(intervalo);

            intervalo = setInterval(siguienteSlide, 5000);
        }
        
        const modalBienvenida = document.getElementById("modalBienvenida");

        function abrirModalBienvenida() {
            modalBienvenida.style.display = "flex";
        }

        function cerrarModalBienvenida() {

            modalBienvenida.style.display = "none";

            // Detener video al cerrar
            const iframe = document.getElementById("youtubeVideo");
            iframe.src = iframe.src;
        }

        // Cerrar al dar clic fuera
        window.addEventListener("click", function(e) {

            if (e.target === modalBienvenida) {
                cerrarModalBienvenida();
            }

        });

        // Mostrar SOLO la primera vez
        window.addEventListener("load", function() {

            const yaVioBienvenida = localStorage.getItem("bienvenidaVista");

            if (!yaVioBienvenida) {

                abrirModalBienvenida();

                localStorage.setItem("bienvenidaVista", "true");
            }

        });
    </script>

    </body>
</html>