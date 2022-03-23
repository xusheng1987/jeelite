package com.github.flying.jeelite.common.persistence;

import java.io.Serializable;
import java.util.List;

/**
 * 分页类
 */
public class Page<T> implements Serializable {

    /**
     * 数据总条数
     */
    private long total;
    /**
     * 总页数
     */
    private int pages;
    /**
     * 查询结果
     */
    private List<T> records;

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    public List<T> getRecords() {
        return records;
    }

    public void setRecords(List<T> records) {
        this.records = records;
    }
}