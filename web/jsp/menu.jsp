<%-- 
    Document   : menu.jsp
    Created on : 22 oct. 2012, 14:43:36
    Author     : Sh1fT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
    Boolean logged = (Boolean) session.getAttribute("logged");
    String name = (String) session.getAttribute("name");
%>
<fmt:setBundle basename="resource_bundle" />
<p>
<% if ((logged != null) && (logged)) { %>
    <fmt:message key="menu.connection.state" /> <i><%= name %></i>
<% } else { %>
    <fmt:message key="menu.connection.state" /> <i>Anonymous</i>
<% } %>
</p>
<ul>
<% if ((logged != null) && (logged)) { %>
    <li><a href="/Web_Applic_Reservations2/jsp/login.jsp?logout"><fmt:message key="menu.connection.disconnect" /></a></li>
<% } else { %>
    <li><a href="/Web_Applic_Reservations2/jsp/login.jsp"><fmt:message key="menu.connection.connect" /></a></li>
<% } %>
    <li><a href="/Web_Applic_Reservations2/jsp/register.jsp"><fmt:message key="menu.register" /></a></li>
<% if ((logged != null) && (logged)) { %>
    <li><a href="/Web_Applic_Reservations2/jsp/catalog.jsp"><fmt:message key="menu.catalog" /></a></li>
<% } else { %>
    <li><a href="/Web_Applic_Reservations2/jsp/login.jsp"><fmt:message key="menu.catalog" /></a></li>
<% } %>
<% if ((logged != null) && (logged)) { %>
    <li><a href="/Web_Applic_Reservations2/jsp/basket.jsp"><fmt:message key="menu.basket" /></a></li>
<% } else { %>
    <li><a href="/Web_Applic_Reservations2/jsp/login.jsp"><fmt:message key="menu.basket" /></a></li>
<% } %>
</ul>