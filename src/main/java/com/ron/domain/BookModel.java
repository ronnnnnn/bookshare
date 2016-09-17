package com.ron.domain;

public class BookModel {
    private Integer id;

    private String author;

    private String publishing;

    private String publishTime;

    private String wordNumber;

    private String whichEdtion;

    private String totalPage;

    private String printTime;

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

	public String getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime;
	}

	public String getPrintTime() {
		return printTime;
	}

	public void setPrintTime(String printTime) {
		this.printTime = printTime;
	}
}