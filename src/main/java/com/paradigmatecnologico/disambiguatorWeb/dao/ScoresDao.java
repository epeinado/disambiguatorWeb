package com.paradigmatecnologico.disambiguatorWeb.dao;

import com.paradigmatecnologico.disambiguatorWeb.domain.Scores;

import javax.persistence.EntityManagerFactory;
import java.util.ArrayList;
import java.util.List;

/**
 * User: Esther
 * Date: 05/11/13
 * Time: 12:43
 */
public interface ScoresDao {
    public void setEmf(EntityManagerFactory em);

    public Scores getScores(String domain, String pos,  String topic, String word, String synset);

    public List<Scores> getAllScores();

    public void saveOrUpdateScores(Scores scores);

    public boolean doesScoreExist(String domain, String pos, String topic, String word, String synset);

    public void createduplicateNewDomain(ArrayList<Integer> list, String domain);

    public void deleteList(ArrayList<Integer> list);

    public void updateValue(Integer id, String domain, String topic, String word, Float positive, Float negative);
}
