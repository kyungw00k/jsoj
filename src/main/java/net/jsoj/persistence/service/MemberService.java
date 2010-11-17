package net.jsoj.persistence.service;

import java.util.Date;
import java.util.Iterator;
import java.util.logging.Logger;

import net.jsoj.persistence.Datastore;
import net.jsoj.persistence.dao.Member;

import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.SortDirection;

public class MemberService {
	final static Logger logger = Logger.getLogger(MemberService.class.getName());
	
	public static Member findById(Long accountId) {
		Member member = Datastore.get().load(Member.class, accountId);
		return member;
	}

	public static Member findByNickName(String nickName) {
		Iterator<Member> members = Datastore.get()
									.find()
									.type(Member.class)
									.addFilter("nickName", Query.FilterOperator.EQUAL, nickName)
									.now();
		Member member = null;
		int testCount = 0;
		while (members.hasNext()) {
			if ( testCount > 1 ) {
				break;
			}
			member = members.next();
			++testCount;
		}
		return testCount == 1 ? member : null;
	}
	public static boolean save(Member member) {
		return findById(member.getAccountId()) == null ? insert(member) : update(member);
	}

	public static boolean insert(Member member) {
		member.setCreated(new Date());
		member.setLastUpdated(member.getCreated());
		return Datastore.get().store(member) != null;
	}

	private static boolean update(Member member) {
		member.setLastUpdated(new Date());
		Datastore.get().update(member);
		return findById(member.getAccountId()) != null;
	}

	public static boolean delete(Member member) {
		Datastore.get().delete(member);
		return findById(member.getAccountId()) == null;
	}

	public static int getSize() {
		return Datastore.get().find().type(Member.class).returnCount().now();
	}

	public static Iterator<Member> getAll() {
		return Datastore.get().find().type(Member.class)
			.addSort("created", SortDirection.ASCENDING)
			.now();
	}
	
}