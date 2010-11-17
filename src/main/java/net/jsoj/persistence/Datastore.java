package net.jsoj.persistence;

import com.google.code.twig.ObjectDatastore;
import com.google.code.twig.annotation.AnnotationObjectDatastore;

public final class Datastore {
	private static final ObjectDatastore datastore = new AnnotationObjectDatastore();

	private Datastore() {}

	public static ObjectDatastore get() {
		return datastore;
	}
}
