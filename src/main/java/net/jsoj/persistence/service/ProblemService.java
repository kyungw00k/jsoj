package net.jsoj.persistence.service;

import java.util.Date;
import java.util.Iterator;
import java.util.logging.Logger;

import net.jsoj.persistence.Datastore;
import net.jsoj.persistence.dao.Member;
import net.jsoj.persistence.dao.Problem;
import net.jsoj.persistence.dao.ProblemStatus;

import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.SortDirection;

public class ProblemService {
	final static Logger logger = Logger.getLogger(ProblemService.class.getName());
	
	public static boolean save(Problem problem) {
		return findById(problem.getId()) == null
			?	insert(problem)
			:	update(problem, false);
	}
	
	public static boolean insert(Problem problem) {
		if ( problem.getCreatedBy() == null ) {
			logger.warning("No User");
			return false;
		}
		problem.setCreated(new Date());
		problem.setLastUpdated(problem.getCreated());
		problem.setId(problem.getId().trim().toUpperCase());
		if ( problem.getTestFuncName() == null ) {
			problem.setTestFuncName("main");
		}
		return Datastore.get().store(problem) != null;
	}
	
	public static boolean update(Problem problem, boolean isAdmin) {
		problem.setLastUpdated(new Date());
		if ( !isAdmin ) {
			try{
				Datastore.get().associate(problem);
			} catch (Exception e) {
				logger.warning(e.getMessage());
			}
		}
		Datastore.get().update(problem);
		return findById(problem.getId()) != null;
	}
	
	public static boolean delete(Problem problem) {
		Datastore.get().delete(problem);
		return findById(problem.getId()) == null;
	}

	public static Problem findById(String id) {
		Problem entity = null;
		if ( id != null ) {
			entity = Datastore.get().load(Problem.class, id);
		}
		return entity;
	}

	public static Iterator<Problem> findByMember(Member member) {
		return Datastore.get().find().type(Problem.class)
			.addFilter("createBy", Query.FilterOperator.EQUAL, member).now();
	}
	
	public static Iterator<Problem> getAll() {
		return Datastore.get().find().type(Problem.class)
			.addFilter("status", Query.FilterOperator.EQUAL, ProblemStatus.Accepted.toString() )
			.addSort("created", SortDirection.DESCENDING)
			.now();
	}

	public static Iterator<Problem> getAll(Integer itemsPerPage, Integer pageCount ) {
		if ( getSize() > itemsPerPage*(pageCount-1) ) {
			
		}
		return Datastore.get().find().type(Problem.class)
			.addFilter("status", Query.FilterOperator.EQUAL, ProblemStatus.Accepted.toString() )
			.addSort("created", SortDirection.DESCENDING)
			.startFrom(itemsPerPage*(pageCount-1))
			.now();
	}

	public static Iterator<Problem> getAllByStatus(ProblemStatus status) {
		return Datastore.get().find().type(Problem.class)
			.addFilter("status", Query.FilterOperator.EQUAL, status.toString())
			.addSort("created", SortDirection.DESCENDING)
			.now();		
	}
	public static Iterator<Problem> getAllByAccoundId(Long accountId) {
		return Datastore.get().find().type(Problem.class)
			.addFilter("accountId", FilterOperator.EQUAL, accountId)
			.addSort("created", SortDirection.DESCENDING)
			.now();
	}

	public static Iterator<Problem> getRecentPendingLists() {
		return Datastore.get().find().type(Problem.class)
			.addFilter("status", Query.FilterOperator.NOT_EQUAL, ProblemStatus.Accepted.toString() )
			.now();
	}

	public static Iterator<Problem> getRecentProblems() {
		return Datastore.get().find().type(Problem.class)
			.addSort("created", SortDirection.DESCENDING)
			.now();
	}

	public static int getSize() {
		return Datastore.get().find().type(Problem.class).returnCount().now();
	}
}