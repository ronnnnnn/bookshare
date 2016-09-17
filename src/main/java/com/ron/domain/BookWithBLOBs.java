package com.ron.domain;

public class BookWithBLOBs extends Book {
    private String authorSummary;

    private String catalogue;

    public String getAuthorSummary() {
        return authorSummary;
    }

    public void setAuthorSummary(String authorSummary) {
        this.authorSummary = authorSummary == null ? null : authorSummary.trim();
    }

    public String getCatalogue() {
        return catalogue;
    }

    public void setCatalogue(String catalogue) {
        this.catalogue = catalogue == null ? null : catalogue.trim();
    }
}