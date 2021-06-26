package service.display;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BookmarkDao;
import dao.DisplayDao;
import dao.ReviewDao;
import dao.RvLikesDao;
import model.Bookmark;
import model.Display;
import model.Review;
import model.RvLikes;
import service.CommandProcess;

public class DpView implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		int dno = Integer.parseInt(request.getParameter("dno"));

		DisplayDao dd = DisplayDao.getInstance();
		Display dp = dd.select(dno);
		
		// 리뷰 페이징 : start
		final int ROW_PER_PAGE = 4; // 한 페이지에 10개씩

		String pageNum = request.getParameter("pageNum");
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		// 현재 페이지
		int currentPage = Integer.parseInt(pageNum);
 
		// 뿌려질 리스트의 시작번호 
		int startRow = (currentPage - 1) * ROW_PER_PAGE + 1;
		// 끝번호
		int endRow = startRow + ROW_PER_PAGE - 1;
		
		// 해당 전시 리뷰 리스트 셀렉
		ReviewDao rd = ReviewDao.getInstance();
		List<Review> list = rd.select(dno, startRow, endRow);
		
		// 해당 전시의 총 리뷰 수
		int total = rd.getTotal(dno);
		
		// 총 페이지 수
		int totalPage = (int) Math.ceil((double)total/ROW_PER_PAGE);

		// 평균 별점
		float star_rate = 0;

		// 리뷰가 없을때 제어
		if (list.size() == 0) {
			star_rate = 0;
		} else {
			star_rate = (float) rd.selectStar(dno);
		}

		// 리뷰 갯수
		int reviewCnt = total; //list.size();

		// 회원이 좋아요한 리뷰가 있는지 체크
		RvLikesDao rvld = RvLikesDao.getInstance();
		List<RvLikes> rvList = rvld.select();
		
		// 회원이 북마크했는지 체크
		BookmarkDao bmd = BookmarkDao.getInstance();
		HttpSession session = request.getSession();
		String color = "";
		
		if (session.getAttribute("mno") != null) {
			int mno = (int) session.getAttribute("mno");
			Bookmark bm = bmd.select(dno, mno);
			
			if (bm == null) {
				color = "none";
			} else {
				color = "var(--point-color)";
			}
		} else {
			color = "none";
		}
		
		request.setAttribute("display", dp);
		request.setAttribute("list", list);
		request.setAttribute("star_rate", star_rate);
		request.setAttribute("reviewCnt", reviewCnt);
		request.setAttribute("rvList", rvList);	
		request.setAttribute("color", color);
		
		request.setAttribute("pageNum", pageNum);	
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("currentPage", currentPage);

		return "dpView";
	}

}
