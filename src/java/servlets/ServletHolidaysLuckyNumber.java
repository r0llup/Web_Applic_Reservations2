/**
 * ServletHolidaysLuckyNumber
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

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Manage a {@link ServletHolidaysLuckyNumber}
 * @author Sh1fT
 */
public class ServletHolidaysLuckyNumber extends HttpServlet {
    private String command;
    private String luckyNumber;

    /**
     * Create a new {@link ServletHolidaysLogin} instance
     */
    public ServletHolidaysLuckyNumber() {
        this.setCommand(null);
        this.setLuckyNumber(null);
    }

    public String getCommand() {
        return command;
    }

    public void setCommand(String command) {
        this.command = command;
    }

    public String getLuckyNumber() {
        return luckyNumber;
    }

    public void setLuckyNumber(String luckyNumber) {
        this.luckyNumber = luckyNumber;
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
            this.setLuckyNumber(this.getInitParameter("luckyNumber"));
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
        response.setContentType("text/text");
        PrintWriter out = response.getWriter();
        this.setCommand(request.getParameter("command"));
        this.setLuckyNumber(request.getParameter("luckyNumber"));
        if (this.getCommand() != null) {
            switch (this.getCommand()) {
                case "retrieve":
                    if (this.getLuckyNumber() != null)
                        out.println(new Random().nextInt(Integer.parseInt(
                                this.getLuckyNumber())));
                    else
                        out.println(new Random().nextInt(4000));
                    break;
                default:
                    break;
            }
        } else
            out.println(new Random().nextInt(4000));
        out.close();
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