package com.paradigmatecnologico.disambiguatorWeb.service.impl;

import com.paradigmatecnologico.disambiguatorWeb.dao.ScoresDao;
import com.paradigmatecnologico.disambiguatorWeb.domain.Scores;
import com.paradigmatecnologico.disambiguatorWeb.service.ScoresService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * User: Esther
 * Date: 05/11/13
 * Time: 12:57
 */
@Component
public class ScoresServiceImpl implements ScoresService {
    @Autowired
    ScoresDao scoresDao;

    public Scores getScores(String domain, String topic, String word) {
        return scoresDao.getScores(domain, topic, word);
    }

    public void saveScores(Scores scores) {
        scoresDao.saveOrUpdateScores(scores);
    }
}