<%-- 
    Document   : login
    Created on : 20-oct.-2012, 15:01:35
    Author     : Sh1fT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
    String logout = request.getParameter("logout");
    if (logout != null) {
        session.setAttribute("logged", false);
        session.setAttribute("name", null);
        response.sendRedirect("/Web_Applic_Reservations2/jsp/index.jsp");
    }
%>
<fmt:setBundle basename="resource_bundle" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web_Applic_Reservations2 :: <fmt:message key="login" /></title>
    </head>
    <body>
        <h1>Web_Applic_Reservations2 :: <fmt:message key="login" /></h1>
        <jsp:include page="menu.jsp" />
        <p align="center">
            <applet code="applets.AppletHolidaysLogin" name="AppletHolidaysLogin" codebase="." archive="../applets/Web_Applic_Reservations.jar" alt="<fmt:message key="applet.incompatible.browser" />" width="450" height="480">                
            </applet>
        </p>
        <p align="center">
            <applet code="applets.AppletHolidaysPassword" name="AppletHolidaysPassword" codebase="." archive="../applets/Web_Applic_Reservations.jar" alt="<fmt:message key="applet.incompatible.browser" />" width="450" height="235">
            </applet>
	</p>
    </body>
</html>