package com.kh.circle.attendance.repository;

import java.util.List;
import java.util.Map;

import com.kh.circle.attendance.entity.AttendanceInfo;
import com.kh.circle.attendance.entity.WeekStackInfo;

public interface AttendanceInfoRepository {
	public List<AttendanceInfo> attendanceList(Map<String, Object> inputMap);
	
	public int worktimePerWeek(String emp_no);
	
	public WeekStackInfo weekStackWorkTime(Map<String, Object> inputMap);
}