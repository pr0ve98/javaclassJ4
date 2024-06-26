package content;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import blog.BlogDAO;
import blog.BlogVO;
import blog.CategoryVO;

@SuppressWarnings("serial")
@WebServlet("/ContentEditOk")
public class ContentEditOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title")==null ? "" : request.getParameter("title");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		int caIdx = request.getParameter("category")==null ? 0 : Integer.parseInt(request.getParameter("category"));
		String part = request.getParameter("part")==null ? "" : request.getParameter("part");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		String publicSetting = request.getParameter("publicSetting")==null ? "" : request.getParameter("publicSetting");
		int coIdx = request.getParameter("coIdx")==null ? 0 : Integer.parseInt(request.getParameter("coIdx"));
		
		/*
		 * System.out.println("MID: " + mid); System.out.println("Title: " + title);
		 * System.out.println("Plain Text Content: " + content);
		 * System.out.println("caIdx: " + caIdx); System.out.println("Part: " + part);
		 * System.out.println("hostIp: " + hostIp);
		 * System.out.println("Public Setting: " + publicSetting);
		 */
		
		// 텍스트만 뽑아내기
        Document doc = Jsoup.parse(content);
        String ctPreview = doc.text();
        if(ctPreview.length() > 200) {
        	ctPreview = ctPreview.substring(0, 200);
        }
        
        // content에서 이미지 파일명만 가져오기
        List<String> imagesName = new ArrayList<>();
        Elements imgElements = doc.select("img");
        for (Element imgElement : imgElements) {
            String src = imgElement.attr("src");
            String fileName = "";
            if(src.indexOf("http") == -1) fileName = src.substring(src.lastIndexOf("/") + 1);
            else fileName = src;
            imagesName.add(fileName);
        }
        String imageFileName = String.join("|", imagesName);
        
        BlogDAO bDao = new BlogDAO();
        
        // 카테고리가 비공개면 공개 설정을 비공개로 변경
        CategoryVO cVo = bDao.getCategoryIdx(caIdx);
        if(cVo.getPublicSetting().equals("비공개")) publicSetting = "비공개";
        
        ContentVO vo = new ContentVO();
        vo.setCategoryIdx(caIdx);
        vo.setTitle(title);
        vo.setPart(part);
        vo.setContent(content);
        vo.setCtPreview(ctPreview);
        vo.setcHostIp(hostIp);
        vo.setCoPublic(publicSetting);
        vo.setImgName(imageFileName);
        
        ContentDAO cDao = new ContentDAO();
        int res = cDao.setContentUpdate(vo, coIdx);
        
        response.getWriter().write(res+"/"+caIdx);
	}
}
