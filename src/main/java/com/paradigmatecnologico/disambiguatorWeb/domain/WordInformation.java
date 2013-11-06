package com.paradigmatecnologico.disambiguatorWeb.domain;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonProperty;

import java.util.Map;

/**
 * User: epeinado
 * Date: 31/10/13
 * Time: 11:24
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class WordInformation {

    @JsonProperty("elapsed_time")
    Long elapsedTime;

    @JsonProperty("synsets")
    Map<String, Synset> synsets;

    public WordInformation() {

    }

    public WordInformation(Long elapsedTime, Map<String, Synset> synsets) {

        this.elapsedTime = elapsedTime;
        this.synsets = synsets;
    }

    public Long getElapsedTime() {

        return elapsedTime;
    }

    public void setElapsedTime(Long elapsedTime) {
        this.elapsedTime = elapsedTime;
    }

    public Map<String, Synset> getSynsets() {
        return synsets;
    }

    public void setSynsets(Map<String, Synset> synsets) {
        this.synsets = synsets;
    }
}
