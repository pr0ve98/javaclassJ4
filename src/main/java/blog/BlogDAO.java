package blog;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.GetConn;

public class BlogDAO {
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	BlogVO vo = null;
	
	public BlogDAO() {}
	
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {}
		}
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
			} catch (Exception e) {}
			finally {
				pstmtClose();
			}
		}
	}

	// 회원가입 할 때 자동으로 블로그 생성
	public void setInputBlog(String mid, String blogTitle, String blogIntro) {
		try {
			sql = "insert into hbBlog values(default, ?, ?, ?, default, default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, blogTitle);
			pstmt.setString(3, blogIntro);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		
	}

	// 아이디로 블로그 찾기
	public BlogVO getUserBlog(String mid) {
		BlogVO vo = new BlogVO();
		try {
			sql = "select * from hbBlog where blogMid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setBlogIdx(rs.getInt("blogIdx"));
				vo.setBlogMid(rs.getString("blogMid"));
				vo.setBlogTitle(rs.getString("blogTitle"));
				vo.setBlogIntro(rs.getString("blogIntro"));
				vo.setTotalVisit(rs.getInt("totalVisit"));
				vo.setTodayVisit(rs.getInt("todayVisit"));
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 방문자수 증가
	public void setVisit(String mid) {
		try {
			sql = "update hbBlog set totalVisit=totalVisit+1, todayVisit=todayVisit+1 where blogMid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 오늘 방문자수 초기화
	public void resetTodayVisit() {
		try {
			sql = "update hbBlog set todayVisit=0";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	
	
}
