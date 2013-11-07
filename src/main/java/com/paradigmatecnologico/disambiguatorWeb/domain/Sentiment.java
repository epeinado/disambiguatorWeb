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

    public Sentiment(Float positive, Float negative) {
        this.positive = String.valueOf(positive);
        this.negative = String.valueOf(negative);
        this.objective = String.valueOf(Math.abs(1 - positive + negative));
    }

    public String getObjective() {
        return objective;
    }

    public void setObjective(String objective) {
        this.objective = objective;
    }

//    Se elimina el caracter del signo para que se pinte bien el slide en la vista
    public String getNegative() {
        if (negative.contains("+") || negative.contains("-")) {
            return negative.substring(1);
        } else {
            return negative;
        }
    }

    public void setNegative(String negative) {
        this.negative = negative;
    }

//    Se elimina el caracter del signo para que se pinte bien el slide en la vista
    public String getPositive() {
        if (positive.contains("+") || positive.contains("-")) {
            return positive.substring(1);
        } else {
            return positive;
        }    }

    public void setPositive(String positive) {
        this.positive = positive;
    }
}
