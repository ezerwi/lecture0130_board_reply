package com.wjh.board;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BoardQuery {

	public BoardQuery(){
		
	}
	
	public static ResultSet show_all(){
		DB.connDB();
		ResultSet rs = null;
		try {
			rs = DB.conn.createStatement().executeQuery("select * from board order by uid desc");
			return rs;
		} catch (SQLException e) {
			System.out.println("ERR_show_all : "+e.getMessage());
			return null;
		}
	}	//show_all()
	
	public static ResultSet show_one(String no){
		DB.connDB();
		ResultSet rs = null;
		try {
			rs = DB.conn.createStatement().executeQuery("select * from board where idx = "+no);
			return rs;
		} catch (SQLException e) {
			System.out.println("ERR_show_one : "+e.getMessage());
			return null;
		}
	}	//show_one
	
	public static boolean insert_one(String title, String name, String contents){
		DB.connDB();
		boolean status = false;
		PreparedStatement pstmt = null;
		int uid = make_uid("0");
		try {
			pstmt = DB.conn.prepareStatement("INSERT INTO board (title, name, contents, mkdate, uid) VALUES (?, ?, ?, now(), ?)");
			pstmt.setString(1,  title);
			pstmt.setString(2,  name);
			pstmt.setString(3,  contents);
			pstmt.setInt(4, uid);
			int n = pstmt.executeUpdate();
			status = (n>0)? true : false;
		} catch (SQLException e) {
			System.out.println("ERR_insert_one : "+e.getMessage());
		} finally{
			try {
				pstmt.close();
				DB.conn.close();
			} catch (SQLException e) {
				System.out.println("ERR_insert_one_finally : "+e.getMessage());
			}
		}
		return status;
	}	// insert_one()
	
	public static boolean delete_one(String no){
		boolean status = false;
		DB.connDB();
		try {
			int n = DB.conn.createStatement().executeUpdate("delete from board where idx = "+no);
			status =(n>0)? true : false ;
		} catch (SQLException e) {
			System.out.println("ERR_delete_one : "+e.getMessage());
		} finally{
			try {
				DB.conn.close();
			} catch (SQLException e) {
				System.out.println("ERR_delete_one_finally : "+e.getMessage());
			}
		}
		return status;
	}	// delete_one()
	
	public static boolean reply(String no, String title, String name, String contents, String uid, String depth){
		DB.connDB();
		boolean status = false;
		PreparedStatement pstmt = null;
		int new_uid = make_uid(uid, depth);
		try {
			pstmt = DB.conn.prepareStatement("INSERT INTO board (title, name, contents, mkdate, depth, uid) values (?, ?, ?, now(), ?, ?)");
			pstmt.setString(1, title);
			pstmt.setString(2, name);
			pstmt.setString(3, contents);
			pstmt.setString(4, depth);
			pstmt.setInt(5, new_uid );
			int n = pstmt.executeUpdate();
			status =(n>0)? true : false;
		} catch (SQLException e) {
			System.out.println("ERR_reply : "+e.getMessage());
		} finally {
			try {
				pstmt.close();
				DB.conn.close();
			} catch (SQLException e) {
				System.out.println("ERR_reply_finally : "+e.getMessage());
			}
		}return status;
	}	// reply()

	// original contents의 uid . depth를 받고 uid를 하나씩 거슬러올라가면서
	// 원글과 같은 depth를 가진 글의 uid를 받음
	// 그 uid에 +1을 하면 답글의 uid가 됨
	// 이 글보다 윗글들도 모두 uid++ >> set_uid()
	static int make_uid(String origin_uid, String origin_depth){
		ResultSet rs = uid_previous(origin_uid);
		int uid= Integer.parseInt(origin_uid);

		try {
			rs.beforeFirst();
			while(rs.next()){
				int now_depth = Integer.parseInt(origin_depth);
				int before_depth = Integer.parseInt(rs.getString("depth"));
				int before_uid = Integer.parseInt(rs.getString("uid"));

				if (now_depth>before_depth){
					uid = before_uid;
					break;
				} 	
			}
			renew_uid(uid);
			return uid+1;
		} catch (SQLException e) {
			System.out.println("ERR_make_uid : "+e.getMessage());
			return 0;
		} finally {
			try {
				rs.close();
			} catch (SQLException e) {
				System.out.println("ERR_make_uid_finally : "+e.getMessage());
			}
		}
	}	// make_uid()

	// make new uid of new article
	static int make_uid(String origin_depth){
		ResultSet rs = null;
		int uid=0;

		try {
			rs = DB.conn.createStatement().executeQuery("select * from board order by uid desc limit 1");
			rs.next();
			uid = rs.getInt("uid")+1;

			renew_uid(uid);
			return uid;
		} catch (SQLException e) {
			System.out.println("ERR_make_uid : "+e.getMessage());
			return 0;
		} finally {
			try {
				rs.close();
			} catch (SQLException e) {
				System.out.println("ERR_make_uid_finally : "+e.getMessage());
			}
		}
	}

	// 새로 만들어진 글 보다 위에 올 글들은 모두 uid++
	static void renew_uid(int new_uid){
		try {
			int n = DB.conn.createStatement().executeUpdate("update board set uid=uid+1 where uid > "+new_uid);
		} catch (SQLException e) {
			System.out.println("ERR_renew_uid : "+e.getMessage());
		}
	}	// set_uid()

	// 새 article에 uid를 부여하기 위해
	// 원글의 uid와 depth를 받아오고
	// 원글 uid 이전의 ResultSet만 호출
	static ResultSet uid_previous(String origin_uid){
		DB.connDB();
		ResultSet rs = null;
		try {
			rs = DB.conn.createStatement().executeQuery("select * from board where uid < "+origin_uid+" order by uid desc");
			return rs;
		} catch (SQLException e) {
			System.out.println("ERR_uid_previous : "+e.getMessage());
			return null;
		}
	}	// uid_previous()

	public static boolean hit_up(String no){
		boolean status = false;
		try {
			int n = DB.conn.createStatement().executeUpdate("update board set hit = hit +1 where idx = "+no);
			status =(n>0)? true : false ;
		} catch (SQLException e) {
			System.out.println("ERR_hit_up : "+e.getMessage());
		} finally {
			try {
				DB.conn.close();
			} catch (SQLException e) {
				System.out.println("ERR_hit_up_finally : "+e.getMessage());
			}
		}
		return status;
	}	// hit_up()

	public static int total_articles(){
		DB.connDB();
		int tot = 0;
		ResultSet rs = null;
		try {
			rs = DB.conn.createStatement().executeQuery("select count(*) from board");
			rs.first();
			tot =(rs.getInt(1)>0)? rs.getInt(1) : 0 ;
		} catch (SQLException e) {
			System.out.println("ERR_total_article : "+e.getMessage());
		}	finally {
			try {
				DB.conn.close();
			} catch (SQLException e) {
				System.out.println("ERR_total_article_finally : "+e.getMessage());
			}
		} return tot;
	}	// total_articles()

	public static ResultSet show_pages(int page_num){
		DB.connDB();
		ResultSet rs = null;
		int last_num = last_uid()-20*(page_num-1);
		try {
			rs = DB.conn.createStatement().executeQuery("select * from board where uid < "+(last_num+1)+" && uid > "+(last_num-20)+" order by uid desc");
			return rs;
		} catch (SQLException e) {
			System.out.println("ERR_show_pages : "+e.getMessage());
			return null;
		}
	}	//	show_pages()

	public static int last_uid(){
		DB.connDB();
		ResultSet rs = null;
		int last = 0;
		try {
			rs = DB.conn.createStatement().executeQuery("select max(uid) from board");
			rs.first();
			last = (rs.getInt(1) > 0) ? rs.getInt(1) : 0;
		} catch (SQLException e) {
			System.out.println("ERR_last_uid : " + e.getMessage());
//		} finally {
//			try {
//				DB.conn.close();
//			} catch (SQLException e) {
//				System.out.println("ERR_last_uid_finally : " + e.getMessage());
//			}
		}
		return last;
	}	//last_uid()
}