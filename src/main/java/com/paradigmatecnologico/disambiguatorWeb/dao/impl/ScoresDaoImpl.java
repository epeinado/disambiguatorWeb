package com.paradigmatecnologico.disambiguatorWeb.dao.impl;

import com.paradigmatecnologico.disambiguatorWeb.dao.ScoresDao;
import com.paradigmatecnologico.disambiguatorWeb.domain.Scores;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceUnit;
import javax.persistence.TypedQuery;

/**
 * User: Esther
 * Date: 05/11/13
 * Time: 12:44
 */
@Repository(value = "scoreDao")
public class ScoresDaoImpl implements ScoresDao {

    //    private EntityManager em; // = null;

    private EntityManagerFactory emf;


        /*
         * Sets the entity manager.
         */
    //    @PersistenceContext
    //    public void setEntityManager(EntityManager em) {
    //        this.em = em;
    ////    }
    //    @PersistenceContext
    //    public void setEm(EntityManager em) {
    //        this.em = em;
    //    }
    //
    //    public EntityManager getEm() {
    //        return em;
    //    }

    @PersistenceUnit
    public void setEmf(EntityManagerFactory emf) {
        this.emf = emf;
    }

    @Transactional(readOnly = true)
    public Scores getScores(String domain, String topic, String word) {
        EntityManager em = emf.createEntityManager();
        TypedQuery<Scores> query = em.createQuery("select s from Scores s where s.domain = :domain" +
                " and s.topic = :topic" +
                " and s.word = :word", Scores.class);
        query.setParameter("domain", domain);
        query.setParameter("topic", topic);
        query.setParameter("word", word);
        return query.getSingleResult();
    }

    @Transactional(readOnly = true)
    public boolean doesScoreExist(String domain, String topic, String word, String synset) {
        EntityManager em = emf.createEntityManager();
        TypedQuery<Scores> query = em.createQuery("select s from Scores s where s.domain = :domain" +
                " and s.topic = :topic" +
                " and s.word = :word" +
                " and s.synset = :synset", Scores.class);
        query.setParameter("domain", domain);
        query.setParameter("topic", topic);
        query.setParameter("word", word);
        query.setParameter("synset", synset);
        return query.getResultList().size() > 0;
    }

//    private boolean exists (Scores scores) {
//        Scores result = getScores(scores.getDomain(), scores.getTopic(), scores.getWord());
//        if (result != null) {
//            return true;
//        } else {
//            return false;
//        }
//
//    }

    // Save or Update
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void saveOrUpdateScores(Scores scores) {
//        scores.setId(1);
//        Scores result = new Scores();
//        result.setDomain(scores.getDomain());
//        result.setNegative(scores.getNegative());
//        result.setPos(scores.getPos());
//        result.setPositive(scores.getPositive());
//        result.setSynset(scores.getSynset());
//        result.setTopic(scores.getTopic());
//        result.setWord(scores.getWord());

        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(scores);
//                em.flush();
        em.getTransaction().commit();
        em.close();

    }

}
