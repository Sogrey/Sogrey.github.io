---
title: Java读取文件夹大小的6种方法（收集）
categories: Java
date: 2017-12-19 15:04:22
tags: [Java]
---

> 说明：File.length()仅仅用于获得某个文件的大小，单位为bytes
>
> 以下提供六种方法遍历文件夹下子文件求其大小总和。

<!-- more -->

### 单线程递归方式

``` java

import java.io.File;
public class TotalFileSize {
	public static String fileName = "C:\\Users\\Administrator\\Desktop\\1_11";
	
    // 递归方式 计算文件的大小
    private long getTotalSizeOfFilesInDir(final File file) {
        if (file.isFile())
            return file.length();
        final File[] children = file.listFiles();
        long total = 0;
        if (children != null)
            for (final File child : children)
                total += getTotalSizeOfFilesInDir(child);
        return total;
    }
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		final long start = System.nanoTime();
        final long total = new TotalFileSize()
                .getTotalSizeOfFilesInDir(new File(fileName));
        final long end = System.nanoTime();
        System.out.println("Total Size: " + total);
        System.out.println("Time taken: " + (end - start) / 1.0e9);
	}

}

```

计算结果：

	Total Size: 59597673
	Time taken: 0.02347729

### 使用Executors.newFixedThreadPool和callable 多线程实现


``` java

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

public class ConcurrentTotalFileSize {
	public static final String fileName = "C:\\Users\\Administrator\\Desktop\\1_11";

	class SubDirectoriesAndSize {
		final public long size;
		final public List<File> subDirectories;

		public SubDirectoriesAndSize(final long totalSize,
				final List<File> theSubDirs) {
			size = totalSize;
			subDirectories = Collections.unmodifiableList(theSubDirs);
		}
	}

	private SubDirectoriesAndSize getTotalAndSubDirs(final File file) {
		long total = 0;
		final List<File> subDirectories = new ArrayList<File>();
		if (file.isDirectory()) {
			final File[] children = file.listFiles();
			if (children != null)
				for (final File child : children) {
					if (child.isFile())
						total += child.length();
					else
						subDirectories.add(child);
				}
		}
		return new SubDirectoriesAndSize(total, subDirectories);
	}

	private long getTotalSizeOfFilesInDir(final File file)
			throws InterruptedException, ExecutionException, TimeoutException {
		final ExecutorService service = Executors.newFixedThreadPool(100);
		try {
			long total = 0;
			final List<File> directories = new ArrayList<File>();
			directories.add(file);
			while (!directories.isEmpty()) {
				final List<Future<SubDirectoriesAndSize>> partialResults = new ArrayList<Future<SubDirectoriesAndSize>>();
				for (final File directory : directories) {
					partialResults.add(service
							.submit(new Callable<SubDirectoriesAndSize>() {
								public SubDirectoriesAndSize call() {
									return getTotalAndSubDirs(directory);
								}
							}));
				}
				directories.clear();
				for (final Future<SubDirectoriesAndSize> partialResultFuture : partialResults) {
					final SubDirectoriesAndSize subDirectoriesAndSize = partialResultFuture
							.get(100, TimeUnit.SECONDS);
					directories.addAll(subDirectoriesAndSize.subDirectories);
					total += subDirectoriesAndSize.size;
				}
			}
			return total;
		} finally {
			service.shutdown();
		}
	}

	public static void main(final String[] args) throws InterruptedException,
			ExecutionException, TimeoutException {
		final long start = System.nanoTime();
		final long total = new ConcurrentTotalFileSize()
				.getTotalSizeOfFilesInDir(new File(fileName));
		final long end = System.nanoTime();
		System.out.println("Total Size: " + total);
		System.out.println("Time taken: " + (end - start) / 1.0e9);
	}
}

```

计算结果：

	Total Size: 59597673
	Time taken: 0.102727254

### 使用Executors.newFixedThreadPool和callable 多线程的另外一种实现

``` java
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

public class NaivelyConcurrentTotalFileSize {
	public static String fileName = "C:\\Users\\Administrator\\Desktop\\1_11";

	private long getTotalSizeOfFilesInDir(final ExecutorService service,
			final File file) throws InterruptedException, ExecutionException,
			TimeoutException {
		if (file.isFile())
			return file.length();
		long total = 0;
		final File[] children = file.listFiles();
		if (children != null) {
			final List<Future<Long>> partialTotalFutures = new ArrayList<Future<Long>>();
			for (final File child : children) {
				partialTotalFutures.add(service.submit(new Callable<Long>() {
					public Long call() throws InterruptedException,
							ExecutionException, TimeoutException {
						return getTotalSizeOfFilesInDir(service, child);
					}
				}));
			}
			for (final Future<Long> partialTotalFuture : partialTotalFutures)
				total += partialTotalFuture.get(100, TimeUnit.SECONDS);
		}
		return total;
	}

	private long getTotalSizeOfFile(final String fileName)
			throws InterruptedException, ExecutionException, TimeoutException {
		final ExecutorService service = Executors.newFixedThreadPool(100);
		try {
			return getTotalSizeOfFilesInDir(service, new File(fileName));
		} finally {
			service.shutdown();
		}
	}

	public static void main(final String[] args) throws InterruptedException,
			ExecutionException, TimeoutException {
		final long start = System.nanoTime();
		final long total = new NaivelyConcurrentTotalFileSize()
				.getTotalSizeOfFile(fileName);
		final long end = System.nanoTime();
		System.out.println("Total Size: " + total);
		System.out.println("Time taken: " + (end - start) / 1.0e9);
	}
}

```

计算结果：

	Total Size: 59597673
	Time taken: 0.058243242

### 使用CountDownLatch和AtomicLong实现多线程下的并发控制

``` java
import java.io.File;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicLong;

public class ConcurrentTotalFileSizeWLatch {
	private ExecutorService service;
	final private AtomicLong pendingFileVisits = new AtomicLong();
	final private AtomicLong totalSize = new AtomicLong();
	final private CountDownLatch latch = new CountDownLatch(1);
	public static String fileName = "C:\\Users\\Administrator\\Desktop\\1_11";

	private void updateTotalSizeOfFilesInDir(final File file) {
		long fileSize = 0;
		if (file.isFile())
			fileSize = file.length();
		else {
			final File[] children = file.listFiles();
			if (children != null) {
				for (final File child : children) {
					if (child.isFile())
						fileSize += child.length();
					else {
						pendingFileVisits.incrementAndGet();
						service.execute(new Runnable() {
							public void run() {
								updateTotalSizeOfFilesInDir(child);
							}
						});
					}
				}
			}
		}
		totalSize.addAndGet(fileSize);
		if (pendingFileVisits.decrementAndGet() == 0)
			latch.countDown();
	}

	private long getTotalSizeOfFile(final String fileName)
			throws InterruptedException {
		service = Executors.newFixedThreadPool(100);
		pendingFileVisits.incrementAndGet();
		try {
			updateTotalSizeOfFilesInDir(new File(fileName));
			latch.await(100, TimeUnit.SECONDS);
			return totalSize.longValue();
		} finally {
			service.shutdown();
		}
	}

	public static void main(final String[] args) throws InterruptedException {
		final long start = System.nanoTime();
		final long total = new ConcurrentTotalFileSizeWLatch()
				.getTotalSizeOfFile(fileName);
		final long end = System.nanoTime();
		System.out.println("Total Size: " + total);
		System.out.println("Time taken: " + (end - start) / 1.0e9);
	}
}
```

计算结果：

	Total Size: 59597673
	Time taken: 0.026633095

### 使用BlockingQueue和AtomicLong的实现

``` java
import java.io.File;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicLong;

public class ConcurrentTotalFileSizeWQueue {
	public static String fileName = "C:\\Users\\Administrator\\Desktop\\1_11";

	private ExecutorService service;
	final private BlockingQueue<Long> fileSizes = new ArrayBlockingQueue<Long>(
			500);
	final AtomicLong pendingFileVisits = new AtomicLong();

	private void startExploreDir(final File file) {
		pendingFileVisits.incrementAndGet();
		service.execute(new Runnable() {
			public void run() {
				exploreDir(file);
			}
		});
	}

	private void exploreDir(final File file) {
		long fileSize = 0;
		if (file.isFile())
			fileSize = file.length();
		else {
			final File[] children = file.listFiles();
			if (children != null)
				for (final File child : children) {
					if (child.isFile())
						fileSize += child.length();
					else {
						startExploreDir(child);
					}
				}
		}
		try {
			fileSizes.put(fileSize);
		} catch (Exception ex) {
			throw new RuntimeException(ex);
		}
		pendingFileVisits.decrementAndGet();
	}

	private long getTotalSizeOfFile(final String fileName)
			throws InterruptedException {
		service = Executors.newFixedThreadPool(100);
		try {
			startExploreDir(new File(fileName));
			long totalSize = 0;
			while (pendingFileVisits.get() > 0 || fileSizes.size() > 0) {
				final Long size = fileSizes.poll(10, TimeUnit.SECONDS);
				totalSize += size;
			}
			return totalSize;
		} finally {
			service.shutdown();
		}
	}

	public static void main(final String[] args) throws InterruptedException {
		final long start = System.nanoTime();
		final long total = new ConcurrentTotalFileSizeWQueue()
				.getTotalSizeOfFile(fileName);
		final long end = System.nanoTime();
		System.out.println("Total Size: " + total);
		System.out.println("Time taken: " + (end - start) / 1.0e9);
	}
}
```

计算结果：

	Total Size: 59597673
	Time taken: 0.044469408

### 使用jdk7的ForkJoin来实现

``` java
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.ForkJoinTask;
import java.util.concurrent.RecursiveTask;

public class FileSize {
	private final static ForkJoinPool forkJoinPool = new ForkJoinPool();
	public static String fileName = "C:\\Users\\Administrator\\Desktop\\1_11";

	private static class FileSizeFinder extends RecursiveTask<Long> {
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		final File file;

		public FileSizeFinder(final File theFile) {
			file = theFile;
		}

		@Override
		public Long compute() {
			long size = 0;
			if (file.isFile()) {
				size = file.length();
			} else {
				final File[] children = file.listFiles();
				if (children != null) {
					List<ForkJoinTask<Long>> tasks = new ArrayList<ForkJoinTask<Long>>();
					for (final File child : children) {
						if (child.isFile()) {
							size += child.length();
						} else {
							tasks.add(new FileSizeFinder(child));
						}
					}
					for (final ForkJoinTask<Long> task : invokeAll(tasks)) {
						size += task.join();
					}
				}
			}
			return size;
		}
	}

	public static void main(final String[] args) {
		final long start = System.nanoTime();
		final long total = forkJoinPool.invoke(new FileSizeFinder(new File(fileName)));
		final long end = System.nanoTime();
		System.out.println("Total Size: " + total);
		System.out.println("Time taken: " + (end - start) / 1.0e9);
	}
}
```

计算结果：

	Total Size: 59597673
	Time taken: 0.015022339

来自[http://blog.csdn.net/u011277123/article/details/52980247](http://blog.csdn.net/u011277123/article/details/52980247)