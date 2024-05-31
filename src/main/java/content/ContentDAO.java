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
	public ArrayList<ContentVO> getContentList(int startIndexNo, int pageSize, int blogIdx, String user, int categoryIdx, ArrayList<CategoryVO> categoryIdxs) {
		ArrayList<ContentVO> vos = new ArrayList<ContentVO>();
		try {
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
	public int getContentCnt(int blogIdx, String user, int categoryIdx, ArrayList<CategoryVO> categoryIdxs) {
		int totRecCnt = 0;
		try {
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


}
