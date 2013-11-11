<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Disambiguator</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <link rel="shortcut icon" href="images/favicon.gif"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="css/buttons.css"/>

</head>
<%--<script src="../../js/jquery-2.0.3.min.js" type="text/javascript"></script>--%>

<%--<script type="text/javascript">--%>

    <%--// esperamos que el DOM cargue--%>
    <%--$(document).ready(function () {--%>
        <%--// definimos las opciones del plugin AJAX FORM--%>
        <%--var opciones = {--%>
            <%--beforeSubmit: mostrarLoader, //funcion que se ejecuta antes de enviar el form--%>
            <%--success: mostrarRespuesta //funcion que se ejecuta una vez enviado el formulario--%>
        <%--};--%>
        <%--//asignamos el plugin ajaxForm al formulario myForm y le pasamos las opciones--%>
        <%--$('#myForm').ajaxForm(opciones);--%>

        <%--//lugar donde defino las funciones que utilizo dentro de "opciones"--%>
        <%--function mostrarLoader() {--%>
<%--//            $(#loader_gif).fadeIn("slow"); //muestro el loader de ajax--%>
        <%--};--%>
        <%--function mostrarRespuesta(responseText) {--%>
            <%--alert("Mensaje enviado: " + responseText);  //responseText es lo que devuelve la página contacto.php. Si en contacto.php hacemos echo "Hola" , la variable responseText = "Hola" . Aca hago un alert con el valor de response text--%>
<%--//            $("#loader_gif").fadeOut("slow"); // Hago desaparecer el loader de ajax--%>
<%--//            $("#ajax_loader").append("<br>Mensaje: " + responseText); // Aca utilizo la función append de JQuery para añadir el responseText  dentro del div "ajax_loader"--%>
        <%--};--%>

    <%--});--%>

<%--</script>--%>
<body>
<!--Header Begin-->
<div id="header">
    <div class="center">
        <div id="logo"><a href="#">Disambiguator</a></div>
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
<form id="form" action="main.html" method="get">
    <div id="midrow">
        <div id="container">
            <div class="box">
                <h1>Choose domain</h1>
                <select name="domain">
                    <option value="hotel">hotel</option>
                    <option value="telco">telco</option>
                </select>
            </div>
            <div class="box">
                <h1>Type the topic</h1>
                <input type="text" name="topic">
            </div>
            <div class="box">
                <h1>Type the word</h1>
                <input type="text" name="word">
            </div>
            <div class="box last">
                <input type="submit" class="button brackets" value="Get the meanings"/>
            </div>
        </div>

    </div>
</form>

<!--MiddleRow END-->
<!--BottomRow Begin-->
<div id="bottomrow">
    <div class="textbox">


        <c:forEach var="loop" items="${synsets}">

            <form id="myForm" action="/saveResults.html" method="get">
                <input type="hidden" name="synset" value="${loop.synset}">
                <input type="hidden" name="word" value="${word}">
                <input type="hidden" name="topic" value="${topic}">
                <input type="hidden" name="domain" value="${domain}">
                <input type="hidden" name="pos" value="${loop.pos}">
                <input type="hidden" name="meaning" value="${loop.meaning}">

                <div class="wrapper_list ${loop.tagged?'tagged':''}">
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
                            <h1> meaning </h1>
                            <p class="meaning"> ${loop.meaning}</p>
                        </li>
                        <li class="contenedor_def">
                            <ul>
                                <li class="definicion">
                                    <h1>words</h1>

                                    <p class="words">
                                        <c:forEach var="enWords" items="${loop.englishWords}">
                                            ${enWords}
                                        </c:forEach>
                                    </p>
                                </li>
                                <li class="definicion">
                                    <h1>spanish words</h1>

                                    <p class="words">
                                        <c:forEach var="esWords" items="${loop.spanishWords}">
                                            ${esWords}
                                        </c:forEach>
                                    </p>
                                </li>

                            </ul>
                        </li>
                        <input maxlength="6" class="rangevalue positivo" id="rangevalueP${loop.synset}"
                               value="${loop.sentiment.positive}" name="positive"
                               onchange="if (Number(value.substring(0,value)) > 100) value = '100'; rangeinputP${loop.synset}.value=value;"/>

                        <p id="titulo_rango" class="positivo"> Positivo </p>
                        <li id="slider">
                            <input class="bar" type="range" id="rangeinputP${loop.synset}" min="0.0"
                                   max="100.0" step="0.1"
                                   value="${loop.sentiment.positive}"
                                   onchange="rangevalueP${loop.synset}.value=value; rangevalueP${loop.synset}.value=value;"/>
                            <span class="highlight"></span>
                        </li>

                        <input maxlength="6" class="negativo rangevalue" id="rangevalueN${loop.synset}"
                               value="${loop.sentiment.negative}" name="negative"
                               onchange="if (Number(value.substring(0,value)) > 100) value = '100'; rangeinputN${loop.synset}.value=value;"/>

                        <p id="titulo_rango" class="negativo"> Negativo </p>
                        <li id="slider">
                            <input class="bar negativo" type="range" id="rangeinputN${loop.synset}" min="0.0"
                                   max="100.0"
                                   step="0.1"
                                   value="${loop.sentiment.negative}"
                                   onchange="rangevalueN${loop.synset}.value=value"/>
                            <span class="highlight"></span>
                        </li>
                    </ul>

                </div>
                <div class="botonenviar">
                <input  type="submit" class="button green glossy xl " value="Enviar"/>
                </div>
            </form>
        </c:forEach>

    </div>
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
