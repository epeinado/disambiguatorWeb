<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Disambiguator</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <link rel="shortcut icon" href="images/favicon.gif"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.10.3.custom.css">


</head>

<style type="text/css" media="screen">
    /*@import "/media/css/site_jui.ccss";*/
    /*@import "/release-datatables/media/css/demo_table_jui.css";*/
    /*@import "/media/css/jui_themes/pepper-grinder/jquery-ui-1.7.2.custom.css";*/

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

        $(document).ready(function() {
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

            $.getJSON(oSettings.sAjaxSource, null, function(json) {
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
                <li><a class="active" href="index.html"><span>Main</span></a></li>
                <li><a href="show.html"><span>Show</span></a></li>
            </ul>
        </div>
        <!--Menu END-->
    </div>
</div>


<!--MiddleRow END-->
<!--BottomRow Begin-->
<div id="bottomrow">
    <div class="textbox">

        <table id="table" cellpadding="5" cellspacing="5" border="0" class="sorting_1">
            <thead>
            <tr>
                <th> ID</th>
                <th> synset</th>
                <th> pos</th>
                <th> domain</th>
                <th> topic</th>
                <th> word</th>
                <th> positive</th>
                <th> negative</th>
            </tr>
            </thead>
            <tbody id="tbody">

                <c:forEach var="loop" items="${scores}">
                <tr>
                    <td>${loop.id}</td>
                    <td>${loop.synset}</td>
                    <td>${loop.pos}</td>
                    <td>${loop.domain}</td>
                    <td>${loop.topic}</td>
                    <td>${loop.word}</td>
                    <td>${loop.positive}</td>
                    <td>${loop.negative}</td>
                </tr>
                </c:forEach>
        </table>


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
