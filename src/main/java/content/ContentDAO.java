package content;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import blog.BlogDAO;
import blog.BlogVO;
import blog.CategoryVO;
import common.GetConn;
import user.UserDAO;
import user.UserVO;

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
	public ArrayList<ContentVO> getContentList(int startIndexNo, int pageSize, int blogIdx, String user,
			int categoryIdx, ArrayList<CategoryVO> categoryIdxs, String search) {
		ArrayList<ContentVO> vos = new ArrayList<ContentVO>();
		try {
			if(search.equals("")) {
				if(categoryIdxs == null) { // 자식 카테고리
					if(user.equals("주인")) {
						if(categoryIdx == 0) {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coBlogIdx=? order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, startIndexNo);
							pstmt.setInt(3, pageSize);
						}
						else {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coBlogIdx=? and categoryIdx=? order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							pstmt.setInt(3, startIndexNo);
							pstmt.setInt(4, pageSize);
						}
					}
					else {
						if(categoryIdx == 0) {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coPublic='공개' and coBlogIdx=? order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, startIndexNo);
							pstmt.setInt(3, pageSize);
						}
						else {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coPublic='공개' and coBlogIdx=? and categoryIdx=? order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							pstmt.setInt(3, startIndexNo);
							pstmt.setInt(4, pageSize);
						}
					}
				}
				else { // 부모카테고리
					if(user.equals("주인")) {
						if(categoryIdx == 0) {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coBlogIdx=? order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, startIndexNo);
							pstmt.setInt(3, pageSize);
						}
						else {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coBlogIdx=? and categoryIdx in (?,";
							for(int i=0; i<categoryIdxs.size(); i++) {
								sql += "?,";
							}
							sql = sql.substring(0, sql.lastIndexOf(","));
							sql += ") order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							int cnt = 3;
							for(CategoryVO vo : categoryIdxs) {
								pstmt.setInt(cnt, vo.getCaIdx());
								cnt++;
							}
							pstmt.setInt(cnt, startIndexNo);
							pstmt.setInt(cnt+1, pageSize);
						}
					}
					else {
						if(categoryIdx == 0) {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coPublic='공개' and coBlogIdx=? order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, startIndexNo);
							pstmt.setInt(3, pageSize);
						}
						else {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coPublic='공개' and coBlogIdx=? and categoryIdx in (?,";
							for(int i=0; i<categoryIdxs.size(); i++) {
								sql += "?,";
							}
							sql = sql.substring(0, sql.lastIndexOf(","));
							sql += ") order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							int cnt = 3;
							for(CategoryVO vo : categoryIdxs) {
								pstmt.setInt(cnt, vo.getCaIdx());
								cnt++;
							}
							pstmt.setInt(cnt, startIndexNo);
							pstmt.setInt(cnt+1, pageSize);
						}
					}
				}
			}
			else {
				if(categoryIdxs == null) { // 자식 카테고리
					if(user.equals("주인")) {
						if(categoryIdx == 0) {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coBlogIdx=? and (title like ? or content like ?) order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setString(2, "%"+search+"%");
							pstmt.setString(3, "%"+search+"%");
							pstmt.setInt(4, startIndexNo);
							pstmt.setInt(5, pageSize);
						}
						else {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coBlogIdx=? and categoryIdx=? and (title like ? or content like ?) order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							pstmt.setString(3, "%"+search+"%");
							pstmt.setString(4, "%"+search+"%");
							pstmt.setInt(5, startIndexNo);
							pstmt.setInt(6, pageSize);
						}
					}
					else {
						if(categoryIdx == 0) {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coPublic='공개' and coBlogIdx=? and (title like ? or content like ?) order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setString(2, "%"+search+"%");
							pstmt.setString(3, "%"+search+"%");
							pstmt.setInt(2, startIndexNo);
							pstmt.setInt(3, pageSize);
						}
						else {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coPublic='공개' and coBlogIdx=? and categoryIdx=? and (title like ? or content like ?) order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							pstmt.setString(3, "%"+search+"%");
							pstmt.setString(4, "%"+search+"%");
							pstmt.setInt(5, startIndexNo);
							pstmt.setInt(6, pageSize);
						}
					}
				}
				else { // 부모카테고리
					if(user.equals("주인")) {
						if(categoryIdx == 0) {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coBlogIdx=? and (title like ? or content like ?) order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setString(2, "%"+search+"%");
							pstmt.setString(3, "%"+search+"%");
							pstmt.setInt(4, startIndexNo);
							pstmt.setInt(5, pageSize);
						}
						else {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coBlogIdx=? and categoryIdx in (?,";
							for(int i=0; i<categoryIdxs.size(); i++) {
								sql += "?,";
							}
							sql = sql.substring(0, sql.lastIndexOf(","));
							sql += ") and (title like ? or content like ?) order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							int cnt = 3;
							for(CategoryVO vo : categoryIdxs) {
								pstmt.setInt(cnt, vo.getCaIdx());
								cnt++;
							}
							pstmt.setString(cnt, "%"+search+"%");
							pstmt.setString(cnt+1, "%"+search+"%");
							pstmt.setInt(cnt+2, startIndexNo);
							pstmt.setInt(cnt+3, pageSize);
						}
					}
					else {
						if(categoryIdx == 0) {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coPublic='공개' and coBlogIdx=? and (title like ? or content like ?) order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setString(2, "%"+search+"%");
							pstmt.setString(3, "%"+search+"%");
							pstmt.setInt(4, startIndexNo);
							pstmt.setInt(5, pageSize);
						}
						else {
							sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
									+ "from hbContent where coPublic='공개' and coBlogIdx=? and categoryIdx in (?,";
							for(int i=0; i<categoryIdxs.size(); i++) {
								sql += "?,";
							}
							sql = sql.substring(0, sql.lastIndexOf(","));
							sql += ") and (title like ? or content like ?) order by coIdx desc limit ?,?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							int cnt = 3;
							for(CategoryVO vo : categoryIdxs) {
								pstmt.setInt(cnt, vo.getCaIdx());
								cnt++;
							}
							pstmt.setString(cnt, "%"+search+"%");
							pstmt.setString(cnt+1, "%"+search+"%");
							pstmt.setInt(cnt+2, startIndexNo);
							pstmt.setInt(cnt+3, pageSize);
						}
					}
				}
			}
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
				
				ReplyDAO rDao = new ReplyDAO();
				int replyCnt = rDao.getReplyCount(vo.getCoIdx());
				vo.setReplyCnt(replyCnt);
				
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setMin_diff(rs.getInt("min_diff"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return vos;
	}

	// 총 게시글 수
	public int getContentCnt(int blogIdx, String user, int categoryIdx, ArrayList<CategoryVO> categoryIdxs, String search) {
		int totRecCnt = 0;
		try {
			if(search.equals("")) {
				if(categoryIdxs == null) { // 자식 카테고리
					if(user.equals("주인")) {
						if(categoryIdx == 0) {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
						}
						else {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and categoryIdx=?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
						}
					}
					else {
						if(categoryIdx == 0) {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and coPublic='공개'";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
						}
						else {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and coPublic='공개' and categoryIdx=?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
						}
					}
				}
				else { // 부모카테고리
					if(user.equals("주인")) {
						if(categoryIdx == 0) {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
						}
						else {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and categoryIdx in (?,";
							for(int i=0; i<categoryIdxs.size(); i++) {
								sql += "?,";
							}
							sql = sql.substring(0, sql.lastIndexOf(","));
							sql += ")";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							int cnt = 3;
							for(CategoryVO vo : categoryIdxs) {
								pstmt.setInt(cnt, vo.getCaIdx());
								cnt++;
							}
						}
					}
					else {
						if(categoryIdx == 0) {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and coPublic='공개'";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
						}
						else {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and coPublic='공개' and categoryIdx in (?,";
							for(int i=0; i<categoryIdxs.size(); i++) {
								sql += "?,";
							}
							sql = sql.substring(0, sql.lastIndexOf(","));
							sql += ")";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							int cnt = 3;
							for(CategoryVO vo : categoryIdxs) {
								pstmt.setInt(cnt, vo.getCaIdx());
								cnt++;
							}
						}
					}
				}
			}
			else {
				if(categoryIdxs == null) { // 자식 카테고리
					if(user.equals("주인")) {
						if(categoryIdx == 0) {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and (title like ? or content like ?)";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setString(2, "%"+search+"%");
							pstmt.setString(3, "%"+search+"%");
							
						}
						else {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and categoryIdx=? and (title like ? or content like ?)";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							pstmt.setString(3, "%"+search+"%");
							pstmt.setString(4, "%"+search+"%");
						}
					}
					else {
						if(categoryIdx == 0) {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and coPublic='공개' and (title like ? or content like ?)";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setString(2, "%"+search+"%");
							pstmt.setString(3, "%"+search+"%");
						}
						else {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and coPublic='공개' and categoryIdx=? and (title like ? or content like ?)";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							pstmt.setString(3, "%"+search+"%");
							pstmt.setString(4, "%"+search+"%");
						}
					}
				}
				else { // 부모카테고리
					if(user.equals("주인")) {
						if(categoryIdx == 0) {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and (title like ? or content like ?)";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setString(2, "%"+search+"%");
							pstmt.setString(3, "%"+search+"%");
						}
						else {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and categoryIdx in (?,";
							for(int i=0; i<categoryIdxs.size(); i++) {
								sql += "?,";
							}
							sql = sql.substring(0, sql.lastIndexOf(","));
							sql += ") and (title like ? or content like ?)";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							int cnt = 3;
							for(CategoryVO vo : categoryIdxs) {
								pstmt.setInt(cnt, vo.getCaIdx());
								cnt++;
							}
							pstmt.setString(cnt, "%"+search+"%");
							pstmt.setString(cnt+1, "%"+search+"%");
						}
					}
					else {
						if(categoryIdx == 0) {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and coPublic='공개' and (title like ? or content like ?)";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setString(2, "%"+search+"%");
							pstmt.setString(3, "%"+search+"%");
						}
						else {
							sql = "select count(*) as cnt from hbContent where coBlogIdx=? and coPublic='공개' and categoryIdx in (?,";
							for(int i=0; i<categoryIdxs.size(); i++) {
								sql += "?,";
							}
							sql = sql.substring(0, sql.lastIndexOf(","));
							sql += ") and (title like ? or content like ?)";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, blogIdx);
							pstmt.setInt(2, categoryIdx);
							int cnt = 3;
							for(CategoryVO vo : categoryIdxs) {
								pstmt.setInt(cnt, vo.getCaIdx());
								cnt++;
							}
							pstmt.setString(cnt, "%"+search+"%");
							pstmt.setString(cnt+1, "%"+search+"%");
						}
					}
				}
			}
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return totRecCnt;
	}

	// 게시글 가져오기
	public ContentVO getContent(int coIdx) {
		ContentVO vo = new ContentVO();
		try {
			sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff,"
					+ " timestampdiff(minute, wDate, now()) as min_diff from hbContent where coIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, coIdx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
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
				
				ReplyDAO rDao = new ReplyDAO();
				int replyCnt = rDao.getReplyCount(vo.getCoIdx());
				vo.setReplyCnt(replyCnt);
				
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setMin_diff(rs.getInt("min_diff"));
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 글 수정
	public int setContentUpdate(ContentVO vo, int coIdx) {
		int res = 0;
		try {
			sql = "update hbContent set categoryIdx=?, title=?, part=?, content=?, ctPreview=?, cHostIp=?, coPublic=?, imgName=? where coIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getCategoryIdx());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getPart());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getCtPreview());
			pstmt.setString(6, vo.getcHostIp());
			pstmt.setString(7, vo.getCoPublic());
			pstmt.setString(8, vo.getImgName());
			pstmt.setInt(9, coIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	// 글 삭제
	public int setContentDelete(int coIdx) {
		int res = 0;
		try {
			sql = "delete from hbContent where coIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, coIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 글 조회수 증가
	public void setViewCnt(int coIdx) {
		try {
			sql = "update hbContent set viewCnt=viewCnt+1 where coIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, coIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 이전글 처리
	public ContentVO getPreSearch(int blogIdx, int coIdx, int categoryIdx, ArrayList<CategoryVO> categoryIdxs, String user) {
		ContentVO vo = new ContentVO();
		try {
			if(user.equals("주인")) {
				if(categoryIdx == 0) {
					sql = "select coIdx, categoryIdx, title, viewCnt, wDate from "
							+ "hbContent where coBlogIdx=? and coIdx < ? order by coIdx desc limit 1";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, blogIdx);
					pstmt.setInt(2, coIdx);
				}
				else {
					if(categoryIdxs != null) {
						sql = "select coIdx, categoryIdx, title, viewCnt, wDate from "
								+ "hbContent where coBlogIdx=? and categoryIdx in (?,";
						for(int i=0; i<categoryIdxs.size(); i++) {
							sql += "?,";
						}
						sql = sql.substring(0, sql.lastIndexOf(","));
						sql += ") and coIdx < ? order by coIdx desc limit 1";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, blogIdx);
						pstmt.setInt(2, categoryIdx);
						int cnt = 3;
						for(CategoryVO caVo : categoryIdxs) {
							pstmt.setInt(cnt, caVo.getCaIdx());
							cnt++;
						}
						pstmt.setInt(cnt, coIdx);
					}
					else {
						sql = "select coIdx, categoryIdx, title, viewCnt, wDate from hbContent "
								+ "where coBlogIdx=? and categoryIdx=? and coIdx < ? order by coIdx desc limit 1";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, blogIdx);
						pstmt.setInt(2, categoryIdx);
						pstmt.setInt(3, coIdx);
					}
				}
			}
			else {
				if(categoryIdx == 0) {
					sql = "select coIdx, categoryIdx, title, viewCnt, wDate from "
							+ "hbContent where coBlogIdx=? and coPublic='공개' and coIdx < ? order by coIdx desc limit 1";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, blogIdx);
					pstmt.setInt(2, coIdx);
				}
				else {
					if(categoryIdxs != null) {
						sql = "select coIdx, categoryIdx, title, viewCnt, wDate from "
								+ "hbContent where coBlogIdx=? and coPublic='공개' and categoryIdx in (?,";
						for(int i=0; i<categoryIdxs.size(); i++) {
							sql += "?,";
						}
						sql = sql.substring(0, sql.lastIndexOf(","));
						sql += ") and coIdx < ? order by coIdx desc limit 1";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, blogIdx);
						pstmt.setInt(2, categoryIdx);
						int cnt = 3;
						for(CategoryVO caVo : categoryIdxs) {
							pstmt.setInt(cnt, caVo.getCaIdx());
							cnt++;
						}
						pstmt.setInt(cnt, coIdx);
					}
					else {
						sql = "select coIdx, categoryIdx, title, viewCnt, wDate from hbContent "
								+ "where coBlogIdx=? and coPublic='공개' and categoryIdx=? and coIdx < ? order by coIdx desc limit 1";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, blogIdx);
						pstmt.setInt(2, categoryIdx);
						pstmt.setInt(3, coIdx);
					}
				}
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setCoIdx(rs.getInt("coIdx"));
				vo.setCategoryIdx(rs.getInt("categoryIdx"));
				vo.setTitle(rs.getString("title"));
				vo.setwDate(rs.getString("wDate"));
				vo.setViewCnt(rs.getInt("viewCnt"));
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}
	
	// 다음글 처리
	public ContentVO getNextSearch(int blogIdx, int coIdx, int categoryIdx, ArrayList<CategoryVO> categoryIdxs, String user) {
		ContentVO vo = new ContentVO();
		try {
			if(user.equals("주인")) {
				if(categoryIdx == 0) {
					sql = "select coIdx, categoryIdx, title, viewCnt, wDate from "
							+ "hbContent where coBlogIdx=? and coIdx > ? order by coIdx limit 1";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, blogIdx);
					pstmt.setInt(2, coIdx);
				}
				else {
					if(categoryIdxs != null) {
						sql = "select coIdx, categoryIdx, title, viewCnt, wDate from "
								+ "hbContent where coBlogIdx=? and categoryIdx in (?,";
						for(int i=0; i<categoryIdxs.size(); i++) {
							sql += "?,";
						}
						sql = sql.substring(0, sql.lastIndexOf(","));
						sql += ") and coIdx > ? order by coIdx limit 1";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, blogIdx);
						pstmt.setInt(2, categoryIdx);
						int cnt = 3;
						for(CategoryVO caVo : categoryIdxs) {
							pstmt.setInt(cnt, caVo.getCaIdx());
							cnt++;
						}
						pstmt.setInt(cnt, coIdx);
					}
					else {
						sql = "select coIdx, categoryIdx, title, viewCnt, wDate from "
								+ "hbContent where coBlogIdx=? and categoryIdx=? and coIdx > ? order by coIdx limit 1";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, blogIdx);
						pstmt.setInt(2, categoryIdx);
						pstmt.setInt(3, coIdx);
					}
				}
			}
			else {
				if(categoryIdx == 0) {
					sql = "select coIdx, categoryIdx, title, viewCnt, wDate from "
							+ "hbContent where coBlogIdx=? and coPublic='공개' and coIdx > ? order by coIdx limit 1";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, blogIdx);
					pstmt.setInt(2, coIdx);
				}
				else {
					if(categoryIdxs != null) {
						sql = "select coIdx, categoryIdx, title, viewCnt, wDate from "
								+ "hbContent where coBlogIdx=? and coPublic='공개' and categoryIdx in (?,";
						for(int i=0; i<categoryIdxs.size(); i++) {
							sql += "?,";
						}
						sql = sql.substring(0, sql.lastIndexOf(","));
						sql += ") and coIdx > ? order by coIdx limit 1";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, blogIdx);
						pstmt.setInt(2, categoryIdx);
						int cnt = 3;
						for(CategoryVO caVo : categoryIdxs) {
							pstmt.setInt(cnt, caVo.getCaIdx());
							cnt++;
						}
						pstmt.setInt(cnt, coIdx);
					}
					else {
						sql = "select coIdx, categoryIdx, title, viewCnt, wDate from "
								+ "hbContent where coBlogIdx=? and coPublic='공개' and categoryIdx=? and coIdx > ? order by coIdx limit 1";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, blogIdx);
						pstmt.setInt(2, categoryIdx);
						pstmt.setInt(3, coIdx);
					}
				}
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setCoIdx(rs.getInt("coIdx"));
				vo.setCategoryIdx(rs.getInt("categoryIdx"));
				vo.setTitle(rs.getString("title"));
				vo.setwDate(rs.getString("wDate"));
				vo.setViewCnt(rs.getInt("viewCnt"));
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 글 여러개 공개/비공개 변경
	public int setContentsUpdatePublic(String checkedCoIdx, String selected) {
		int res = 0;
		try {
			if(selected.equals("공개")) sql = "update hbContent set coPublic='공개' where coIdx in ("+checkedCoIdx+")";
			else sql = "update hbContent set coPublic='비공개' where coIdx in ("+checkedCoIdx+")";
			pstmt = conn.prepareStatement(sql);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 글 여러개 카테고리 변경
	public int setContentCategoryUpdate(String checkedCoIdx, int selected, int sw) {
		int res = 0;
		try {
			if(sw == 0) sql = "update hbContent set categoryIdx=? where coIdx in ("+checkedCoIdx+")";
			else sql = "update hbContent set categoryIdx=?, coPublic='비공개' where coIdx in ("+checkedCoIdx+")";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, selected);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 글 여러개 삭제
	public int setContentsDelete(String checkedCoIdx) {
		int res = 0;
		try {
			sql = "delete from hbContent where coIdx in ("+checkedCoIdx+")";
			pstmt = conn.prepareStatement(sql);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 구독한 블로그들 일주일 내 게시글 다 가져오기
	public ArrayList<ContentVO> getSubContents(int startIndexNo, int pageSize, String mySubBlog, String sMid) {
		ArrayList<ContentVO> vos = new ArrayList<ContentVO>();
		try {
			sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff, timestampdiff(minute, wDate, now()) as min_diff "
					+ "from hbContent where coBlogIdx in ("+mySubBlog+") AND wDate >= DATE_SUB(NOW(), INTERVAL 7 DAY) and coPublic='공개' "
							+ "order by coIdx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
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
				
				BlogVO bVo = bDao.getBlogIdx(vo.getCoBlogIdx());
				
				UserDAO uDao = new UserDAO();
				UserVO uVo = uDao.getUserIdCheck(bVo.getBlogMid());
				vo.setUserMid(uVo.getMid());
				vo.setUserImg(uVo.getUserImg());
				vo.setNickName(uVo.getNickName());
				
				ReplyDAO rDao = new ReplyDAO();
				int replyCnt = rDao.getReplyCount(vo.getCoIdx());
				vo.setReplyCnt(replyCnt);
				
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setMin_diff(rs.getInt("min_diff"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 구독한 블로그들의 총 게시글 수
	public int getSubContentCnt(String mySubBlog, String sMid) {
		int totRecCnt = 0;
		try {
			sql = "select count(*) as subContentCnt from hbContent where coBlogIdx in ("+mySubBlog+") and coPublic='공개' AND wDate >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("subContentCnt");
		} catch (SQLException e) {
			System.out.println("sql 오류 "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return totRecCnt;
	}


}
