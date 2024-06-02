package content;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.GetConn;
import user.UserDAO;
import user.UserVO;

public class ReplyDAO {
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	ReplyVO vo = null;
	
	public ReplyDAO() {}
	
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

	// 댓글 등록
	public int setReplyInput(int blogIdx, int coIdx, String mid, String nickName, String content,
			String hostIp, String rPublic, int prIdx, int sw) {
		int res = 0;
		try {
			if(sw == 0) {
				sql = "insert into hbReply values(default, ?, ?, ?, ?, ?, default, ?, null, ?, default)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, blogIdx);
				pstmt.setInt(2, coIdx);
				pstmt.setString(3, mid);
				pstmt.setString(4, nickName);
				pstmt.setString(5, content);
				pstmt.setString(6, hostIp);
				pstmt.setString(7, rPublic);
			}
			else {
				sql = "insert into hbReply values(default, ?, ?, ?, ?, ?, default, ?, ?, ?, default)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, blogIdx);
				pstmt.setInt(2, coIdx);
				pstmt.setString(3, mid);
				pstmt.setString(4, nickName);
				pstmt.setString(5, content);
				pstmt.setString(6, hostIp);
				pstmt.setInt(7, prIdx);
				pstmt.setString(8, rPublic);
			}
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 모든 댓글 가져오기
	public ArrayList<ReplyVO> getReplyList(int coIdx, int sw) {
		ArrayList<ReplyVO> vos = new ArrayList<ReplyVO>();
		try {
			if(sw == 0) sql = "select * from hbReply where rCoIdx=? and parentReplyIdx is null";
			else sql = "select * from hbReply where rCoIdx=? and parentReplyIdx is not null";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, coIdx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new ReplyVO();
				vo.setrIdx(rs.getInt("rIdx"));
				vo.setrBlogIdx(rs.getInt("rBlogIdx"));
				vo.setrCoIdx(rs.getInt("rCoIdx"));
				vo.setrMid(rs.getString("rMid"));
				vo.setrNickName(rs.getString("rNickName"));
				vo.setrContent(rs.getString("rContent"));
				vo.setrDate(rs.getString("rDate"));
				vo.setrHostIp(rs.getString("rHostIp"));
				vo.setParentReplyIdx(rs.getInt("parentReplyIdx"));
				vo.setrPublic(rs.getString("rPublic"));
				vo.setReadCheck(rs.getString("readCheck"));
				
				UserDAO uDao = new UserDAO();
				UserVO uVo = uDao.getUserIdCheck(vo.getrMid());
				vo.setrUserImg(uVo.getUserImg());
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 댓글 수정
	public int setReplyUpdate(String content, String rPublic, int rIdx) {
		int res = 0;
		try {
			sql = "update hbReply set rContent=?, rPublic=? where rIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setString(2, rPublic);
			pstmt.setInt(3, rIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	// 댓글 삭제
	public int setReplyDelete(int rIdx) {
		int res = 0;
		try {
			sql = "delete from hbReply where rIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 댓글 수
	public int getReplyCount(int coIdx) {
		int replyCnt = 0;
		try {
			sql = "select count(*) as replyCnt from hbReply where rCoIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, coIdx);
			rs = pstmt.executeQuery();
			rs.next();
			replyCnt = rs.getInt("replyCnt");
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return replyCnt;
	}

	// 블로그 총 댓글수
	public int getContentCnt(int blogIdx, String part, String search) {
		int totRecCnt = 0;
		try {
			if(search.equals("")) {
				sql = "select count(*) as allReplyCnt from hbReply where rBlogIdx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, blogIdx);
				
			}
			else {
				if(part.equals("작성자")) sql = "select count(*) as allReplyCnt from hbReply where rBlogIdx=? and rNickName like ?";
				else sql = "select count(*) as allReplyCnt from hbReply where rBlogIdx=? and rContent like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, blogIdx);
				pstmt.setString(2, "%"+search+"%");
			}
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("allReplyCnt");
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return totRecCnt;
	}

	// 댓글 총 리스트 가져오기
	public ArrayList<ReplyVO> getReplyAllList(int startIndexNo, int pageSize, int blogIdx, String search, String part) {
		ArrayList<ReplyVO> vos = new ArrayList<ReplyVO>();
		try {
			if(search.equals("")) {
				sql = "select * from hbReply where rBlogIdx=? limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, blogIdx);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			else {
				if(part.equals("작성자")) sql = "select * from hbReply where rBlogIdx=? and rNickName like ? limit ?,?";
				else sql = "select * from hbReply where rBlogIdx=? and rContent like ? limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, blogIdx);
				pstmt.setString(2, "%"+search+"%");
				pstmt.setInt(3, startIndexNo);
				pstmt.setInt(4, pageSize);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new ReplyVO();
				vo.setrIdx(rs.getInt("rIdx"));
				vo.setrBlogIdx(rs.getInt("rBlogIdx"));
				vo.setrCoIdx(rs.getInt("rCoIdx"));
				vo.setrMid(rs.getString("rMid"));
				vo.setrNickName(rs.getString("rNickName"));
				vo.setrContent(rs.getString("rContent"));
				vo.setrDate(rs.getString("rDate"));
				vo.setrHostIp(rs.getString("rHostIp"));
				vo.setParentReplyIdx(rs.getInt("parentReplyIdx"));
				vo.setrPublic(rs.getString("rPublic"));
				vo.setReadCheck(rs.getString("readCheck"));
				
				UserDAO uDao = new UserDAO();
				UserVO uVo = uDao.getUserIdCheck(vo.getrMid());
				vo.setrUserImg(uVo.getUserImg());
				
				ContentDAO cDao = new ContentDAO();
				ContentVO cVo = cDao.getContent(vo.getrCoIdx());
				vo.setCoTitle(cVo.getTitle());
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 댓글들 읽음으로 변경
	public int setReplysUpdateRead(String checkedrIdx) {
		int res = 0;
		try {
			sql = "update hbReply set readCheck='읽음' where rIdx in ("+checkedrIdx+")";
			pstmt = conn.prepareStatement(sql);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	// 댓글들 전부 삭제
	public int setReplysDelete(String checkedrIdx) {
		int res = 0;
		try {
			sql = "delete from hbReply where rIdx in ("+checkedrIdx+")";
			pstmt = conn.prepareStatement(sql);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 읽지않은 댓글들 가져오기
	public ArrayList<ReplyVO> getNotReadReplys(int blogIdx) {
		ArrayList<ReplyVO> vos = new ArrayList<ReplyVO>();
		try {
			sql = "select * from hbReply where rBlogIdx=? and readCheck='읽지않음' order by rIdx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, blogIdx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new ReplyVO();
				vo.setrIdx(rs.getInt("rIdx"));
				vo.setrBlogIdx(rs.getInt("rBlogIdx"));
				vo.setrCoIdx(rs.getInt("rCoIdx"));
				vo.setrMid(rs.getString("rMid"));
				vo.setrNickName(rs.getString("rNickName"));
				vo.setrContent(rs.getString("rContent"));
				vo.setrDate(rs.getString("rDate"));
				vo.setrHostIp(rs.getString("rHostIp"));
				vo.setParentReplyIdx(rs.getInt("parentReplyIdx"));
				vo.setrPublic(rs.getString("rPublic"));
				vo.setReadCheck(rs.getString("readCheck"));
				
				UserDAO uDao = new UserDAO();
				UserVO uVo = uDao.getUserIdCheck(vo.getrMid());
				vo.setrUserImg(uVo.getUserImg());
				
				ContentDAO cDao = new ContentDAO();
				ContentVO cVo = cDao.getContent(vo.getrCoIdx());
				vo.setCoTitle(cVo.getTitle());
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 읽지않은 댓글 수
	public int getNotReadReplysCnt(int blogIdx) {
		int newReplyCnt = 0;
		try {
			sql = "select count(*) as newReplyCnt from hbReply where rBlogIdx=? and readCheck='읽지않음'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, blogIdx);
			rs = pstmt.executeQuery();
			rs.next();
			newReplyCnt = rs.getInt("newReplyCnt");
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return newReplyCnt;
	}

	// 댓글 하나만 가져오기
	public ReplyVO getReply(String rIdx) {
		ReplyVO vo = new ReplyVO();
		int idx = Integer.parseInt(rIdx);
		try {
			sql = "select * from hbReply where rIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setrIdx(rs.getInt("rIdx"));
				vo.setrBlogIdx(rs.getInt("rBlogIdx"));
				vo.setrCoIdx(rs.getInt("rCoIdx"));
				vo.setrMid(rs.getString("rMid"));
				vo.setrNickName(rs.getString("rNickName"));
				vo.setrContent(rs.getString("rContent"));
				vo.setrDate(rs.getString("rDate"));
				vo.setrHostIp(rs.getString("rHostIp"));
				vo.setParentReplyIdx(rs.getInt("parentReplyIdx"));
				vo.setrPublic(rs.getString("rPublic"));
				vo.setReadCheck(rs.getString("readCheck"));
				
				UserDAO uDao = new UserDAO();
				UserVO uVo = uDao.getUserIdCheck(vo.getrMid());
				vo.setrUserImg(uVo.getUserImg());
				
				ContentDAO cDao = new ContentDAO();
				ContentVO cVo = cDao.getContent(vo.getrCoIdx());
				vo.setCoTitle(cVo.getTitle());
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 댓글 읽음
	public void setReplyUpdateRead(int rIdx) {
		try {
			sql = "update hbReply set readCheck='읽음' where rIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	

}
