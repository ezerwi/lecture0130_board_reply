package com.wjh.board;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Test {
    public static void main(String[] args) {
        DB.connDB();
        ResultSet rs = null;
        int last = 0;
        try {
            rs = DB.conn.createStatement().executeQuery("select max(uid) from board");
            rs.first();
            last = (rs.getInt(1) > 0) ? rs.getInt(1) : 0;
            System.out.println(last);
        } catch (SQLException e) {
            System.out.println("ERR_last_uid : " + e.getMessage());
        } finally {
            try {
                DB.conn.close();
            } catch (SQLException e) {
                System.out.println("ERR_last_uid_finally : " + e.getMessage());
            }
        }
    }
}
