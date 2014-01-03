<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Disambiguator</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <link rel="shortcut icon" href="images/favicon.gif"/>
    <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.10.3.custom.css">
    <link rel="stylesheet" type="text/css" href="css/style.css"/>


</head>

<style type="text/css" media="screen">

        /*
             * Override styles needed due to the mix of three different CSS sources! For proper examples
             * please see the themes example in the 'Examples' section of this site
             */
    .dataTables_info {
        padding-top: 0;
    }

    .dataTables_paginate {
        padding-top: 0;
    }

    .css_right {
        float: right;
    }

    #example_wrapper .fg-toolbar {
        font-size: 0.8em
    }

    #theme_links span {
        float: left;
        padding: 2px 10px;
    }
</style>


<script type="text/JavaScript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/JavaScript" src="js/jquery.dataTables.js"></script>
<script type="text/JavaScript" src="js/jquery.dataTables.min.js"></script>
<script type="text/JavaScript" src="js/jquery-ui-1.8.17.custom.min.js"></script>

<script type="text/JavaScript">

    $(document).ready(function () {
        $('#table').dataTable({
//                "bProcessing": true,
//                "bServerSide": true,
            "bJQueryUI": true,
//                "sAjaxSource": "prueba.jsp"
//                "sAjaxSource": 'prueba.txt',
            "bPaginate": true,
            "bLengthChange": true,
            "bFilter": true,
            "bSort": true,
            "bInfo": false,
            "bAutoWidth": false });
    });

    $.fn.dataTableExt.oApi.fnReloadAjax = function (oSettings, sNewSource, fnCallback) {
        if (typeof sNewSource != 'undefined') {
            oSettings.sAjaxSource = sNewSource;
        }
        this.oApi._fnProcessingDisplay(oSettings, true);
        var that = this;

        $.getJSON(oSettings.sAjaxSource, null, function (json) {
            /* Clear the old information from the table */
            that.oApi._fnClearTable(oSettings);

            /* Got the data - add it to the table */
            for (var i = 0; i < json.aaData.length; i++) {
                that.oApi._fnAddData(oSettings, json.aaData[i]);
            }
            oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
            that.fnDraw(that);
            that.oApi._fnProcessingDisplay(oSettings, false);

            /* Callback user function - for event handlers etc */
            if (typeof fnCallback == 'function') {
                fnCallback(oSettings);
            }
        });
    };

    function duplicar(domain) {
        if ($("input:checkbox:checked").length == 0) {
            alert("Debes seleccionar al menos un elemento");
        } else {
            // Pedimos confirmación
            if (confirm("¿Seguro que deseas duplicar los " + $("input:checkbox:checked").length + " elementos para el dominio " + domain + "?")) {
                // Respuesta afirmativa...
                var list = new Array();
                var i = 0;
                $("input:checkbox:checked").each(function () {
                    //cada elemento seleccionado
                    list[i] = ($(this).val());
                    i++;
                });
//            var list = $("#checkboxes").children("input:checked");
                window.location = "duplicate.html?domain=" + domain + "&list=" + list;

            }
        }
    }

    function borrar() {
        if ($("input:checkbox:checked").length == 0) {
            alert("Debes seleccionar al menos un elemento");
        } else {
            if (confirm("¿Seguro que deseas eliminar los " + $("input:checkbox:checked").length + " elementos?")) {
                // Respuesta afirmativa...
                var list = new Array();
                var i = 0;
                $("input:checkbox:checked").each(function () {
                    //cada elemento seleccionado
                    list[i] = ($(this).val());
                    i++;
                });
                window.location = "delete.html?list=" + list;
            }
        }
    }

    function editar(id, synset, pos, domain, topic, word, positive, negative) {


        $('.blockOverlay').fadeIn('fast', function () {
            $('#modal').animate({'top': '0'}, 500);
        });

        document.getElementById("modalid").value = (id);
        document.getElementById("modalsynset").value = (synset);
        document.getElementById("modalpos").value = (pos);
        document.getElementById("modaldomain").value = (domain);
        document.getElementById("modaltopic").value = (topic);
        document.getElementById("modalword").value = (word);
        document.getElementById("rangeinputP").value = (positive)*100;
        document.getElementById("rangevalueP").value = (positive)*100;
        document.getElementById("rangeinputN").value = (negative)*100;
        document.getElementById("rangevalueN").value = (negative)*100;

    }

    function cerrarModal() {
        $('#modal').animate({'top': '-2000px'}, 500, function () {
            $('.blockOverlay').fadeOut('fast');
        });
    }

</script>


<%--</script>--%>
<body>
<!--Header Begin-->
<div id="header">
    <div class="center">
        <div id="logo"><a href="#">Disambiguator</a></div>
        <!--Menu Begin-->
        <div id="menu">
            <ul>
                <li><a href="index.html"><span>Main</span></a></li>
                <li><a class="active" href="show.html"><span>Show</span></a></li>
            </ul>
        </div>
        <!--Menu END-->
    </div>
</div>


<!--MiddleRow END-->
<!--BottomRow Begin-->
<div id="bottomrow">
    <div class="textbox">

        <table id="table" cellpadding="4" cellspacing="0" border="0" class="sorting_1">
            <thead>
            <tr>
                <th> Check</th>
                <th> ID</th>
                <th> synset</th>
                <th> pos</th>
                <th> domain</th>
                <th> topic</th>
                <th> word</th>
                <th> positive</th>
                <th> negative</th>
                <th> editar</th>
            </tr>
            </thead>
            <tbody id="tbody">

            <c:forEach var="loop" items="${scores}">
            <tr id="elem_${loop.id}">
                <td id="check_${loop.id}"><input type="checkbox" id="checkbox_${loop.id}" value="${loop.id}"></td>
                <td id="id_${loop.id}">${loop.id}</td>
                <td id="synset_${loop.synset}">${loop.synset}</td>
                <td id="pos_${loop.id}">${loop.pos}</td>
                <td id="domain_${loop.id}">${loop.domain}</td>
                <td id="topic_${loop.id}">${loop.topic}</td>
                <td id="word_${loop.id}">${loop.word}</td>
                <td id="positive_${loop.id}"><fmt:formatNumber value="${loop.positive*100}" maxFractionDigits="1"/></td>
                <td id="negative_${loop.id}"><fmt:formatNumber value="${loop.negative*100}" maxFractionDigits="1"/></td>
                <td id="editar_${loop.id}"><img src="images/icons/Edit.ico" alt="Editar" title="Editar" height="20"
                                                onclick="editar('${loop.id}','${loop.synset}', '${loop.pos}', '${loop.domain}', '${loop.topic}', '${loop.word}', '${loop.positive}', '${loop.negative}');">
                </td>
            </tr>
            </c:forEach>
        </table>


    </div>

    <div style="margin-bottom: 20px">
        <div><img src="images/icons/Copy.ico" alt="Duplicar" title="duplicar" height="20"> Duplicar para el dominio
            <select name="domain" id="domain">
                <option value="hotel">hotel</option>
                <option value="electronics" selected>electronics</option>
            </select>
            <img src="images/icons/Next.ico" alt="duplicar" title="duplicar" height="20"
                 onclick="duplicar($('#domain').val());"
                 style="cursor: pointer; cursor: hand;">
        </div>
        </br>
        <div><img src="images/icons/Delete.ico"
                  alt="Duplicar" title="duplicar"
                  height="20"> Eliminar los elementos
            seleccionados
            <img src="images/icons/Next.ico" alt="duplicar" title="duplicar" height="20" onclick="borrar();"
                 style="cursor: pointer; cursor: hand;">
        </div>
    </div>

</div>

<div class="blockOverlay">
</div>

<div id="modal" class="modal">
    <form id="editForm" action="edit.html" method="post">
        <table cellpadding="4" cellspacing="0" border="0" class="sorting_1" style="text-align: center;">
            <thead>
            <tr>
                <th> ID</th>
                <th> Synset</th>
                <th> Pos</th>
            </tr>

            </thead>
            <tbody>
            <tr>
                <td><input type="text" name="modalid" id="modalid" value="" readonly="" style="background-color: gainsboro"></td>
                <td><input type="text" name="modalsynset" id="modalsynset" value="" readonly="" style="background-color: gainsboro"></td>
                <td><input type="text" name="modalpos" id="modalpos" value="" readonly="" style="background-color: gainsboro"></td>
            </tr>

            </tbody>
        </table>
        <table cellpadding="4" cellspacing="0" border="0" class="sorting_1" style="text-align: center;">
            <thead>
            <tr>
                <th> Domain</th>
                <th> Topic</th>
                <th> Word</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><input type="text" name="modaldomain" id="modaldomain" value=""></td>
                <td><input type="text" name="modaltopic" id="modaltopic" value=""></td>
                <td><input type="text" name="modalword" id="modalword" value=""></td>
            </tr>
            </tbody>
        </table>

        <div class="wrapper_list ${loop.tagged?'tagged':''}" style="width: 750px; height: 70px;margin-top: 20px;">
            <ul>
                <input maxlength="6" class="rangevalue positivo" id="rangevalueP"
                       value="" name="positive"
                       onchange="if (Number(value.substring(0,value)) > 100) value = '100'; rangeinputP.value=value;"/>

                <p id="titulo_rango" class="positivo"> Positivo </p>
                <li id="slider">
                    <input class="bar" type="range" id="rangeinputP" min="0.0"
                           max="100.0" step="0.1"
                           value=""
                           onchange="rangevalueP.value=value; rangevalueP.value=value;"/>
                    <span class="highlight"></span>
                </li>

                <input maxlength="6" class="negativo rangevalue" id="rangevalueN"
                       value="" name="negative"
                       onchange="if (Number(value.substring(0,value)) > 100) value = '100'; rangeinputN.value=value;"/>

                <p id="titulo_rango" class="negativo"> Negativo </p>
                <li id="slider">
                    <input class="bar negativo" type="range" id="rangeinputN" min="0.0"
                           max="100.0"
                           step="0.1"
                           value=""
                           onchange="rangevalueN.value=value"/>
                    <span class="highlight"></span>
                </li>
            </ul>

        </div>
        <div class="botonenviar">
            <input type="submit" class="button green glossy xl " value="Enviar"/>
            <input type="button" class="button green glossy xl " value="Cancelar" onclick="cerrarModal();"/>
        </div>
    </form>
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
