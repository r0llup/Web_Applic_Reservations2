/**
 * ListenerHolidaysSession
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

package listeners;

import beans.BeanDBAccess;
import beans.BeanDBAccessMySQL;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Manage a {@link ListenerHolidaysSession}
 * @author Sh1fT
 */
public class ListenerHolidaysSession implements  HttpSessionListener {
    private BeanDBAccess beanDbAccess;

    /**
     * Create a new {@link ListenerHolidaysSession} instance
     */
    public ListenerHolidaysSession() {
        this.setBeanDbAccess(null);
    }

    public BeanDBAccess getBeanDbAccess() {
        return beanDbAccess;
    }

    public void setBeanDbAccess(BeanDBAccess beanDbAccess) {
        this.beanDbAccess = beanDbAccess;
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        try {
            HttpSession session = se.getSession();
            Integer idVoyageur = (Integer) session.getAttribute("idVoyageur");
            if (idVoyageur != null) {
                // delete to basket
                this.setBeanDbAccess(new BeanDBAccessMySQL("localhost", 3306,
                    "bd_hotels", "root", "", "true", false));
                String query = "DELETE FROM caddy WHERE idVoyageur = ?;";
                PreparedStatement ps = this.getBeanDbAccess().getDBConnection().
                        prepareStatement(query);
                ps.setInt(1, idVoyageur);
                this.getBeanDbAccess().executeUpdate(ps);
                this.getBeanDbAccess().getDBConnection().commit();
                this.getBeanDbAccess().stop();
            }
        } catch (SQLException ex) {
            System.out.println(ex.getLocalizedMessage());
            this.getBeanDbAccess().stop();
            System.exit(1);
        }
    }
}