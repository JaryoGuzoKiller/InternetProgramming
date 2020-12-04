package myBean;
import java.sql.*;
public class userDB {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public userDB() {
		try {
			String DB_URL="jdbc:mariadb://localhost:3306/snsboard?useSSL=false";
			Class.forName("org.mariadb.jdbc.Driver");
			con=DriverManager.getConnection(DB_URL,"admin","1234");	
			
		}catch(Exception e) {
			System.out.println(e.toString());
			
		}
	}
	
	public int login(String userId,String userPwd) {
		String sql="SELECT userPwd FROM user WHERE userId=?";
		//해당 아이디의 패스워드를 조회해서 비교한다
		try {
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,userId);
			rs=pstmt.executeQuery();
			if(rs.next()) { //rs가 존재하면
				if(rs.getString(1).equals(userPwd)) {
					//해당 아이디의 비밀번호가 입력한 비밀번호와 일치하면 1을 반환
					return 1;
				}else
					return 0; //일치하지 않음
			}
			return -1;// if문이 실행되지 않음, 아이디 존재x
		}catch(SQLException e) {
			System.out.println(e.toString());
		}catch(Exception e) {
			System.out.println(e.toString());
		}
		return -2;//아무것도 되지 않았을 경우 오류
	}
	public int join(user user) {
		String sql="INSERT INTO user(userId,userPwd) VALUES(?,?)";
		//회원 테이블에 아이디,비밀번호,이름을 삽입한다
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserPwd());
			
			//이미 구성해놓은 myBean.user를 이용해 사용자가 입력한 값을 넣어준다
			return pstmt.executeUpdate();
		}catch(SQLException e) {
			System.out.println(e.toString());
		}catch(Exception e) {
			System.out.println(e.toString());
		}
		return -1;// 실행되지 않았을 경우, 아이디가 중복된 것
	}
}
