package content;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import blog.BlogDAO;
import blog.CategoryVO;
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

	// 전체글 가져오기
	public ArrayList<ContentVO> getContentList(int blogIdx) {
		ArrayList<ContentVO> vos = new ArrayList<ContentVO>();
		try {
			sql = "select * from hbContent order by coIdx desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ContentVO vo = new ContentVO();
				vo.setCoIdx(rs.getInt("coIdx"));
				vo.setCoBlogIdx(rs.getInt("coBlogIdx"));
				vo.setCategoryIdx(rs.getInt("categoryIdx"));
				vo.setTitle(rs.getString("title"));
				vo.setPart(rs.getString("part"));
				vo.setwDate(rs.getString("wDate"));
				vo.setViewCnt(rs.getInt("viewCnt"));
				vo.setContent(rs.getString("content"));
				vo.setCtPreview(rs.getString("ctPreview"));
				vo.setcHostIp(rs.getString("cHostIp"));
				vo.setCoPublic(rs.getString("coPublic"));
				vo.setImgName(rs.getString("imgName"));
				
				BlogDAO bDao = new BlogDAO();
				CategoryVO cVo = bDao.getCategoryIdx(vo.getCategoryIdx());
				vo.setCategoryName(cVo.getCategory());
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return vos;
	}
	
	

}
