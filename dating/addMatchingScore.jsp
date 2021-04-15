<%@ page contentType="application/json; charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.*"%>

<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
%>

<%
	// support Korean
	request.setCharacterEncoding("euc-kr");

	// get current user info
	String ID = request.getParameter("ID");
	String age = request.getParameter("age");
	String ageRange = request.getParameter("ageRange");
	String prefAge = request.getParameter("prefAge");
	String prefAgeRange = request.getParameter("prefAgeRange");
	String latitude = request.getParameter("latitude");
	String longitude = request.getParameter("longitude");
	String prefDistance = request.getParameter("distance");
	String drink = request.getParameter("drink");
	String smoke = request.getParameter("smoke");
	String religion = request.getParameter("religion");
	String hobby = request.getParameter("hobby");
	String priority = request.getParameter("priority");
	
	// get matched user info 
	String matchedUser = request.getParameter("matchedUserID");
	String matchedAge = request.getParameter("matchedAge");
	String matchedAgeRange = request.getParameter("matchedAgeRange");
	String matchedLatitude = request.getParameter("matchedLatitude");
	String matchedLongitude = request.getParameter("matchedLongitude");
	String matchedDrink = request.getParameter("matchedDrink");
	String matchedSmoke = request.getParameter("matchedSmoke");
	String matchedReligion = request.getParameter("matchedReligion");
	String matchedHobby = request.getParameter("matchedHobby");
	
	// age variables
	Integer currentUserAge = 0;
	Integer matchedUserAge = 0;
	Integer maxAgeRange = 0;
	Integer maxPrefAgeRange = 0;
	Integer maxMatchedAgeRange = 0;
	Integer prefAgeInt = 0;
	Integer ageDiff = 0;
	
	// distance variables
	double lat1 = 0;
	double lon1 = 0;
	double lat2 = 0;
	double lon2 = 0;
	double latDistance = 0;
	double lonDistance = 0;
	double a = 0;
	double c = 0;
	double distance = 0;
	double idealDist = 0;
	double avgEarthRadius = 6371;
	double distanceDiff = 0;
	
	// score variables
	Integer ageScore = 0;
	Integer distanceScore = 0;
	Integer drinkScore = 0;
	Integer smokeScore = 0;
	Integer religionScore = 0;
	Integer hobbyScore = 0;
	Integer total = 0;
	
	// final variables
	String finalUserAge = "";
	String finalMatchingAge = "";
	String finalAgeDiff = "";
	String finalAgeScore = "";
	String finalDistance = "";
	String finalDistanceScore = "";
	String finalDrinkScore = "";
	String finalSmokeScore = "";
	String finalReligionScore = "";
	String finalHobbyScore = "";
	String strTotal = "";

	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg = "";
%>

<%=matchedUser%>

<!-- calculate distance difference -->
<%
	// change lat, lon string to double
	lat1 = Double.parseDouble(latitude);
	lon1 = Double.parseDouble(longitude);
	lat2 = Double.parseDouble(matchedLatitude);
	lon2 = Double.parseDouble(matchedLongitude);
	latDistance = Math.toRadians(lat1 - lat2);
	lonDistance = Math.toRadians(lon1 - lon2);

	a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
	  + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
	  * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);

	c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	distance = (Math.round(avgEarthRadius * c));
%>

<%=distance%>

<%
	// matching distance => current user's preference distance
	distanceDiff = Double.parseDouble(prefDistance);
	if (priority.equals("D")){
		if (distance <= distanceDiff){
		distanceScore = 250;
		}	
		else {
			distanceScore = 200;
		}
	}
	else {
		if (distance <= distanceDiff){
		distanceScore = 150;
		}	
		else {
			distanceScore = 100;
		}
	}
	
	finalDistance = Double.toString(distance);
	finalDistanceScore = Integer.toString(distanceScore);
%>

<%=finalDistance%>
<%=finalDistanceScore%>

<!-- get a max age of currentUser -->
<%
	if (ageRange.equals("early")){
		maxAgeRange = 3;	// 23 
	}
	else if (ageRange.equals("mid")){
		maxAgeRange = 6;	// 26
	}
	else {
		maxAgeRange = 9;	// 29
	}
%>

<%=maxAgeRange%>

<!-- get a max age of prefAgeRange -->
<%
	if (prefAgeRange.equals("early")){
		maxPrefAgeRange = 3;	// 23 
	}
	else if (prefAgeRange.equals("mid")){
		maxPrefAgeRange = 6;	// 26
	}
	else {
		maxPrefAgeRange = 9;	// 29
	}
%>

<!-- get a max age of matchedAge -->
<%
	if (matchedAgeRange.equals("early")){
		maxMatchedAgeRange = 3;	// 23 
	}
	else if (matchedAgeRange.equals("mid")){
		maxMatchedAgeRange = 6;	// 26
	}
	else {
		maxMatchedAgeRange = 9;	// 29
	}
%>


<%
	// convert age string to int 
	currentUserAge = Integer.parseInt(age) + maxAgeRange;
	prefAgeInt = Integer.parseInt(prefAge) + maxPrefAgeRange;
	matchedUserAge = Integer.parseInt(matchedAge) + maxMatchedAgeRange;
	finalUserAge = Integer.toString(currentUserAge);
%>

<%=currentUserAge%>
<%=finalUserAge%>
<%=prefAgeInt%>
<%=matchedUserAge%>

<%
	if (priority.equals("A")) {
		if (matchedUserAge <= currentUserAge) {
			matchedAge = Integer.toString(matchedUserAge);
			finalMatchingAge = matchedAge;
			ageDiff = currentUserAge - matchedUserAge;
			ageScore = 200;
		}
		else if (matchedUserAge > prefAgeInt) {
			matchedAge = Integer.toString(matchedUserAge);
			finalMatchingAge = matchedAge;
			ageDiff = matchedUserAge - currentUserAge;
			ageScore = 200;	
		}
		else if (currentUserAge <= matchedUserAge || matchedUserAge <= prefAgeInt) {
			matchedAge = Integer.toString(matchedUserAge);
			finalMatchingAge = matchedAge;
			ageDiff = matchedUserAge - currentUserAge;
			ageScore = 250;	
		}
	}
	else {
		if (matchedUserAge <= currentUserAge) {
			matchedAge = Integer.toString(matchedUserAge);
			finalMatchingAge = matchedAge;
			ageDiff = currentUserAge - matchedUserAge;
			ageScore = 100;
		}
		else if (matchedUserAge > prefAgeInt) {
			matchedAge = Integer.toString(matchedUserAge);
			finalMatchingAge = matchedAge;
			ageDiff = matchedUserAge - currentUserAge;
			ageScore = 100;	
		}
		else if (currentUserAge <= matchedUserAge || matchedUserAge <= prefAgeInt) {
			matchedAge = Integer.toString(matchedUserAge);	
			finalMatchingAge = matchedAge;
			ageDiff = matchedUserAge - currentUserAge;
			ageScore = 150;	
		}
	}
	finalAgeDiff = Integer.toString(ageDiff);
	finalAgeScore = Integer.toString(ageScore);
%>

<%=finalMatchingAge%>
<%=finalAgeDiff%>
<%=finalAgeScore%>

<!-- drink score -->
<%
	if (priority.equals("DR")){
		if (drink.equals(matchedDrink)){	 
			drinkScore = 250;
		}
		else {
			drinkScore = 200;
		}
	}
	else {
		if (drink.equals(matchedDrink)){	 
			drinkScore = 150;
		}
		else {
			drinkScore = 100;
		}
	}
	finalDrinkScore = Integer.toString(drinkScore);
%>

<%=finalDrinkScore %>

<!-- smoke score -->
<%
	if (priority.equals("S")){
		if (smoke.equals(matchedSmoke)){	
			smokeScore = 250;
		}
		else {
			smokeScore = 200;
		}
	}
	else {
		if (smoke.equals(matchedSmoke)){	
			smokeScore = 150;
		}
		else {
			smokeScore = 100;
		}
	}
	finalSmokeScore = Integer.toString(smokeScore);
%>

<%=finalSmokeScore%>

<!-- religion score -->
<%
	if (priority.equals("R")) {
		if (religion.equals(matchedReligion)){	 
			religionScore = 250;
		}
		else {
			religionScore = 200;
		}
	}
	else {
		if (religion.equals(matchedReligion)){	 
			religionScore = 150;
		}
		else {
			religionScore = 100;
		}
	}
	finalReligionScore = Integer.toString(religionScore);
%>

<%=finalReligionScore%>

<!-- hobby score -->
<%
	if (priority.equals("H")) {
		if (hobby.equals(matchedHobby)){	 
			hobbyScore = 250;
		}
		else {
			hobbyScore = 200;
		}
	}
	else {
		if (hobby.equals(matchedHobby)){	 
			hobbyScore = 150;
		}
		else {
			hobbyScore = 100;
		}
	}
	finalHobbyScore = Integer.toString(hobbyScore);
%>

<%=finalHobbyScore%>

<!-- calculate total --> 
<%
	total = ageScore + distanceScore + drinkScore + smokeScore + religionScore + hobbyScore;
	strTotal = Integer.toString(total);
%>

<%=strTotal%>

<%
	try {
%>
		<%@ include file="../include/dbOpen.inc" %>
    <%
		sql = "INSERT INTO datingMatching(currentUser, matchingUser, currentUserAge, matchingAge, ageDiff, ageScore, matchingDistance, distanceScore, drinkScore, smokeScore, religionScore, hobbyScore, total) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);	
		pstmt.setString(1, ID); 				
		pstmt.setString(2, matchedUser); 
		pstmt.setString(3, finalUserAge);
		pstmt.setString(4, finalMatchingAge); 
		pstmt.setString(5, finalAgeDiff); 
		pstmt.setString(6, finalAgeScore); 
		pstmt.setString(7, finalDistance); 
		pstmt.setString(8, finalDistanceScore); 
		pstmt.setString(9, finalDrinkScore);
		pstmt.setString(10, finalSmokeScore); 
		pstmt.setString(11, finalReligionScore);
		pstmt.setString(12, finalHobbyScore);
		pstmt.setString(13, strTotal); 					
		pstmt.executeUpdate();
	} catch(SQLException e) {
		rst = "System Error";
		msg = e.getMessage();
	} finally {
		if(rs != null) 
			rs.close();
		if(pstmt != null) 
			pstmt.close();
		if(conn != null) 
			conn.close();
	}
%>

