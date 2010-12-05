package net.jsoj.persistence.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.concurrent.Future;
import java.util.logging.Logger;

import net.jsoj.persistence.Datastore;
import net.jsoj.persistence.dao.Member;
import net.jsoj.persistence.dao.Problem;
import net.jsoj.persistence.dao.Rank;
import net.jsoj.persistence.dao.Submission;
import net.jsoj.persistence.dao.SubmissionStatus;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.SortDirection;
import com.google.appengine.api.datastore.QueryResultIterator;
import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.taskqueue.TaskHandle;
import com.google.appengine.api.taskqueue.TaskOptions;
import com.google.appengine.api.taskqueue.TaskOptions.Method;

public class SubmissionService {
	final static Logger logger = Logger.getLogger(SubmissionService.class.getName());

	public static Future<QueryResultIterator<Submission>> lists = Datastore
			.get().find().type(Submission.class)
			.addSort("id", SortDirection.DESCENDING).later();

	public static Submission findById(Long id) {
		Submission submission = Datastore.get().load(Submission.class, id);
		return submission;
	}

	public static Submission findById(Key key) {
		Submission submission = Datastore.get().load(Submission.class, key);
		return submission;
	}

	public static void save(Submission submission) {
		if (findById(submission.getId()) == null) {
			insert(submission);
		} else {
			update(submission);
		}
	}

	public static Key insert(Submission submission) {
		submission.setId(new Long(getSize() + 1));
		submission.setCreated(new Date());
		submission.setLastUpdated(submission.getCreated());
		return Datastore.get().store(submission);
	}

	public static boolean update(Submission submission) {
		submission.setLastUpdated(new Date());
		Datastore.get().update(submission);
		return findById(submission.getId()) != null;
	}

	public static boolean delete(Submission submission) {
		Datastore.get().delete(submission);
		return findById(submission.getId()) == null;
	}

	public static Iterator<Submission> getAll() {
		return Datastore.get().find().type(Submission.class)
				.addSort("created", SortDirection.DESCENDING)
				.now();
	}

	public static Iterator<Submission> getAllByAccountId(Long accountId) {
		return Datastore.get().find().type(Submission.class)
				.addSort("created", SortDirection.DESCENDING)
				.addFilter("accountId", FilterOperator.EQUAL, accountId)
				.now();
	}

	public static HashMap<Problem, HashMap<String, Double>> getAcceptedByAccountId(Long accountId) {
		Iterator<Submission> results = Datastore.get().find().type(Submission.class)
		.addFilter("status", FilterOperator.EQUAL, SubmissionStatus.Accepted.toString() )
		.addFilter("accountId", FilterOperator.EQUAL, accountId)
		.now();
		
		HashMap<Problem, HashMap<String, Double>> solved =  new HashMap<Problem, HashMap<String, Double>>();
		
		while (results.hasNext()) {
			Submission submission = results.next();
			HashMap<String,Double> records = new HashMap<String,Double>();
			records.put("runtime", submission.getExecutionTime());
			Problem problem = ProblemService.findById(submission.getProblemId());
			
			if ( solved.get(problem) == null ) {
				solved.put(problem,records );
			} else {
				HashMap<String,Double> temp = solved.get(problem);
				Double value = temp.get("runtime");
				if ( value != null && ( submission.getExecutionTime() > value ) ) {
					solved.put(problem,records );
				}
			}
		}
		
		return solved;
	}
	
	public static Iterator<Submission> getAllByProblemId(String problemId) {
		return Datastore.get().find().type(Submission.class)
				.addFilter("problemId", FilterOperator.EQUAL, problemId)
				.now();
	}

	public static Iterator<Submission> getAllByStatus(SubmissionStatus status) {
		return Datastore.get().find().type(Submission.class)
				.addFilter("status", FilterOperator.EQUAL, status.toString())
				.now();
	}

	public static HashMap<String, Integer> getStatusByAccountId(Long accountId) {
		Iterator<Submission> submissions = getAllByAccountId(accountId);
		HashMap<String, Integer> results = new HashMap<String, Integer>();
		int totalCount = 0;

		for ( SubmissionStatus status : SubmissionStatus.values() ) {
			results.put(status.toString(), 0);
		}
		while ( submissions.hasNext() ) {
			Submission submission = submissions.next();
			String key = submission.getStatus().toString();
			results.put(key, results.get(key)+1);
			totalCount++;
		}
		results.put("solved" , getAcceptedByAccountId(accountId).size() );
		results.put("total",totalCount);
		return results;
	}
	
	public static ArrayList< Rank > getRankLists(Iterator<Member> members) {
		Member member = null;
		HashMap<String, Integer> statistic = null;
		ArrayList<Rank> rankLists = new ArrayList<Rank>();
		
		while ( members.hasNext() ) {
			member = members.next();
			statistic = SubmissionService.getStatusByAccountId(member.getAccountId());
			rankLists.add( new Rank(member.getNickName(), statistic.get("solved"), statistic.get("Accepted"), statistic.get("total")) );
		}
		Collections.sort(rankLists);
		return rankLists;
	}
	
	public static HashMap<String, Integer> getStatusByProblemId(String problemId) {
		Iterator<Submission> submissions = getAllByProblemId(problemId);
		HashMap<String, Integer> results = new HashMap<String, Integer>();
		int totalCount = 0;
		for ( SubmissionStatus status : SubmissionStatus.values() ) {
			results.put(status.toString(), 0);
		}
		while ( submissions.hasNext() ) {
			Submission submission = submissions.next();
			Problem problem = ProblemService.findById(submission.getProblemId());
			if ( problem != null && submission.getProblemId().equals(problem.getId()) ) {
				String key = submission.getStatus().toString();
				results.put(key, results.get(key)+1);
				totalCount++;
			}
		}
		results.put("total",totalCount);
		return results;
	}
	
	public static int getSize() {
		return Datastore.get().find().type(Submission.class).returnCount().now();
	}
	
	public static boolean reStartStandByQueueing(SubmissionStatus status) {
		Iterator<Submission> submissions = getAllByStatus(status);
		Submission submission = null;
		TaskHandle th = null;
		Queue queue = null;
		while (submissions.hasNext()) {
			submission = submissions.next();
			for ( int queueIndex = 0 ; queueIndex < 10 && th == null ; queueIndex++ ) {
				queue = QueueFactory.getQueue("submission-queue-"+queueIndex);
				try {
					th = queue.add(TaskOptions.Builder
							.withUrl("/submission/" + submission.getId())
							.method(Method.PUT).countdownMillis(2000));
				} catch(Exception e) {
					logger.warning(e.getMessage());
				}
			}
		}
		return true;
	}

}