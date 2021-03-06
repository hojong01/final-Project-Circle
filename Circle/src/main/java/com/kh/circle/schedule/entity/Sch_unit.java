package com.kh.circle.schedule.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Sch_unit {
	private String SCH_UNIT_CODE, SCH_UNIT_NAME, SCH_UNIT_RPT;
	private String SCH_UNIT_ERPT;
	private String SCH_UNIT_ADAY;
	private String SCH_UNIT_CONT;
	private String SCH_UNIT_SEC;
	private String SCH_UNIT_STAT;
	private String SCH_UNIT_EMP;
	private Date SCH_UNIT_SDAT,SCH_UNIT_EDAT,SCH_UNIT_WDAT,SCH_UNIT_MDAT;
	
}











