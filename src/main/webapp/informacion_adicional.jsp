<%-- informacion_adicional.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Logica.Usuario"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
    if (usuario == null) {
        response.sendRedirect("login_registro.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Información Adicional - TecnoAprende</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="icon" href="assets/favicon.ico" type="image/x-icon">
</head>
<body>

    <!-- Encabezado con imagen y sesión -->
    <header class="encabezado">
        <img src="images/ITSZ-LCNTEZ.png" alt="Encabezado de logos" class="imagen-encabezado">
        <img src="images/tecnoaprende.png" alt="Logo TecnoAprende" class="tecnoaprende">
        <div class="acciones">
            <p><strong><%= usuario.getAfiliado() != null ? org.apache.commons.text.StringEscapeUtils.escapeHtml4(usuario.getAfiliado().getIdAfiliado()) : "" %></strong></p>
            <form action="SvCerrarSesion" method="POST" style="display:inline;">
                <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") %>">
                <button type="submit">Cerrar sesión</button>
            </form>
            <a href="index.jsp"><button>Panel Principal</button></a>
        </div>
    </header>
    <main class="contenedor-curso">
        
        <!-- Título -->
        <section class="introduccion-modulo">
            <h1>Mas Información sobre: La Casa de los Niños de Tezonapa A.C.</h1>
        </section>
        
        <!-- CONTENIDO: menú lateral + area principal -->
        <div class="contenido-curso">
            <div class="menu-container">
                <!-- MENÚ LATERAL: conservamos los títulos exactos -->
                <div class="menu-lateral">
                    <h3>1. CRECIENDO CONTIGO</h3>

                    <button class="menu-btn" onclick="toggleSubmenu('sub-1-1')">
                        1.1. Prenatal <span class="chev">▸</span>
                    </button>
                    <div id="sub-1-1" class="submenu">
                        <button onclick="cargarContenido('1.1.doc')">Documento</button>
                        <button onclick="cargarContenido('1.1.videos')">Videos</button>
                    </div>

                    <button class="menu-btn" onclick="toggleSubmenu('sub-1-2')">
                        1.2. Niñas y niños de 0 a 1 año <span class="chev">▸</span>
                    </button>
                    <div id="sub-1-2" class="submenu">
                        <button onclick="cargarContenido('1.2.doc')">Documento</button>
                        <button onclick="cargarContenido('1.2.videos')">Videos</button>
                    </div>

                    <button class="menu-btn" onclick="toggleSubmenu('sub-1-3')">
                        1.3. Niñas y niños de 1 a 2.11 año <span class="chev">▸</span>
                    </button>
                    <div id="sub-1-3" class="submenu">
                        <button onclick="cargarContenido('1.3.doc')">Documento</button>
                        <button onclick="cargarContenido('1.3.videos')">Videos</button>
                    </div>

                    <button class="menu-btn" onclick="toggleSubmenu('sub-1-4')">
                        1.4. Niñas y niños de 3 a 5.11 año <span class="chev">▸</span>
                    </button>
                    <div id="sub-1-4" class="submenu">
                        <button onclick="cargarContenido('1.4.doc')">Documento</button>
                        <button onclick="cargarContenido('1.4.videos')">Videos</button>
                    </div>

                    <button class="menu-btn" onclick="toggleSubmenu('sub-1-5')">
                        1.5. Fichero para cuidadores de 0 a 36 meses <span class="chev">▸</span>
                    </button>
                    <div id="sub-1-5" class="submenu">
                        <button onclick="cargarContenido('1.5.doc')">Documento</button>
                    </div>
                    
                    <hr style="border:none;height:1px;background:#0b3f22;margin:12px 0;opacity:0.3">

                    <h3>2. NIÑEZ SEGURA Y PROTEGIDA</h3>
                    
                    <button class="menu-btn" onclick="toggleSubmenu('sub-2-1')">
                        2.1. Ambientes Seguros (Crecer Sin Violencia) <span class="chev">▸</span>
                    </button>
                    <div id="sub-2-1" class="submenu">
                        <button onclick="cargarContenido('2.1.1.doc')">Crecer Sin Violencia: Niños y Niñas 6-8 Años</button>
                        <button onclick="cargarContenido('2.1.2.doc')">Crecer Sin Violencia: Niños y Niñas 9-12 Años</button>
                        <button onclick="cargarContenido('2.1.3.doc')">Crecer Sin Violencia: Adolescentes 13-18 Años</button>
                        <button onclick="cargarContenido('2.1.4.doc')">Manual para facilitadores/as</button>
                    </div>
                    
                    <button class="menu-btn" onclick="toggleSubmenu('sub-2-2')">
                        2.2. Relaciones Positivas <span class="chev">▸</span>
                    </button>
                    <div id="sub-2-2" class="submenu">
                        <button onclick="cargarContenido('2.2.doc')">Documento</button>
                    </div>
                    
                    <button class="menu-btn" onclick="toggleSubmenu('sub-2-3')">
                        2.3. Construcción de Paz <span class="chev">▸</span>
                    </button>
                    <div id="sub-2-3" class="submenu">
                        <button onclick="cargarContenido('2.3.doc')">Documento</button>
                    </div>
                    
                    <button class="menu-btn" onclick="toggleSubmenu('sub-2-4')">
                        2.4. RDD y Cambio Climático <span class="chev">▸</span>
                    </button>
                    <div id="sub-2-4" class="submenu">
                        <button onclick="cargarContenido('2.4.1.doc')">Reducción de Riesgos y Cambio Climático</button>
                        <button onclick="cargarContenido('2.4.2.doc')">Programa Escolar de Protección Civil</button>
                        <button onclick="cargarContenido('2.4.3.doc')">Comité de Protección Civil y Seguridad Escolar</button>
                    </div>
                    
                    <button class="menu-btn" onclick="toggleSubmenu('sub-2-5')">
                        2.5. Docentes - Madres, Padres y Cuidadores <span class="chev">▸</span>
                    </button>
                    <div id="sub-2-5" class="submenu">
                        <button onclick="cargarContenido('2.5.1.doc')">Manual - Docentes</button>
                        <button onclick="cargarContenido('2.5.2.doc')">Manual - Madres, Padres y Cuidadores</button>
                    </div>
                    
                    <hr style="border:none;height:1px;background:#0b3f22;margin:12px 0;opacity:0.3">

                    <h3>3. ME QUIERO ME CUIDO</h3>
                    <button class="menu-btn" onclick="toggleSubmenu('sub-3-1')">
                        3.1. Manual - Niños y Niñas 6-8 años <span class="chev">▸</span>
                    </button>
                    <div id="sub-3-1" class="submenu">
                        <button onclick="cargarContenido('3.1.doc')">Documento</button>
                        <button onclick="cargarContenido('3.1.videos')">Videos</button>
                    </div>

                    <button class="menu-btn" onclick="toggleSubmenu('sub-3-2')">
                        3.2. Manual - Niños y Niñas 9-12 años <span class="chev">▸</span>
                    </button>
                    <div id="sub-3-2" class="submenu">
                        <button onclick="cargarContenido('3.2.doc')">Documento</button>
                        <button onclick="cargarContenido('3.2.videos')">Videos</button>
                    </div>

                    <button class="menu-btn" onclick="toggleSubmenu('sub-3-3')">
                        3.3. Manual - Adolescentes 13-19 años <span class="chev">▸</span>
                    </button>
                    <div id="sub-3-3" class="submenu">
                        <button onclick="cargarContenido('3.3.doc')">Documento</button>
                        <button onclick="cargarContenido('3.3.videos')">Videos</button>
                    </div>

                    <button class="menu-btn" onclick="toggleSubmenu('sub-3-4')">
                        3.4. Manual - Docentes <span class="chev">▸</span>
                    </button>
                    <div id="sub-3-4" class="submenu">
                        <button onclick="cargarContenido('3.4.doc')">Documento</button>
                        <button onclick="cargarContenido('3.4.videos')">Videos</button>
                    </div>

                    <button class="menu-btn" onclick="toggleSubmenu('sub-3-5')">
                        3.5. Manual - Madres, Padres y Cuidadores <span class="chev">▸</span>
                    </button>
                    <div id="sub-3-5" class="submenu">
                        <button onclick="cargarContenido('3.5.doc')">Documento</button>
                        <button onclick="cargarContenido('3.5.videos')">Videos</button>
                    </div>
                    
                    <hr style="border:none;height:1px;background:#0b3f22;margin:12px 0;opacity:0.3">
                    
                    <h3>4. PACTO</h3>
                    <button class="menu-btn" onclick="toggleSubmenu('sub-4-1')">
                        4.1. PACTO: Adolescentes de 15 a 17 Años <span class="chev">▸</span>
                    </button>
                    <div id="sub-4-1" class="submenu">
                        <button onclick="cargarContenido('4.1.doc')">Documento</button>
                    </div>
                    
                    <button class="menu-btn" onclick="toggleSubmenu('sub-4-2')">
                        4.2. PACTO: Adultos de 18 a 24 Años <span class="chev">▸</span>
                    </button>
                    <div id="sub-4-2" class="submenu">
                        <button onclick="cargarContenido('4.2.doc')">Documento</button>
                    </div>
                    
                    <button class="menu-btn" onclick="toggleSubmenu('sub-4-3')">
                        4.3. PACTO: Madres, Padres y Cuidadores<span class="chev">▸</span>
                    </button>
                    <div id="sub-4-3" class="submenu">
                        <button onclick="cargarContenido('4.3.doc')">Documento</button>
                    </div>
                    
                    <hr style="border:none;height:1px;background:#0b3f22;margin:12px 0;opacity:0.3">
                    
                    <h3>5. LIDERES COMUNITARIOS</h3>
                    <button class="menu-btn" onclick="toggleSubmenu('sub-5-1')">
                        5.1. Lideres comunitarios CFMX <span class="chev">▸</span>
                    </button>
                    <div id="sub-5-1" class="submenu">
                        <button onclick="cargarContenido('5.1.doc')">Documento</button>
                    </div>
                </div>
                
                <!-- AREA DE CONTENIDO -->
                <div id="areaContenido" class="area-contenido">
                    <h2>Selecciona un documento o video del menú</h2>
                    <h3>Los documentos y videos se abrirán en esta área.</h3>
                </div>
            </div>
        </div>
    </main>
            
    <div id="modalVideo" class="modal-video">
        <!-- Barra superior fija -->
        <div class="modal-superior">
            <span id="cerrarModalVideo" class="btn-cerrar-video" style="cursor:pointer;">✖ Cerrar</span>
            <h2 id="tituloVideo" class="titulo-modal-video"></h2>
        </div>
        <!-- Contenedor del video -->
        <div class="modal-content-video" onclick="event.stopPropagation()">
            <iframe
                id="videoReproductor" src="" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
            </iframe>
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
    
    <!-- SCRIPTS: modal + cargar contenidos dinámicos -->
    <script>
        // --- Tu función para abrir el modal (sin cambios lógicos) ---
        function abrirModalVideo(urlYoutube) {
            const modal = document.getElementById("modalVideo");
            const iframe = document.getElementById("videoReproductor");
            const titulo = document.getElementById("tituloVideo");

            // Convertir automáticamente URLs normales de YouTube a formato embed
            let embedUrl = urlYoutube;

            // Ejemplo:
            // https://www.youtube.com/watch?v=kRAGO9CR0YI
            // -> https://www.youtube.com/embed/kRAGO9CR0YI
            if (urlYoutube.includes("watch?v=")) {
                const videoId = urlYoutube.split("watch?v=")[1].split("&")[0];
                embedUrl = "https://www.youtube.com/embed/" + videoId;
            }

            // Si ya viene como /embed/, se usa directamente
            iframe.src = embedUrl;
            
            // Mostrar modal
            modal.style.display = "flex";

            // Evitar scroll del fondo
            document.body.style.overflow = "hidden";
        }
        
        function cerrarModalVideo() {
            const modal = document.getElementById("modalVideo");
            const iframe = document.getElementById("videoReproductor");

            modal.style.display = "none";

            // Limpiar src para detener la reproducción
            iframe.src = "";

            // Restaurar scroll
            document.body.style.overflow = "auto";
        }
        
        // Botón cerrar
        document.getElementById("cerrarModalVideo").onclick = cerrarModalVideo;

        // Cerrar al hacer clic fuera del cuadro del video        
        document.getElementById("modalVideo").addEventListener("click", function(e) {
            if (e.target === this) {
                cerrarModalVideo();
            }
        });

        // --- Menú lateral dinámico ---
        function toggleSubmenu(id) {
            const s = document.getElementById(id);
            if (!s) return;
            s.style.display = s.style.display === "block" ? "none" : "block";
        }

        // Contenidos (documentos y galerías) -- conservan las rutas originales
        const contenidos = {
            /* 1. CRECIENDO CONTIGO */
            "1.1.doc": `<iframe src="https://drive.google.com/file/d/1MQfGAJgzE4Dli1X8A22rrdoRIbhd_ner/preview" 
                            allow="autoplay">
                        </iframe>`,
            "1.1.videos": `
                <div class="galeria-videos">
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/embed/kRAGO9CR0YI?list=PLoaItT2Ryl0fVhFb6CQotLkpIzdZN21nl')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_PRENATAL_S2_Relajacionembarazadas.jpg" alt="Video 1">
                        <h3 class="titulo-video">S2 - Técnica de relajación para embarazadas</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=DZ_mxQP75OE')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_PRENATAL_S3_Serpientecascabel.jpg" alt="Video 2">
                        <h3 class="titulo-video">S3 - La serpiente Cascabel</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=R9WPMcP2Cvo')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_PRENATAL_D1_sobrelapelota.jpg" alt="Video 3">
                        <h3 class="titulo-video">D1 - Sobre la pelota Miss rossi</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=YDxXF7FDXNk')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_PRENATAL_D1_baileziguzago.jpg" alt="Video 4">
                        <h3 class="titulo-video">D1 - El baile Zigu Zago</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=XT5dj_WGDYg')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_PRENATAL_D4_GRACIASPORESTAR.jpg" alt="Video 5">
                        <h3 class="titulo-video">D4 - Canción para cantarle a los hijos: GRACIAS POR ESTAR AQUÍ. Por La Totuga</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=74fDtHRpQdk')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_PRENATAL_D4_RESPIRACIONRELAJARSE.jpg" alt="Video 6">
                        <h3 class="titulo-video">D4 - Técnicas de respiración para relajarse | ActitudFem</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=_aSvSg2utnM&feature=youtu.be')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_PRENATAL_D4_SENSIONESINTRAUTERINAS.jpg" alt="Video 7">
                        <h3 class="titulo-video">D4 - Sensiones intrauterinas</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=2vuyL3bQqaQ')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_PRENATAL_A2N2_ROMPEHIELOS.jpg" alt="Video 8">
                        <h3 class="titulo-video">A2N2 - DINÁMICAS DE INTEGRACIÓN/ ROMPE HIELO "LA TORTUGA / CUANDO YO A LA SELVA FUI"</h3>
                    </div>
                </div>`,

            "1.2.doc": `<iframe src="https://drive.google.com/file/d/1AQ3YdjYBA0dr8Nuq4aRIFD1vOW9tSwJz/preview" 
                            allow="autoplay">
                        </iframe>`,
            "1.2.videos": `
                <div class="galeria-videos">
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=blhDOaCakMk')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_0A1_D6_PINGUINO.jpg" alt="Video 9">
                        <h3 class="titulo-video">D6 - Canción pingüinos</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=BCy42C42UXY')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_0A1_D6_AHI_NO_ESTA.jpg" alt="Video 10">
                        <h3 class="titulo-video">D6 - Canción ahí esta, no esta</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=c-VB3u3U_7Q')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_0A1_D10_CARGOACOMODO.jpg" alt="Video 11">
                        <h3 class="titulo-video">D10 - ¿Cómo cargo y acomodo a mi bebé?</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=vSgtxe-fyXU&feature=youtu.be')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_0A1_D10_YOTENGOUNTIC.jpg" alt="Video 12">
                        <h3 class="titulo-video">D10 - YO TENGO UN TIC</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=NbVWhSt0g9A&feature=youtu.be')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_0A1_N3_LACTANCIAUNACTODEAMOR.jpg" alt="Video 13">
                        <h3 class="titulo-video">N3 - Video animado para promover la lactancia materna, un acto de amor y de supervivencia infantil</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=-LbTvDjFGu8')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_0A1_N3_TECNICASLACTANCIA.jpg" alt="Video 14">
                        <h3 class="titulo-video">N3 - Maternidad: Técnicas de amamantamiento</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=R9248DhkhaM')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_0A1_N3_PROHIBIDOLACTANCIA.jpg" alt="Video 15">
                        <h3 class="titulo-video">N3 - ¿Qué está prohibido durante la lactancia?</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=fPaHdb1sXec')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_0A1_P2_ESTIMULACIONSOCIOAFECTIVA.jpg" alt="Video 16">
                        <h3 class="titulo-video">P2 - Magníficos tips de Estimulación Socio Afectiva!</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=Q41RHfNZX0U&feature=youtu.be')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_0A1_A4_QUEESINTELIGENCIAEMOCIONAL.jpg" alt="Video 17">
                        <h3 class="titulo-video">A4 - Inteligencia emocional Daniel Goleman</h3>
                    </div>
                </div>`,

            "1.3.doc": `<iframe src="https://drive.google.com/file/d/1qSH8Dt_zhnQFHmJOIcDmCcYOVCDrepGC/preview" 
                            allow="autoplay">
                        </iframe>`,
            "1.3.videos": `
                <div class="galeria-videos">
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=svpBNrWFhkU')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_D11_GALLINAMOROCHITA.jpg" alt="Video 18">
                        <h3 class="titulo-video">D11 - La gallina morochita</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=rSaoH8OB2R8')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_D12_LEONRATON.jpg" alt="Video 19">
                        <h3 class="titulo-video">D12 - El León y el Ratón</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=VN_eb1XRIpQ')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_D12_HACERPLASTILINA.jpg" alt="Video 20">
                        <h3 class="titulo-video">D12 - Como Hacer Plastilina Play Doh Fácil</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=lGf90VdwmmM')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_N6_TRENECITO.jpg" alt="Video 21">
                        <h3 class="titulo-video">N6 - Dinámicas - El Trenecito</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=Zbhy4_cEOnE')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_P7_PADRESTOXICOS10.jpg" alt="Video 22">
                        <h3 class="titulo-video">P7 - 10 Rasgos de padres tóxicos</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=FTrCWcL-4pE')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_P19_SANTOREMEDIO.jpg" alt="Video 23">
                        <h3 class="titulo-video">P19 - CANTICUÉNTICOS - SANTO REMEDIO</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=pbFtRuNwusw')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_PV1_AMORCHIQUITO.jpg" alt="Video 24">
                        <h3 class="titulo-video">PV1 - Amor Chiquito Cepillín</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=Mx6h2jCb3WE')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_PV1_HONORMUERTE.jpg" alt="Video 25">
                        <h3 class="titulo-video">PV1 - El honor o la muerte</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=BSLinSNXkrs')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_PV1_SIEMBRAUNBESO.jpg" alt="Video 26">
                        <h3 class="titulo-video">PV1 - Siembra un beso</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=tNr7vHlxDXU')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_PV2_SIESTASFELIZ.jpg" alt="Video 27">
                        <h3 class="titulo-video">PV2 - Si estás feliz - Barney</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=AzMNxmZ1YZU')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_PV2_FILIPON.jpg" alt="Video 28">
                        <h3 class="titulo-video">PV2 - El cuento de Filipón</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=7vFfnVutWV4')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_PV4_SOYUNASERPIENTE.jpg" alt="Video 29">
                        <h3 class="titulo-video">PV4 - Soy una serpiente</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=gHFG_022d-8')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_PV4_TOMADITOS.jpg" alt="Video 30">
                        <h3 class="titulo-video">PV4 - Tomaditos en parejas</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=RGQl1Vw3n3Y')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_A7_NOESMAÑA.jpg" alt="Video 31">
                        <h3 class="titulo-video">A7 - No es maña</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=CLKsTleZB3A')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_A7_COMUNICACION.jpg" alt="Video 32">
                        <h3 class="titulo-video">A7 - Como mejorar la comunicación</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=FbNtIqHg_Y4')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_A9_EMOCIONES.jpg" alt="Video 33">
                        <h3 class="titulo-video">A9 - El Baile de las Emociones</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=m1so5trQAJM')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_A9_DRAGONCITO.jpg" alt="Video 34">
                        <h3 class="titulo-video">A9 - El dragoncito</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=4adhRqmSsYE')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_1A2_RDD4_RESILENCIAFAMILIAR.jpg" alt="Video 35">
                        <h3 class="titulo-video">RDD4 - Resiliencia familiar</h3>
                    </div>
                </div>`,

            "1.4.doc": `<iframe src="https://drive.google.com/file/d/1vqZK0Lf83UW9Gx1FYU6g-ew4zMR5H-ZV/preview" 
                            allow="autoplay">
                        </iframe>`,
            "1.4.videos": `
                <div class="galeria-videos">
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=NiS75gUB1WM')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_D18_MARIPOSITA.jpg" alt="Video 36">
                        <h3 class="titulo-video">D18 - La mariposita</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=Ml2tD4P65VE')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_D9_RECTANUMERICA.jpg" alt="Video 37">
                        <h3 class="titulo-video">D19 - Recta númerica</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=tNwWta2Ujzw')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_D19_PENSAMIENTOLOGICO3AÑOS.jpg" alt="Video 38">
                        <h3 class="titulo-video">D19 - Pensamiento lógico</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=IiCSEtd3oQE')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_D19_CIRCUITOFORMAS.jpg" alt="Video 39">
                        <h3 class="titulo-video">D19 - Circuito formas</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=CmcidCd8_eY')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_D20_EXPLORADORESBAGGIO.jpg" alt="Video 40">
                        <h3 class="titulo-video">D20 - Los exploradores</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=uF_iWov4NPE')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_P10_MEJORVIDEO.jpg" alt="Video 41">
                        <h3 class="titulo-video">P10 - Elegido el mejor video</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=ZZ7yCA5IBTU')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_D11_REGLAS.jpg" alt="Video 42">
                        <h3 class="titulo-video">P11 - Las reglas</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=RoJWn4yVAho')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_D14_CASTIGOVIOLENCIA.jpg" alt="Video 43">
                        <h3 class="titulo-video">P14 - El castigo genera violencia</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=7b62Kkzk550')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_P23_APRENDEACUIDARDETI.jpg" alt="Video 44">
                        <h3 class="titulo-video">P23 - Aprende a cuidar de ti</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=LQjVt5e6WCQ')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_P23_LIBROTERE.jpg" alt="Video 45">
                        <h3 class="titulo-video">P23 - El libro de Tere</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=Stk31l9dUXs')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A_P23_DECIRNO.jpg" alt="Video 46">
                        <h3 class="titulo-video">P23 - Decir no</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=v65Pu0sdTOk')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_P24_TRABAJOINFANTIL.jpg" alt="Video 47">
                        <h3 class="titulo-video">P24 - Soluciones contra el trabajo infantil</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=rzliJcQ3Amk')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_A11_SALUDARLASMANOS.jpg" alt="Video 48">
                        <h3 class="titulo-video">A11 - Saludar las manos</h3>
                    </div>
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=xKatkpJN6hc')">
                        <img src="images/1. CRECIENDO CONTIGO/CC_3A5_A12_COMUNICACIÓNEFECTIVA.jpg" alt="Video 49">
                        <h3 class="titulo-video">A12 - Comunicación efectiva</h3>
                    </div>
                </div>`,

            "1.5.doc": `<iframe src="https://drive.google.com/file/d/11dMxKiXAOe-JfACuCG_S9sb-Wt348afn/preview" 
                            allow="autoplay">
                        </iframe>`,
            
            /* 2. NIÑEZ SEGURA Y PROTEGIDA*/
            "2.1.1.doc": `<iframe src="https://drive.google.com/file/d/152yh0J7OBeZHoZYtw_sgJFHGpN4YbryT/preview" 
                            allow="autoplay">
                        </iframe>`,
            "2.1.2.doc": `<iframe src="https://drive.google.com/file/d/1PcQPkUPh4JWvYvJsLrdVutmOt1J39qzI/preview" 
                            allow="autoplay">
                        </iframe>`,
            "2.1.3.doc": `<iframe src="https://drive.google.com/file/d/1nNtEqi1Tg5bekjhCHmNfHl5ZlDGfC9K0/preview" 
                            allow="autoplay">
                        </iframe>`,
            "2.1.4.doc": `<iframe src="https://drive.google.com/file/d/11v4niBxHO9zsxPQdnkZouz2JbjK-wdQW/preview" 
                            allow="autoplay">
                        </iframe>`,
            
            "2.2.doc": `<iframe src="https://drive.google.com/file/d/1I91BEfIi95S0iVxu7gUeufLUsFJJECrw/preview" 
                            allow="autoplay">
                        </iframe>`,
            
            "2.3.doc": `<iframe src="https://drive.google.com/file/d/1r7a81Euajk4xX_UMfRdLs74RsUNtGUqo/preview" 
                            allow="autoplay">
                        </iframe>`,
            
            "2.4.1.doc": `<iframe src="https://drive.google.com/file/d/1azVcENuXoQL1OZkOw0aGbvtizC0Am_my/preview" 
                            allow="autoplay">
                        </iframe>`,
            "2.4.2.doc": `<iframe src="https://drive.google.com/file/d/1CtZhYUqdCZIeK2hDiD-mujkwlKJtp6nA/preview" 
                            allow="autoplay">
                        </iframe>`,
            "2.4.3.doc": `<iframe src="https://drive.google.com/file/d/1uJj0AW_WRFLhLBAxUUUMkbzQ6gz2anib/preview" 
                            allow="autoplay">
                        </iframe>`,
            
            "2.5.1.doc": `<iframe src="https://drive.google.com/file/d/168ixccnwzK81Yy8pts0lzaX1VYuAYY_a/preview" 
                            allow="autoplay">
                        </iframe>`,
            "2.5.2.doc": `<iframe src="https://drive.google.com/file/d/1xQpAvRLU1FJJfwd8SXl_DIdBIrR2MQWH/preview" 
                            allow="autoplay">
                        </iframe>`,
            
            /* 3. ME QUIERO ME CUIDO*/
            "3.1.doc": `<iframe src="https://drive.google.com/file/d/1kxy-0MyM155dm_SHAShOt5Ifio46d85Y/preview" 
                            allow="autoplay">
                        </iframe>`,
            "3.1.videos": `
                <div class="galeria-videos">
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=rzliJcQ3Amk')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_SS_7_SALUDAR.jpg" alt="Video 57">
                        <h3 class="titulo-video">SS7 - Saludar las manos</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=OzTlzkm-5xo')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_SS_7_SECRETOSSIYNO.jpg" alt="Video 58">
                        <h3 class="titulo-video">SS7 - Secreto Sí, Secreto No</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=8gQMg0MDUvo')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_SS_8_DOKIBAÑO.jpg" alt="Video 59">
                        <h3 class="titulo-video">SS8 - Doki - Baño</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=RRqdysPnjgE')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_SS_8_NOBAÑAR.jpg" alt="Video 60">
                        <h3 class="titulo-video">SS8 - No me  Quiero Bañar - Tatiana</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=4Xs1tHmS9_4')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_SS_9_MICUERPO.jpg" alt="Video 61">
                        <h3 class="titulo-video">SS9 - Mi Cuerpo</h3>
                    </div>
                    
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=yDD-pojvoy8')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_GEN_2_ALEALE.jpg" alt="Video 50">
                        <h3 class="titulo-video">GEN2 - Ale, Ale...</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=TUuQcoxvRsQ')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_GEN_6_PECAS.jpg" alt="Video 51">
                        <h3 class="titulo-video">GEN6 - Pecas</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=13iIdPBmYBw')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_GEN_11_BLANCANIEVES.jpg" alt="Video 52">
                        <h3 class="titulo-video">GEN11 - Blanca Nieves - Disney</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=NZyl4iXw6tM')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_GEN_11_BLANCANIEVES1.jpg" alt="Video 53">
                        <h3 class="titulo-video">GEN11 - Blanca Nieves - Cosas de Peques</h3>
                    </div>
                    
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=ZQcvjZXmf2s')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_VIN_1_PARTESPRIVADAS.jpg" alt="Video 62">
                        <h3 class="titulo-video">VIN1 - Prevención de Abuso Sexual Infantil</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=wFjFwaMqIkY')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_VIN_3_FILIPON.jpg" alt="Video 63">
                        <h3 class="titulo-video">VIN3 - La Playera de Filipón</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=RUx1eUdBLJ8')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_VIN_7_DISTANCIASINO.jpg" alt="Video 64">
                        <h3 class="titulo-video">VIN7 - Distancia Sí, Distancia No</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=CNmnEMkz9PU')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_VIN_7_KIKOYLAMANO.jpg" alt="Video 65">
                        <h3 class="titulo-video">VIN7 - Kiko y La Mano</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=B6IuhWa5v4A')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_VIN_9_5CONSEJOSTECNOLOGÍA.jpg" alt="Video 66">
                        <h3 class="titulo-video">VIN9 - 5 Consejos para el Buen Uso de la Tecnología</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=CTdGWOjugZ0')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_RDD_4_911.jpg" alt="Video 54">
                        <h3 class="titulo-video">RRD4 - 911</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=np-lIX74niY')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_RDD_4_ABCPREVENCION.jpg" alt="Video 55">
                        <h3 class="titulo-video">RRD4 - ABC Prevención</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=-whVXBiOTCc')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_6a8_RRD_1_MONSTRUOCOLORES.jpg" alt="Video 56">
                        <h3 class="titulo-video">RRD1 - El Monstruo de Colores</h3>
                    </div>
                </div>`,

            "3.2.doc": `<iframe src="https://drive.google.com/file/d/1CWLHOuZbH3YrC-Zl8oaFYPIq5e2yCiss/preview" 
                            allow="autoplay">
                        </iframe>`,
            "3.2.videos": `
                <div class="galeria-videos">
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=ZBa4-PX6jwE')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_SS_11_EDUCACIONSEXUALDERECHO.jpg" alt="Video 76">
                        <h3 class="titulo-video">SS11 - La Educación Sexual es un Derecho</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=r51gox_MrIw')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_SS_15_DELATIERRA.jpg" alt="Video 77">
                        <h3 class="titulo-video">SS15 - De la Tierra</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=V8wtlEZeOw4')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_SS_16_CONCENTIMIENTO.jpg" alt="Video 78">
                        <h3 class="titulo-video">SS16 - Consentimiento para Niños</h3>
                    </div>
        
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=mcl1-_1Fmio')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_GEN_4_ESTEREOTIPOS.jpg" alt="Video 67">
                        <h3 class="titulo-video">GEN4 - ¿Qué son los Estereotipos de Género?</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=1VqO6edXJpk')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_GEN_8_MANOSCOLORES.jpg" alt="Video 68">
                        <h3 class="titulo-video">GEN8 - Vivan las Manos de Colores</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=lTlMnZfXgwk')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_GEN_11_MONJITA.jpg" alt="Video 69">
                        <h3 class="titulo-video">GEN11 - Tengo una tía que no es monjita</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=xHwNlDzSOsY')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_GEN_14_CIENTIFICAS.jpg" alt="Video 70">
                        <h3 class="titulo-video">GEN14 -  Científicas Mexicanas</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=67bz4uecB8U')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_GEN_15_MASCULINIDADES.jpg" alt="Video 71">
                        <h3 class="titulo-video">GEN15 - Nuevas Masculinidades</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=hOihJQMUPXE')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_GEN_16_MARIECURIE.jpg" alt="Video 72">
                        <h3 class="titulo-video">GEN16 - Marie Curie</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=Bcw531Ebmq8')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_GEN_17_JUEGOIGUALDAD.jpg" alt="Video 73">
                        <h3 class="titulo-video">GEN17 - Jugando con Igualdad</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=Okc-xuHRxxc')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_GEN_20_OLIVER.jpg" alt="Video 74">
                        <h3 class="titulo-video">GEN20 - Oliver Button es una nena</h3>
                    </div>
        
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=R5s5iykGz90')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_VIN_1_ESTELA.jpg" alt="Video 79">
                        <h3 class="titulo-video">VIN1 - ¡Estela, grita muy fuerte!</h3>
                    </div>
        
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=s4UqbAYze_U')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_VIN_4_HAYSECRETOS.jpg" alt="Video 81">
                        <h3 class="titulo-video">VIN4 - Hay Secretos</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=eL9QhJLB9ew')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_VIN_11_CONMIGO.jpg" alt="Video 80">
                        <h3 class="titulo-video">VIN11 - Yo voy conmigo</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=GJmXRJiAc54')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_9A12_RDD_1_SEMOVIO.jpg" alt="Video 75">
                        <h3 class="titulo-video">RRD1 - El día en que Todo se movio</h3>
                    </div>
                </div>`,

            "3.3.doc": `<iframe src="https://drive.google.com/file/d/1tZUrY_1AnPbeRnqqW9hbA_67VIF_FK3T/preview" 
                            allow="autoplay">
                        </iframe>`,
            "3.3.videos": `
                <div class="galeria-videos">
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=T4Va_Czm3uQ')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_AYJ_SS_3_RATON.png" alt="Video 83">
                        <h3 class="titulo-video">SS3 - Mouse for Sale (Ratón en venta)</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=ZBa4-PX6jwE')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_AYJ_SS_4_EDUSEXUAL.png" alt="Video 84">
                        <h3 class="titulo-video">SS4 - La Educación Sexual es un Derecho</h3>
                    </div>
        
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=eHTUAgvbaE0')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_AYJ_GEN_11_DERECHOS.png" alt="Video 82">
                        <h3 class="titulo-video">GEN11 - Derechos Sexuales de Adolescentes y Jovenes</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=rqpONl1VgyU')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_AYJ_VIN_2_GROOMING.png" alt="Video 85">
                        <h3 class="titulo-video">VIN2 - Grooming</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=dF5h2-T9dmI')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_AYJ_VIN_3_HECHONADA.png" alt="Video 86">
                        <h3 class="titulo-video">VIN3 - Si yo no le he hecho nada</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=wIY2ilKjz8s')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_AYJ_VIN_3_NOCONFUNDIR.png" alt="Video 87">
                        <h3 class="titulo-video">VIN3 - Don't confuse love and abuse (No confundas amor y abuso)</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=ER8TLuQjE1w')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_AYJ_VIN_3_PREVENCION.png" alt="Video 88">
                        <h3 class="titulo-video">VIN3 - Prevenvión de la violencia en el noviazgo durante la adolescencia</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=mKztm1QBxL4')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_AYJ_VIN_5_CALLE.png" alt="Video 89">
                        <h3 class="titulo-video">VIN5 - Por la calle</h3>
                    </div>
                </div>`,

            "3.4.doc": `<iframe src="https://drive.google.com/file/d/1D5mHcMpbJm89osOrPLjiqm-RYxvRV2Ex/preview" 
                            allow="autoplay">
                        </iframe>`,
            "3.4.videos": `
                <div class="galeria-videos">
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=MJrUSD8H2L4')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_DOC_SS_5_BAJOSOMBRAS.png" alt="Video 94">
                        <h3 class="titulo-video">SS5 - Bajo Sombras</h3>
                    </div>
        
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/shorts/GQyZ7li7o_w')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_DOC_GEN_5_MARFIL.png" alt="Video 90">
                        <h3 class="titulo-video">GEN5 - Las Estatuas de Marfil</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=1QbTZYiQ6BA')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_DOC_GEN_8_DIVERSIDADSEXUAL.png" alt="Video 91">
                        <h3 class="titulo-video">GEN8 - Diversidad Sexual</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=qkFTf0Ahcnk')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_DOC_GEN_8_NORMALMILAVADORA.png" alt="Video 92">
                        <h3 class="titulo-video">GEN8 - Normal es un Programa de Mi Lavadora</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=7gtidMMNrfg')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_DOC_VIN_3_BAILEYELSALON.png" alt="Video 95">
                        <h3 class="titulo-video">VIN3 - Baile y El Salón</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=D8hUVCQvdfU')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_DOC_VIN_3_TESTIMONIOSHOMOFOBIA.png" alt="Video 96">
                        <h3 class="titulo-video">VIN3 - 7 Testimonios de homofobia, lesbofobia y transfobia en México</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=vyBCeA7jrqQ')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_DOC_VIN_4_ACOSOSEXUALESCUELA.png" alt="Video 97">
                        <h3 class="titulo-video">VIN4 - Acoso Sexual en las Escuelas de México</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=mKztm1QBxL4')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_DOC_VIN_4_CALLE.png" alt="Video 98">
                        <h3 class="titulo-video">VIN4 - Por la Calle</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=VaY3Xgzhnjc')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_DOC_VIN_8_LEYOLIMPIA.png" alt="Video 99">
                        <h3 class="titulo-video">VIN8 - Ley Olimpia</h3>
                    </div>
                    
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=228UWn1g9Fc')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_DOC_RDD_3_PAJARODELALMA.png" alt="Video 93">
                        <h3 class="titulo-video">RRD3 - El Parjaro del Alma</h3>
                    </div>
                </div>`,

            "3.5.doc": `<iframe src="https://drive.google.com/file/d/1QAzmKSIHOihHo-s1zYu9oXAWf1F2S6-O/preview" 
                            allow="autoplay">
                        </iframe>`,
            "3.5.videos": `
                <div class="galeria-videos">
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=6x7C99WThp0')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_SS_9_HMENSTRUAL.png" alt="Video 107">
                        <h3 class="titulo-video">SS9 - Día Internacional de la Higiene Menstrual</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=JSDmUD210f4')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_SS_9_POBREZAMENSTRUAL.png" alt="Video 108">
                        <h3 class="titulo-video">SS9 - La Pobreza Menstrual</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=mmIYVfYIf_0')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_SS_10_MICUERPOYODECIDO.png" alt="Video 109">
                        <h3 class="titulo-video">SS10 - Mi Cuerpo, Yo Decido</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=eHTUAgvbaE0')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_SS5_ Y_RDD_5_DERECHOSEX.png" alt="Video 110">
                        <h3 class="titulo-video">RRD5  - Derechos sexuales de Adolescentes y jóvenes</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=FV2EooKbrhA')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_GEN _1_DERECHOSHIJOS.png" alt="Video 101">
                        <h3 class="titulo-video">GEN1 - ¿Por qué hablar de derechos sexuales y reproductivos con mis hijas e hijos?</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=KGo3--B6mUc')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_GEN _8_ONUEQUIDAD.png" alt="Video 102">
                        <h3 class="titulo-video">GEN8 - ONU: Estereotipos de Género</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=na0keehQd_c')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_GEN_8_ JUGUETESNN.png" alt="Video 103">
                        <h3 class="titulo-video">GEN8 - Juguetes</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=ibp5iJ8cJhc')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_GEN_11_ORDENCOSAS.png" alt="Video 104">
                        <h3 class="titulo-video">GEN11 - El orden de las cosas</h3>
                    </div>
        
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=CZWu-BU2NiM')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_VIN_2_LIBROTERESEBAS.png" alt="Video 111">
                        <h3 class="titulo-video">VIN2 - El Libro de Sebas</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=JkvU8kJuoJc')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_VIN_4_TIPOSDEVIOLENCIA.png" alt="Video 112">
                        <h3 class="titulo-video">VIN4 - Violencia Sexual</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=0Z447t3-6TA')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_VIN_9_AUTOEFICACIA.png" alt="Video 113">
                        <h3 class="titulo-video">VIN9 - Auto-eficacia</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=cwBv4j8Wbbs')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_VIN_10_7PASOSEMOCIONES.png" alt="Video 114">
                        <h3 class="titulo-video">VIN10 - Siete pasos para ayudar a tu hijo a entender sus emociones</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=ryf5iHLdWHM')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_RDD_2_MARCOSENDAI.png" alt="Video 105">
                        <h3 class="titulo-video">RRD2 - Marco de Sendai</h3>
                    </div>

                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=W9tGUHNJ4eo')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_MAPACUI_RDD_4_MANEJOHIGIENE.png" alt="Video 106">
                        <h3 class="titulo-video">RRD4 - La Gestión de Higiene Menstrtual</h3>
                    </div>
                    
                    <div class="video-item" onclick="abrirModalVideo('https://www.youtube.com/watch?v=NjhvcZQ6h7o')">
                        <img src="images/3. ME QUIERO ME CUIDO/MQMC_ EXTRA_ SEXUALIDAD EN ADOLESCETES.png" alt="Video 100">
                        <h3 class="titulo-video">Extra - Salud sexual y reproductiva en adolescentes</h3>
                    </div>
                </div>`,
            
            /* 4. PACTO*/
            "4.1.doc": `<iframe src="https://drive.google.com/file/d/1Q1BiRWJfOEQeLkjOIKUUtXPGquAk-6Nu/preview" 
                            allow="autoplay">
                        </iframe>`,
            "4.2.doc": `<iframe src="https://drive.google.com/file/d/1pn0IobLGSizV0K-vpW7Riskmw9N39e8f/preview" 
                            allow="autoplay">
                        </iframe>`,
            "4.3.doc": `<iframe src="https://drive.google.com/file/d/1ED6dTm3tAY2jUggNwGkHXl2Q72Y1m6JM/preview" 
                            allow="autoplay">
                        </iframe>`,
            
            /* 5. LIDERES COMUNITARIOS*/            
            "5.1.doc": `<iframe src="https://drive.google.com/file/d/1w5KebUtsx1LhOIN6K0L3z0HQRaPSujQB/preview" 
                            allow="autoplay">
                        </iframe>`
        };

        // función que recibe la clave '1.1.doc' o '1.1.videos' o '2.doc' ...
        function cargarContenido(clave) {
            const area = document.getElementById("areaContenido");
            if (!area) return;

            if (!contenidos[clave]) {
                area.innerHTML = `<h2>Contenido no disponible</h2><p>No se encontró contenido para "${clave}".</p>`;
                return;
            }

            area.innerHTML = contenidos[clave];
            
            // Nuevo: Si la pantalla es pequeña, deslizar suavemente
            if (window.innerWidth <= 768) { 
                area.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        }
        
          // Marcar botón activo en el menú
        const botonesMenu = document.querySelectorAll(".menu-btn");

        botonesMenu.forEach(btn => {
            btn.addEventListener("click", function () {

                // Quitar el activo a todos
                botonesMenu.forEach(b => b.classList.remove("activo"));

                // Agregar activo al que se presiona
                this.classList.add("activo");
            });
        });
    </script>
</body>
</html>
