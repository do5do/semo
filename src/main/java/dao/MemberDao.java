package dao;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import model.Member;

public class MemberDao {
	private static MemberDao instance = new MemberDao();
	private MemberDao() {
	}
	 
	public static MemberDao getInstance() {
		return instance;
	}

	private static SqlSession session;
		static {
			try {
				Reader reader = Resources.getResourceAsReader("configuration.xml");
				SqlSessionFactory ssf = new SqlSessionFactoryBuilder().build(reader);
				session = ssf.openSession(true);
				reader.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		// joinResult, IdConfirm, LoginResult
		public Member select(String id) {
			return (Member) session.selectOne("memberns.select", id);
		}
		
		// confirmNick_nm
		public Member confirmNick(String nick_nm) {
			return (Member) session.selectOne("memberns.confirmNick", nick_nm);
		}
		
		// joinResult
		public int insert(Member member) {			
			return session.insert("memberns.insert", member);
		}
		
		// FindIdResult
		public Member findId(String name, String phone) {
			HashMap<String, String> hm = new HashMap<String, String>();
			hm.put("name", name);
			hm.put("phone", phone);
			return (Member) session.selectOne("memberns.findId", hm);
		}
		
		// FindPwResult
		public Member findPassword(String id, String name) {
			HashMap<String, String> hm = new HashMap<String, String>();
			hm.put("id", id);
			hm.put("name", name);
			return (Member) session.selectOne("memberns.findPassword", hm);
		}
		
		// UpdateResult
		public int update(Member member) {
			System.out.println(member.getPassword()+ member.getName()+ member.getNick_nm()+ member.getPhone()+ member.getGender()+ member.getLoc()+ member.getAge()+ member.getProfile() );
			return session.update("memberns.update", member);
		}
		
		// MyMain
		public String selectNick(String id) {
			// TODO Auto-generated method stub
			return null;
		}
		
		// MyMain
		public String profile(String id) {
			// TODO Auto-generated method stub
			return null;
		}

		// Delete
		public int delete(String id) {
			return session.update("memberns.delete", id);
		}
		
		//AdminMember
		public List<Member> list() {
			return (List<Member>)session.selectList("memberns.list");
		}
		
		// 다른 테이블에서 회원번호를 활용한 닉네임 찾기
		public String selectNick(int mno) {
			return (String) session.selectOne("memberns.selectNick", mno);
		}
		
		// 다른 테이블에서 세션 아이디를 활용한 회원번호 찾기
		public int selectMno(String id) {
			return (int) session.selectOne("memberns.selectMno", id);
		}
		
		// mno로 회원 정보 조회
		public Member select(int mno) {
			return (Member) session.selectOne("memberns.selectReserve", mno);
		}




}
