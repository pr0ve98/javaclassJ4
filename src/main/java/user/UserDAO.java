package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.GetConn;

public class UserDAO {
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	UserVO vo = null;
	
	public UserDAO() {}
	
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

	// 아이디 중복체크
	public UserVO getUserIdCheck(String mid) {
		UserVO vo = new UserVO();
		try {
			sql = "select * from hbUser where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setEmail(rs.getString("email"));
				vo.setNickName(rs.getString("nickName"));
				vo.setPwd(rs.getString("pwd"));
				vo.setName(rs.getString("name"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setIsDel(rs.getInt("isDel"));
				vo.setJoinDate(rs.getString("joinDate"));
				vo.setUserImg(rs.getString("userImg"));
				vo.setUserSImg(rs.getString("userSImg"));
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 이메일 중복체크
	public UserVO getUserEmailCheck(String email) {
		UserVO vo = new UserVO();
		try {
			sql = "select * from hbUser where email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setEmail(rs.getString("email"));
				vo.setPwd(rs.getString("pwd"));
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setIsDel(rs.getInt("isDel"));
				vo.setJoinDate(rs.getString("joinDate"));
				vo.setUserImg(rs.getString("userImg"));
				vo.setUserSImg(rs.getString("userSImg"));
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 유저 회원가입
	public int setUserJoinInput(UserVO vo) {
		int res = 0;
		try {
			sql = "insert into hbUser values (default, ?, ?, ?, ?, ?, ?, default, default, default, default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getPwd());
			pstmt.setString(4, vo.getNickName());
			pstmt.setString(5, vo.getName());
			pstmt.setDate(6, java.sql.Date.valueOf(vo.getBirthday()));
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	// 유저 프로필 사진 변경
	public int setUserImgChange(String img, String sImg, String mid) {
		int res = 0;
		try {
			sql = "update hbUser set userImg=?, userSImg=? where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, img);
			pstmt.setString(2, sImg);
			pstmt.setString(3, mid);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 유저 프로필 사진 기본이미지로 변경
	public int setUserImgBasicChange(String mid) {
		int res = 0;
		try {
			sql = "update hbUser set userImg='user_basic.jpg', userSImg='user_basic.jpg' where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	
	
}
