package content;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.GetConn;

public class ContentDAO {
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	ContentVO vo = null;
	
	public ContentDAO() {}
	
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

	// 게시글 등록
	public int setContentInput(ContentVO vo) {
		int res = 0;
		try {
			sql = "insert into hbContent values(default, ?, ?, ?, ?, default, default, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getCoBlogIdx());
			pstmt.setInt(2, vo.getCategoryIdx());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getPart());
			pstmt.setString(5, vo.getContent());
			pstmt.setString(6, vo.getCtPreview());
			pstmt.setString(7, vo.getcHostIp());
			pstmt.setString(8, vo.getCoPublic());
			pstmt.setString(9, vo.getImgName());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	

}
