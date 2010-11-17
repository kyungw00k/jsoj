package net.jsoj.persistence.dao;

import java.util.Date;

import com.google.appengine.api.datastore.Text;
import com.google.code.twig.annotation.Key;
import com.google.code.twig.annotation.Type;

/*
 * TODO : Runs Status
 * TODO : Rank List
 * TODO : Statistics
 * TODO : Clarifications
 */
public class Contest { 
	@Key
	private Long id;

	private String title;

	@Type(Text.class)
	private String description;

	private Date startTime; // ( YYYY-MM-DD HH:MM:SS, [UTC+8] )
	private Date endTime;   // (30 minutes ��length ��2 days)

	private Long accountId;

	private Date created;
	private Date lastUpdated;

	// Contest Problems
	private String problem_A;
	private String problem_B;
	private String problem_C;
	private String problem_D;
	private String problem_E;
	private String problem_F;
	private String problem_G;
	private String problem_H;
	private String problem_I;
	private String problem_J;
	private String problem_K;
	private String problem_L;
	private String problem_M;
	private String problem_N; 
}
