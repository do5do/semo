package service.display;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import dao.ReviewDao;
import model.Review;
import service.CommandProcess;

public class DpReviewWrite implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		int dno = Integer.parseInt(request.getParameter("dno"));
		String content = request.getParameter("content");
		int star_rate = Integer.parseInt(request.getParameter("star_rate"));
		
		// id로 mno 조회
		MemberDao md = MemberDao.getInstance();
		int mno = md.selectMno(id);
		
		// setting
		Review review = new Review();
		review.setContent(content);
		review.setStar_rate(star_rate);
		review.setDno(dno);
		review.setMno(mno);
		
		// review table에 insert
		ReviewDao rd = ReviewDao.getInstance();
		int result = rd.insert(review);
		dno = review.getDno();
		
		request.setAttribute("result", result);
		request.setAttribute("dno", dno);
		
		return "dpReviewWrite"; 
	}

}
