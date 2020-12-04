package myBoard;
import java.sql.*;
public class boardDB {
	private Connection con;
	private ResultSet rs;
	public boardDB() {
		try {
			String DB_URL="jdbc:mariadb://localhost:3306/snsboard?useSSL=false";
			Class.forName("org.mariadb.jdbc.Driver");
			con=DriverManager.getConnection(DB_URL,"admin","1234");	
		}catch(Exception e) {
			System.out.println(e.toString());	
		}
	}
	public int write(String boardTitle,String userId,String boardContent) {
		String sql="INSERT INTO board(boardTitle, userId, boardDate, boardContent) VALUES(?,?,NOW(),?)";
		//사용자가 입력한 게시물 제목,아이디,내용을 board 테이블에 삽입한다.
		try {
			PreparedStatement pstmt=con.prepareStatement(sql);
			pstmt.setString(1,boardTitle);
			pstmt.setString(2,userId);
			pstmt.setString(3,boardContent);
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println(e.toString());
		}
		return -1; //db오류
	}
	public int saveImagePath(int boardId, String url) {
		String sql = "INSERT INTO images(boardId, url) VALUES(?,?)";
			//images 테이블에 해당 게시물id와 사진경로명을 같이 삽입한다
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardId);
			pstmt.setString(2, url);

			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.toString());
		}
		return -1;//실패
	}

	public int getRecentBoardIdx(String userId) {
		String sql = "SELECT boardId FROM board WHERE userId=? ORDER BY boardDate DESC LIMIT 1";
			//boardId를 갖고 오기 위해 사용자 아이디를 이용해 date기준으로 정렬해서 조회한다
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();
			int boardIdx = -1;
			if (rs.next()) {
				if (rs.getInt(1) != 0) {
					boardIdx = rs.getInt(1);
				}
			}
			return boardIdx;
		} catch (SQLException e) {
			System.out.println(e.toString());
		}
		return -1;//db 오류
	}
		public int update(int boardId,String boardTitle,String boardContent) {
			String sql="UPDATE board SET boardTitle=?,boardContent=? WHERE boardId=?";
				//해당 게시물의 제목,내용을 수정하는 문장이다
			try {
				PreparedStatement pstmt=con.prepareStatement(sql);
				pstmt.setString(1,boardTitle);
				pstmt.setString(2,boardContent);
				pstmt.setInt(3,boardId);
				
				return pstmt.executeUpdate();
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			return -1; //db 오류
		}
}
