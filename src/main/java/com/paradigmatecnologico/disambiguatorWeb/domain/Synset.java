package com.paradigmatecnologico.disambiguatorWeb.domain;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonProperty;

/**
 * User: epeinado
 * Date: 31/10/13
 * Time: 11:31
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class Synset {

    @JsonProperty("domain")
    String[] domain;

    @JsonProperty("pos")
    char pos;

    @JsonProperty("meaning")
    String meaning;

    @JsonProperty("synset")
    String synset;

    @JsonProperty("spanish_words")
    String[] spanishWords;

    @JsonProperty("french_words")
    String[] frenchWords;

    @JsonProperty("portuguese_words")
    String[] portugueseWords;

    @JsonProperty("italian_words")
    String[] italianWords;

    @JsonProperty("affect")
    String[] affects;

    @JsonProperty("english_words")
    String[] englishWords;

    @JsonProperty("sentiment")
    Sentiment sentiment;

    public Synset() {
    }

    public String[] getDomain() {
        return domain;
    }

    public void setDomain(String[] domain) {
        this.domain = domain;
    }

    public char getPos() {
        return pos;
    }

    public void setPos(char pos) {
        this.pos = pos;
    }

    public String getMeaning() {
        return meaning;
    }

    public void setMeaning(String meaning) {
        this.meaning = meaning;
    }

    public String getSynset() {
        return synset;
    }

    public void setSynset(String synset) {
        this.synset = synset;
    }

    public String[] getSpanishWords() {
        return spanishWords;
    }

    public void setSpanishWords(String[] spanishWords) {
        this.spanishWords = spanishWords;
    }

    public String[] getFrenchWords() {
        return frenchWords;
    }

    public void setFrenchWords(String[] frenchWords) {
        this.frenchWords = frenchWords;
    }

    public String[] getPortugueseWords() {
        return portugueseWords;
    }

    public void setPortugueseWords(String[] portugueseWords) {
        this.portugueseWords = portugueseWords;
    }

    public String[] getItalianWords() {
        return italianWords;
    }

    public void setItalianWords(String[] italianWords) {
        this.italianWords = italianWords;
    }

    public String[] getAffects() {
        return affects;
    }

    public void setAffects(String[] affects) {
        this.affects = affects;
    }

    public String[] getEnglishWords() {
        return englishWords;
    }

    public void setEnglishWords(String[] englishWords) {
        this.englishWords = englishWords;
    }

    public Sentiment getSentiment() {
        return sentiment;
    }

    public void setSentiment(Sentiment sentiment) {
        this.sentiment = sentiment;
    }
}
