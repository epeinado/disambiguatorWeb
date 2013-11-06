<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Calliope</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <link rel="shortcut icon" href="../../images/favicon.gif"/>
    <link rel="stylesheet" type="text/css" href="../../css/style.css"/>
</head>
<script src="../../js/jquery-2.0.3.min.js" type="text/javascript"></script>

<script type="text/javascript">

    // esperamos que el DOM cargue
    $(document).ready(function () {
        // definimos las opciones del plugin AJAX FORM
        var opciones = {
            beforeSubmit: mostrarLoader, //funcion que se ejecuta antes de enviar el form
            success: mostrarRespuesta //funcion que se ejecuta una vez enviado el formulario
        };
        //asignamos el plugin ajaxForm al formulario myForm y le pasamos las opciones
        $('#myForm').ajaxForm(opciones);

        //lugar donde defino las funciones que utilizo dentro de "opciones"
        function mostrarLoader() {
//            $(#loader_gif).fadeIn("slow"); //muestro el loader de ajax
        };
        function mostrarRespuesta(responseText) {
            alert("Mensaje enviado: " + responseText);  //responseText es lo que devuelve la página contacto.php. Si en contacto.php hacemos echo "Hola" , la variable responseText = "Hola" . Aca hago un alert con el valor de response text
//            $("#loader_gif").fadeOut("slow"); // Hago desaparecer el loader de ajax
//            $("#ajax_loader").append("<br>Mensaje: " + responseText); // Aca utilizo la función append de JQuery para añadir el responseText  dentro del div "ajax_loader"
        };

    });

</script>
<body>
<!--Header Begin-->
<div id="header">
    <div class="center">
        <div id="logo"><a href="#">Desambiguator</a></div>
        <!--Menu Begin-->
        <%--<div id="menu">--%>
        <%--<ul>--%>
        <%--<li><a class="active" href="index.html"><span>Home</span></a></li>--%>
        <%--<li><a href="about.html"><span>About</span></a></li>--%>
        <%--<li><a href="#"><span>Services</span></a></li>--%>
        <%--<li><a href="#"><span>Contact</span></a></li>--%>
        <%--</ul>--%>
        <%--</div>--%>
        <!--Menu END-->
    </div>
</div>
<div id="midrow">
    <div id="container">
        <div class="box">
            <h1>Choose domain</h1>
            <a class="plan" href="#">Business Plan</a>
            <select name="domain">
                <option value="hotel">hotel</option>
                <option value="telco">telco</option>
            </select>
            <%--<p><a>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget consequat odio. Proin sapien erat, venenatis ut mollis vel, pulvinar in eros. Cras vel felis massa, a vulputate leo.</a><br />--%>
            <%--<br />--%>
            <%--<a href="#" class="button"><span>Learn More</span></a></p>--%>
        </div>
        <div class="box">
            <h1>Type the topic</h1>
            <a class="whyus" href="#">Type the topic</a>
            <input type="text" name="topic">
            <%--<p><a>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget consequat odio. Proin sapien erat, venenatis ut mollis vel, pulvinar in eros. Cras vel felis massa, a vulputate leo.</a><br />--%>
            <%--<br />--%>
            <%--<a href="#" class="button"><span>Learn More</span></a></p>--%>
        </div>
        <div class="box last">
            <h1>Type the word</h1>
            <a class="support" href="#">Type the word</a>
            <input type="text" name="topic">
            <%--<p><a>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget consequat odio. Proin sapien erat, venenatis ut mollis vel, pulvinar in eros. Cras vel felis massa, a vulputate leo.</a><br />--%>
            <%--<br />--%>
            <%--<a href="#" class="button"><span>Learn More</span></a></p>--%>
        </div>
    </div>
</div>
<!--MiddleRow END-->
<!--BottomRow Begin-->
<div id="bottomrow">
    <div class="textbox">


        <form id="myForm" action="/saveResults.html" method="get">


            <c:forEach var="loop" items="${synsets}">

            <input type="hidden" name="synset" value="${loop.synset}">
            <input type="hidden" name="word" value="${word}">
            <input type="hidden" name="topic" value="${topic}">
            <input type="hidden" name="domain" value="${domain}">
            <input type="hidden" name="pos" value="${loop.pos}">


                <%--<p>meaning : ${loop.meaning}</p>--%>
            <input type="hidden" name="meaning" value="${loop.meaning}">


            <div class="wrapper_list">
                <ul>
                    <li class="postagging">
                        <p>
                            <c:if test="${loop.pos == 'r'}">
                                Adverbio
                            </c:if>
                            <c:if test="${loop.pos == 'v'}">
                                Verbo
                            </c:if>
                            <c:if test="${loop.pos == 'n'}">
                                Nombre
                            </c:if>
                            <c:if test="${loop.pos == 'a'}">
                                Adjetivo
                            </c:if>
                        </p>
                    </li>
                    <li class="meaning">
                        <!--	<h1></h1>
                            <p>synset : 03076708</p>
                            <p>pos : n</p>
                        -->
                        <h1> meaning </h1>

                        <p> ${loop.meaning} </p>
                    </li>
                    <li class="contenedor_def">
                        <ul>
                            <li class="definicion">
                                <h1>words</h1>

                                <p>
                                    <c:forEach var="enWords" items="${loop.englishWords}">
                                        ${enWords}
                                    </c:forEach>
                                </p>
                            </li>
                            <li class="definicion">
                                <h1>spanish words</h1>

                                <p>
                                    <c:forEach var="esWords" items="${loop.spanishWords}">
                                        ${esWords},
                                    </c:forEach>
                                </p>
                            </li>
                            <li class="definicion">
                                <h1>italian words</h1>

                                <p>
                                    <c:forEach var="itWords" items="${loop.italianWords}">
                                        ${itWords},
                                    </c:forEach>
                                </p>
                            </li>
                        </ul>
                    </li>
                    <input maxlength="6" class="rangevalue positivo" id="rangevalueP${loop.synset}" value="50.0%"
                           onchange="if (value.substring(value.length-1) != '%') value = value + '%'; if (Number(value.substring(0,value.length-1)) > 100) value = '100%'; rangeinputP${loop.synset}.value=value.substring(0,value.length-1);"/>

                    <p id="titulo_rango" class="positivo"> Positivo </p>
                    <li id="slider">
                        <input class="bar" type="range" id="rangeinputP${loop.synset}" value="50.0" min="0.0"
                               max="100.0" step="0.1"
                               onchange="rangevalueP${loop.synset}.value=value+'%'"/>
                        <span class="highlight"></span>
                    </li>

                    <input maxlength="6" class="negativo rangevalue" id="rangevalueN${loop.synset}" value="50.0%"
                           onchange="if (value.substring(value.length-1) != '%') value = value + '%'; if (Number(value.substring(0,value.length-1)) > 100) value = '100%'; rangeinputN${loop.synset}.value=value.substring(0,value.length-1)"/>

                    <p id="titulo_rango" class="negativo"> Negativo </p>
                    <li id="slider">
                        <input class="bar negativo" type="range" id="rangeinputN${loop.synset}" min="0.0" max="100.0"
                               step="0.1"
                               value="50.0" onchange="rangevalueN${loop.synset}.value=value+'%'"/>
                        <span class="highlight"></span>
                    </li>

                </ul>

            </div>
                <%--TODO: necesito estos campos para crear el objeto--%>
                <%--<input type="text" name="positive">--%>
                <%--<br>--%>
                <%--<input type="text" name="negative">--%>
                <%--<br>--%>

            <input type="submit" value="Enviar"/>

                <%--<div id="ajax_loader"><img id="loader_gif" src="loader.gif" style=" display:none;"/></div>--%>
        </form>

        </c:forEach>


        <%--<h1>${message}</h1>--%>

        <%--<form id="myForm" action="/saveResults.html" method="get">--%>


        <%--<c:forEach var="loop" items="${synsets}">--%>

        <%--<input type="hidden" name="synset" value="${loop.synset}">--%>
        <%--<input type="hidden" name="word" value="${word}">--%>
        <%--<input type="hidden" name="topic" value="${topic}">--%>
        <%--<input type="hidden" name="domain" value="${domain}">--%>

        <%--&lt;%&ndash;<p>meaning : ${loop.meaning}</p>&ndash;%&gt;--%>
        <%--<input type="hidden" name="meaning" value="${loop.meaning}">--%>

        <%--<p>pos :--%>
        <%--<c:if test="${loop.pos == 'r'}">--%>
        <%--Adverbio--%>
        <%--</c:if>--%>
        <%--<c:if test="${loop.pos == 'v'}">--%>
        <%--Verbo--%>
        <%--</c:if>--%>
        <%--<c:if test="${loop.pos == 'n'}">--%>
        <%--Nombre--%>
        <%--</c:if>--%>
        <%--<c:if test="${loop.pos == 'a'}">--%>
        <%--Adjetivo--%>
        <%--</c:if>--%>
        <%--<input type="hidden" name="pos" value="${loop.pos}">--%>
        <%--</p>--%>

        <%--<p>english words:--%>
            <%--<c:forEach var="enWords" items="${loop.englishWords}">--%>
            <%--${enWords},--%>
            <%--</c:forEach>--%>
        <%--</p>--%>

        <%--<p>spanish words:--%>
            <%--<c:forEach var="esWords" items="${loop.spanishWords}">--%>
            <%--${esWords},--%>
            <%--</c:forEach>--%>
        <%--</p>--%>

        <%--<p>italian words:--%>
            <%--<c:forEach var="itWords" items="${loop.italianWords}">--%>
            <%--${itWords},--%>
            <%--</c:forEach>--%>
        <%--</p>--%>
        <%--<input type="text" name="positive">--%>
        <%--<br>--%>
        <%--<input type="text" name="negative">--%>
        <%--<br>--%>

        <%-----------------------------------------------------------------%>
        <%--<input type="submit" value="Enviar"/>--%>

        <%--<div id="ajax_loader"><img id="loader_gif" src="loader.gif" style=" display:none;"/></div>--%>
        <%--</form>--%>

        <%--</c:forEach>--%>

    </div>
    <%--<div class="feed"><a href="#"><img alt="" src="../../images/twitter.jpg" height="80" width="75"/></a> <a--%>
    <%--href="#"><img alt="" src="images/rss.jpg" height="80" width="67"/></a></div>--%>
</div>
<!--BottomRow END-->
<!--Footer Begin-->
<div id="footer">
    <div class="foot"><span>Developed</span> by <a href="http://www.paradigmatecnologico.com">Paradigma Tecnol&oacute;gico </a>
    </div>
</div>
<!--Footer END-->
</body>
</html>
