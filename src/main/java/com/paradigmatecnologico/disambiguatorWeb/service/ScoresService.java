package com.paradigmatecnologico.disambiguatorWeb.service;

import com.paradigmatecnologico.disambiguatorWeb.domain.Scores;

/**
 * User: Esther
 * Date: 05/11/13
 * Time: 12:56
 */
public interface ScoresService {

    public Scores getScores(String domain, String pos, String topic, String word, String synset);

    public void saveScores(Scores scores);

    public boolean doesScoreExist(String domain, String pos, String topic, String word, String synset);
}
