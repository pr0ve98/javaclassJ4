package blog;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.GetConn;
import user.UserDAO;
import user.UserVO;

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
			sql = "insert into hbBlog values(default, ?, ?, ?, default)";
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
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 방문자수 증가
	public void setTotalVisit(String mid) {
		try {
			sql = "update hbBlog set totalVisit=totalVisit+1 where blogMid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 블로그에 대한 카테고리 가져오기
	public ArrayList<CategoryVO> getCategory(int blogIdx, int sw) {
		ArrayList<CategoryVO> vos = new ArrayList<CategoryVO>();
		try {
			if(sw == 0) sql = "select * from hbCategory where caBlogIdx=?";
			else if(sw == 1) sql = "select * from hbCategory where caBlogIdx=? and parentCategoryIdx is null";
			else sql = "select * from hbCategory where caBlogIdx=? and parentCategoryIdx is not null";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, blogIdx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CategoryVO vo = new CategoryVO();
				vo.setCaIdx(rs.getInt("caIdx"));
				vo.setCaBlogIdx(rs.getInt("caBlogIdx"));
				vo.setCategory(rs.getString("category"));
				vo.setParentCategoryIdx(rs.getInt("parentCategoryIdx"));
				vo.setPublicSetting(rs.getString("publicSetting"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 카테고리 추가
	public void setCategoryInput(String pCategoryName, int blogIdx, int pIdx, int sw) {
		try {
			if(sw == 0) {
				sql = "insert into hbCategory values(default, ?, ?, null, default)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, blogIdx);
				pstmt.setString(2, pCategoryName);
			}
			else if(sw == 1) {
				sql = "insert into hbCategory values(default, ?, ?, ?, default)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, blogIdx);
				pstmt.setString(2, pCategoryName);
				pstmt.setInt(3, pIdx);
			}
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		
	}

	// idx로 카테고리 찾기
	public CategoryVO getCategoryIdx(int pIdx) {
		CategoryVO vo = new CategoryVO();
		try {
			sql = "select * from hbCategory where caIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pIdx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setCaIdx(rs.getInt("caIdx"));
				vo.setCaBlogIdx(rs.getInt("caBlogIdx"));
				vo.setCategory(rs.getString("category"));
				vo.setParentCategoryIdx(rs.getInt("parentCategoryIdx"));
				vo.setPublicSetting(rs.getString("publicSetting"));
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 카테고리가 있을시 업데이트
	public void setCategoryUpdate(int caIdx, int caBlogIdx, String pCategoryName, int parentCategoryIdx,
			String publicSetting) {
		try {
			if(parentCategoryIdx == 0) {
				sql = "update hbCategory set caBlogIdx=?, category=?, publicSetting=? where caIdx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, caBlogIdx);
				pstmt.setString(2, pCategoryName);
				pstmt.setString(3, publicSetting);
				pstmt.setInt(4, caIdx);
			}
			else {
				sql = "update hbCategory set caBlogIdx=?, category=?, parentCategoryIdx=?, publicSetting=? where caIdx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, caBlogIdx);
				pstmt.setString(2, pCategoryName);
				pstmt.setInt(3, parentCategoryIdx);
				pstmt.setString(4, publicSetting);
				pstmt.setInt(5, caIdx);
			}
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		
	}

	// 최근 추가한 카테고리 id 가져오기
	public int getLastInsertedCategoryId() {
		try {
			sql = "SELECT LAST_INSERT_ID()";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return -1;
	}

	// 카테고리 이름 수정
	public int setCategoryNameUpdate(String caName, int caIdx) {
		int res = 0;
		try {
			sql = "update hbCategory set category=? where caIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, caName);
			pstmt.setInt(2, caIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	// 카테고리 삭제
	public int setCategoryDelete(int caIdx) {
		int res = 0;
		try {
			sql = "delete from hbCategory where caIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, caIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 회원 탈퇴시 블로그 삭제
	public void setBlogDelete(String mid) {
		try {
			sql = "delete from hbBlog where blogMid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		
	}

	// 블로그 기본 정보 수정
	public int setBlogEdit(String blogTitle, String blogIntro, String mid) {
		int res = 0;
		try {
			sql = "update hbBlog set blogTitle=?, blogIntro=? where blogMid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, blogTitle);
			pstmt.setString(2, blogIntro);
			pstmt.setString(3, mid);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	// 해당 부모에 대한 자식 카테고리 가져오기
	public ArrayList<CategoryVO> getCategoryChild(int caIdx) {
		ArrayList<CategoryVO> vos = new ArrayList<CategoryVO>();
		try {
			sql = "select * from hbCategory where parentCategoryIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, caIdx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CategoryVO vo = new CategoryVO();
				vo.setCaIdx(rs.getInt("caIdx"));
				vo.setCaBlogIdx(rs.getInt("caBlogIdx"));
				vo.setCategory(rs.getString("category"));
				vo.setParentCategoryIdx(rs.getInt("parentCategoryIdx"));
				vo.setPublicSetting(rs.getString("publicSetting"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 카테고리 비공개
	public int setCategoryPrivate(int caIdx) {
		int res = 0;
		try {
			sql = "update hbCategory set publicSetting='비공개' where caIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, caIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}


	// 카테고리 공개
	public int setCategoryPublic(int caIdx) {
		int res = 0;
		try {
			sql = "update hbCategory set publicSetting='공개' where caIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, caIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 랜덤으로 블로그 6개 가져오기
	public ArrayList<BlogVO> getRandomBlog(int myblogIdx) {
		ArrayList<BlogVO> vos = new ArrayList<BlogVO>();
		try {
			sql = "select * from hbBlog WHERE blogIdx != ?  order by RAND() limit 6";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, myblogIdx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BlogVO vo = new BlogVO();
				vo.setBlogIdx(rs.getInt("blogIdx"));
				vo.setBlogMid(rs.getString("blogMid"));
				vo.setBlogTitle(rs.getString("blogTitle"));
				vo.setBlogIntro(rs.getString("blogIntro"));
				vo.setTotalVisit(rs.getInt("totalVisit"));
				
				UserDAO uDao = new UserDAO();
				UserVO uVo = uDao.getUserIdCheck(vo.getBlogMid());
				vo.setUserImg(uVo.getUserImg());
				vo.setNickName(uVo.getNickName());
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	public BlogVO getBlogIdx(int BlogIdx) {
		BlogVO vo = new BlogVO();
		try {
			sql = "select * from hbBlog where blogIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, BlogIdx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setBlogIdx(rs.getInt("blogIdx"));
				vo.setBlogMid(rs.getString("blogMid"));
				vo.setBlogTitle(rs.getString("blogTitle"));
				vo.setBlogIntro(rs.getString("blogIntro"));
				vo.setTotalVisit(rs.getInt("totalVisit"));
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

}
