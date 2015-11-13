/**
 * ServletHolidaysLogin
 *
 * Copyright (C) 2012 Sh1fT
 *
 * This file is part of Web_Applic_Reservations2.
 *
 * Web_Applic_Reservations2 is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published
 * by the Free Software Foundation; either version 3 of the License,
 * or (at your option) any later version.
 *
 * Web_Applic_Reservations2 is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Web_Applic_Reservations2; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
 * USA
 */

package servlets;

import beans.BeanDBAccess;
import beans.BeanDBAccessMySQL;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Manage a {@link ServletHolidaysLogin}
 * @author Sh1fT
 */
public class ServletHolidaysLogin extends HttpServlet {
    private String command;
    private String name;
    private String password;
    private BeanDBAccess beanDBAccess;

    /**
     * Create a new {@link ServletHolidaysLogin} instance
     */
    public ServletHolidaysLogin() {
        this.setCommand(null);
        this.setName(null);
        this.setPassword(null);
        this.setBeanDBAccess(null);
    }

    public String getCommand() {
        return command;
    }

    public void setCommand(String command) {
        this.command = command;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public BeanDBAccess getBeanDBAccess() {
        return beanDBAccess;
    }

    public void setBeanDBAccess(BeanDBAccess beanDBAccess) {
        this.beanDBAccess = beanDBAccess;
    }

    /**
     * Initialize the servlet
     * @param sc 
     */
    @Override
    public void init(ServletConfig sc) {
        try {
            super.init(sc);
            this.setCommand(this.getInitParameter("command"));
            this.setName(this.getInitParameter("name"));
            this.setPassword(this.getInitParameter("password"));
            this.setBeanDBAccess(null);
        } catch (ServletException ex) {
            System.out.println(ex.getLocalizedMessage());
            System.exit(1);
        }
    }

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.setCommand(request.getParameter("command"));
        this.setName(request.getParameter("name"));
        this.setPassword(request.getParameter("password"));
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletHolidaysLogin</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletHolidaysLogin at " +
                    request.getContextPath() + "</h1>");
            this.setBeanDBAccess(new BeanDBAccessMySQL("localhost", 3306,
                    "bd_hotels", "root", "", "true", false));
            String query;
            PreparedStatement ps;
            if (this.getCommand() != null) {
                switch (this.getCommand()) {
                    case "login":
                        query = "SELECT * FROM voyageurs WHERE nom LIKE ? AND password LIKE ?;";
                        ps = this.getBeanDBAccess().getDBConnection().prepareStatement(query);
                        ps.setString(1, this.getName());
                        ps.setString(2, this.getPassword());
                        ResultSet rs = this.getBeanDBAccess().executeQuery(ps);
                        if (rs.next()) {
                            out.println("<p>Welcome <i>" + this.getName() +
                                    "</i>, you've been successfully logged :)</p>");
                            request.setAttribute("idVoyageur", rs.getInt(1));
                            request.setAttribute("logged", true);
                            this.getServletContext().getRequestDispatcher("/jsp/index.jsp")
                                    .forward(request, response);
                        } else
                            out.println("<p>Welcome <i>" + this.getName() +
                                    "</i>, you've <b>not</b> been successfully logged :(</p>");
                        rs.close();
                        ps.close();
                        break;
                    case "register":
                        query = "INSERT INTO voyageurs VALUES (0, ?, '', ?, '', '');";
                        ps = this.getBeanDBAccess().getDBConnection().prepareStatement(query);
                        ps.setString(1, this.getName());
                        ps.setString(2, this.getPassword());
                        Integer res = this.getBeanDBAccess().executeUpdate(ps);
                        if (res == 1) {
                            out.println("<p>Welcome <i>" + this.getName() +
                                    "</i>, you've been successfully registered :)</p>");
                            this.getServletContext().getRequestDispatcher("/jsp/index.jsp")
                                    .forward(request, response);
                        } else
                            out.println("<p>Welcome <i>" + this.getName() +
                                    "</i>, you've <b>not</b> been successfully registered :(</p>");
                        ps.close();
                        this.getBeanDBAccess().getDBConnection().commit();
                        break;
                    default:
                        break;
                }
            }
            this.getBeanDBAccess().stop();
            out.println("</body>");
            out.println("</html>");
        } catch (SQLException ex) {
            System.out.println(ex.getLocalizedMessage());
            this.getBeanDBAccess().stop();
            out.close();
            System.exit(1);
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}