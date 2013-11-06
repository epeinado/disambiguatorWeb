package com.paradigmatecnologico.disambiguatorWeb.domain;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonProperty;

/**
 * User: epeinado
 * Date: 31/10/13
 * Time: 13:05
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class Sentiment {
    @JsonProperty("objective")
    String objective;

    @JsonProperty("negative")
    String negative;

    @JsonProperty("positive")
    String positive;

    public Sentiment() {
    }

    public String getObjective() {
        return objective;
    }

    public void setObjective(String objective) {
        this.objective = objective;
    }

    public String getNegative() {
        return negative;
    }

    public void setNegative(String negative) {
        this.negative = negative;
    }

    public String getPositive() {
        return positive;
    }

    public void setPositive(String positive) {
        this.positive = positive;
    }
}
