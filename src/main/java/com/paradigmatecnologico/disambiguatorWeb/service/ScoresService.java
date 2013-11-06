package com.paradigmatecnologico.disambiguatorWeb.service;

import com.paradigmatecnologico.disambiguatorWeb.domain.Scores;

/**
 * User: Esther
 * Date: 05/11/13
 * Time: 12:56
 */
public interface ScoresService {

    public Scores getScores(String domain, String topic, String word);

    public void saveScores(Scores scores);
}
