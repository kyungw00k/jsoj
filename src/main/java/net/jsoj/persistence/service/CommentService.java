package net.jsoj.persistence.service;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Logger;

import net.jsoj.persistence.Datastore;
import net.jsoj.persistence.dao.Comment;

import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.SortDirection;

public class CommentService {
	final static Logger logger = Logger.getLogger(CommentService.class
			.getName());

	public static Comment findById(Long id) {
		return id != null ? Datastore.get().load(Comment.class, id) : null;
	}
	
	public static boolean save(Comment comment) {
		return findById(comment.getId()) == null ? insert(comment)
				: update(comment);
	}

	public static boolean insert(Comment comment) {
		comment.setCreated(new Date());
		comment.setLastUpdated(comment.getCreated());
		return Datastore.get().store(comment) != null;
	}

	private static boolean update(Comment comment) {
		comment.setLastUpdated(new Date());
		Datastore.get().update(comment);
		return findById(comment.getId()) != null;
	}

	public static boolean delete(Comment comment) {
		Datastore.get().delete(comment);
		return findById(comment.getId()) == null;
	}

	public static List<Comment> getByOwnerId(String id) {
		return Datastore.get().find().type(Comment.class)
				.addSort("created", SortDirection.DESCENDING)
				.addFilter("pid", FilterOperator.EQUAL, id)
				.returnAll().now();
	}
	
	public static int getSizeByOwnerId(String id) {
		return Datastore.get().find().type(Comment.class).addFilter("pid", FilterOperator.EQUAL, id).returnCount().now();
	}
	
	public static Iterator<Comment> getAll() {
		return Datastore.get().find().type(Comment.class)
				.addSort("created", SortDirection.DESCENDING)
				.now();
	}

	public static int getSize() {
		return Datastore.get().find().type(Comment.class).returnCount().now();
	}
}