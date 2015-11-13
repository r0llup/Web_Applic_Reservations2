<%-- 
    Document   : index
    Created on : 15 oct. 2012, 16:03:59
    Author     : Sh1fT
--%>

<%@page import="org.apache.catalina.ant.SessionsTask"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
    Integer idVoyageur = (Integer) session.getAttribute("idVoyageur");
    Boolean logged = (Boolean) session.getAttribute("logged");
    String name = (String) session.getAttribute("name");
    if ((logged == null) || (!logged)) {
        idVoyageur = (Integer) request.getAttribute("idVoyageur");
        logged = (Boolean) request.getAttribute("logged");
        name = request.getParameter("name");
        session.setAttribute("isActive", true);
        session.setAttribute("idVoyageur", idVoyageur);
        session.setAttribute("logged", logged);
        session.setAttribute("name", name);
    }
%>
<fmt:setBundle basename="resource_bundle" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web_Applic_Reservations2 :: <fmt:message key="index" /></title>
    </head>
    <body>
        <h1>Web_Applic_Reservations2 :: <fmt:message key="index" /></h1>
        <jsp:include page="menu.jsp" />
    </body>
</html>