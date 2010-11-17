package net.jsoj.persistence.service;

import java.util.Date;
import java.util.Iterator;
import java.util.logging.Logger;

import net.jsoj.persistence.Datastore;
import net.jsoj.persistence.dao.Category;
import net.jsoj.persistence.dao.Post;

import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.SortDirection;

public class PostService {
	final static Logger logger = Logger.getLogger(PostService.class
			.getName());

	public static Post findById(Long id) {
		return id != null ? Datastore.get().load(Post.class, id) : null;
	}	
	public static boolean save(Post post) {
		return findById(post.getId()) == null ? insert(post)
				: update(post);
	}
	public static boolean insert(Post post) {
		post.setCreated(new Date());
		post.setLastUpdated(post.getCreated());
		return Datastore.get().store(post) != null;
	}
	public static boolean update(Post post) {
		post.setLastUpdated(new Date());
		Datastore.get().associate(post);
		Datastore.get().update(post);
		return findById(post.getId()) != null;
	}
	public static boolean delete(Post post) {
		Datastore.get().delete(post);
		return findById(post.getId()) == null;
	}
	public static Iterator<Post> getAll() {
		return Datastore.get().find().type(Post.class)
				.addSort("created", SortDirection.DESCENDING)
				.now();
	}
	public static Iterator<Post> getNoticeAll() {
		return Datastore.get().find().type(Post.class)
				.addSort("created", SortDirection.DESCENDING)
				.addFilter("category", FilterOperator.EQUAL, Category.Notice.toString())
				.now();
	}	
	public static int getSize() {
		return Datastore.get().find().type(Post.class).returnCount().now();
	}
}