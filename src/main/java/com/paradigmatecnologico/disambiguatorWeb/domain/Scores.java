package com.paradigmatecnologico.disambiguatorWeb.domain;

import javax.persistence.Entity;

/**
 * User: Esther
 * Date: 05/11/13
 * Time: 12:36
 */
@Entity
public class Scores {
    private int id;

    @javax.persistence.Column(name = "id", nullable = false, insertable = true, updatable = true, length = 10, precision = 0)
    @javax.persistence.Id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String synset;

    @javax.persistence.Column(name = "synset", nullable = false, insertable = true, updatable = true, length = 8, precision = 0)
    @javax.persistence.Basic
    public String getSynset() {
        return synset;
    }

    public void setSynset(String synset) {
        this.synset = synset;
    }

    private String pos;

    @javax.persistence.Column(name = "pos", nullable = false, insertable = true, updatable = true, length = 1, precision = 0)
    @javax.persistence.Basic
    public String getPos() {
        return pos;
    }

    public void setPos(String pos) {
        this.pos = pos;
    }

    private String domain;

    @javax.persistence.Column(name = "domain", nullable = false, insertable = true, updatable = true, length = 10, precision = 0)
    @javax.persistence.Basic
    public String getDomain() {
        return domain;
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }

    private String topic;

    @javax.persistence.Column(name = "topic", nullable = false, insertable = true, updatable = true, length = 30, precision = 0)
    @javax.persistence.Basic
    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    private String word;

    @javax.persistence.Column(name = "word", nullable = false, insertable = true, updatable = true, length = 30, precision = 0)
    @javax.persistence.Basic
    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    private float positive;

    @javax.persistence.Column(name = "positive", nullable = false, insertable = true, updatable = true, length = 12, precision = 0)
    @javax.persistence.Basic
    public float getPositive() {
        return positive;
    }

    public void setPositive(float positive) {
        this.positive = positive;
    }

    private float negative;

    @javax.persistence.Column(name = "negative", nullable = false, insertable = true, updatable = true, length = 12, precision = 0)
    @javax.persistence.Basic
    public float getNegative() {
        return negative;
    }

    public void setNegative(float negative) {
        this.negative = negative;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Scores scores = (Scores) o;

        if (id != scores.id) return false;
        if (Float.compare(scores.negative, negative) != 0) return false;
        if (Float.compare(scores.positive, positive) != 0) return false;
        if (domain != null ? !domain.equals(scores.domain) : scores.domain != null) return false;
        if (pos != null ? !pos.equals(scores.pos) : scores.pos != null) return false;
        if (synset != null ? !synset.equals(scores.synset) : scores.synset != null) return false;
        if (topic != null ? !topic.equals(scores.topic) : scores.topic != null) return false;
        if (word != null ? !word.equals(scores.word) : scores.word != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (synset != null ? synset.hashCode() : 0);
        result = 31 * result + (pos != null ? pos.hashCode() : 0);
        result = 31 * result + (domain != null ? domain.hashCode() : 0);
        result = 31 * result + (topic != null ? topic.hashCode() : 0);
        result = 31 * result + (word != null ? word.hashCode() : 0);
        result = 31 * result + (positive != +0.0f ? Float.floatToIntBits(positive) : 0);
        result = 31 * result + (negative != +0.0f ? Float.floatToIntBits(negative) : 0);
        return result;
    }


}
