package com.ron.domain;

public class Book {
    private Integer id;

    private String author;

    private String publishing;

    private Long publishTime;

    private String wordNumber;

    private String whichEdtion;

    private String totalPage;

    private Long printTime;

    private String printNumber;

    private String isbn;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author == null ? null : author.trim();
    }

    public String getPublishing() {
        return publishing;
    }

    public void setPublishing(String publishing) {
        this.publishing = publishing == null ? null : publishing.trim();
    }

    public Long getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Long publishTime) {
        this.publishTime = publishTime;
    }

    public String getWordNumber() {
        return wordNumber;
    }

    public void setWordNumber(String wordNumber) {
        this.wordNumber = wordNumber == null ? null : wordNumber.trim();
    }

    public String getWhichEdtion() {
        return whichEdtion;
    }

    public void setWhichEdtion(String whichEdtion) {
        this.whichEdtion = whichEdtion == null ? null : whichEdtion.trim();
    }

    public String getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(String totalPage) {
        this.totalPage = totalPage == null ? null : totalPage.trim();
    }

    public Long getPrintTime() {
        return printTime;
    }

    public void setPrintTime(Long printTime) {
        this.printTime = printTime;
    }

    public String getPrintNumber() {
        return printNumber;
    }

    public void setPrintNumber(String printNumber) {
        this.printNumber = printNumber == null ? null : printNumber.trim();
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn == null ? null : isbn.trim();
    }
}