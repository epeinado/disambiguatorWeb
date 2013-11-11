<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Disambiguator</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <link rel="shortcut icon" href="images/favicon.gif"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/buttons.css"/>
</head>
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
<!--BottomRow END-->
<!--Footer Begin-->
<div id="footer">
    <div class="foot"><span>Developed</span> by <a href="http://www.paradigmatecnologico.com">Paradigma Tecnol&oacute;gico </a>
    </div>
</div>
<!--Footer END-->
</body>
</html>
