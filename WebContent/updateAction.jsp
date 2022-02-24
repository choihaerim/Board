<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 파일을 UTF-8로 -->
 
<!DOCTYPE html>
<html >
<head >
    <meta http-equiv="Content-Type" content="test/html, charset=UTF-8">
    <title >JSP 게시판 웹 사이트</title >
</head >
<body >
<%
    String userID = null;
    if(session.getAttribute("userID")!=null){
        userID = (String)session.getAttribute("userID");
    }
    if(userID == null){
        PrintWriter script = response.getWriter();
        script.println("<script> alert('로그인이 필요합니.'); location.href = 'login.jsp' </script>");
    }
    int bbsID = 0;
    if(request.getParameter("bbsID") != null){
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if (bbsID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script> alert('유효하지 않은 글입니다.'); location.href = 'bbs.jsp' </script>");
    }
    Bbs bbs = new BbsDAO().getBbs(bbsID);
    if(!userID.equals(bbs.getUserID())){
        PrintWriter script = response.getWriter();
        script.println("<script> alert('권한이 없습니다.'); location.href = 'bbs.jsp' </script>");
    } else {
        if(request.getParameter("bbsTitle")==null || request.getParameter("bbsContent")==null || request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")){
            PrintWriter script = response.getWriter();
            script.println("<script> alert('입력이 모두 되지 않았습니다.'); history.back(); </script>");
        } else{
        	BbsDAO bbsDAO = new BbsDAO();
            int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
            if(result < 0){
                PrintWriter script = response.getWriter();
                script.println("<script> alert('글 수정에 실패했습니다.'); history.back(); </script>");
            } else {
                PrintWriter script = response.getWriter();
                script.println("<script> location.href='bbs.jsp' </script>");
            }
        }
    }
%>
</body >
</html >