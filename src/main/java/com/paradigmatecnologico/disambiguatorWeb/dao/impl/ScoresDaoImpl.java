package com.paradigmatecnologico.disambiguatorWeb.dao.impl;

import com.paradigmatecnologico.disambiguatorWeb.dao.ScoresDao;
import com.paradigmatecnologico.disambiguatorWeb.domain.Scores;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
    public Scores getScores(String domain, String pos, String topic, String word, String synset) {
        EntityManager em = emf.createEntityManager();
        TypedQuery<Scores> query = em.createQuery("select s from Scores s where s.domain = :domain" +
                " and s.topic = :topic" +
                " and s.pos = :pos" +
                " and s.word = :word" +
                " and s.synset = :synset", Scores.class);
        query.setParameter("domain", domain);
        query.setParameter("pos", pos);
        query.setParameter("topic", topic);
        query.setParameter("word", word);
        query.setParameter("synset", synset);
        Scores result = query.getSingleResult();
        em.close();
        return result;
    }

    @Transactional(readOnly = true)
    public List<Scores> getAllScores() {
        EntityManager em = emf.createEntityManager();
        TypedQuery<Scores> query = em.createQuery("select s from Scores s ", Scores.class);
        List<Scores> result = query.getResultList();
        em.close();
        return result;
    }

    @Transactional(readOnly = true)
    public boolean doesScoreExist(String domain, String pos, String topic, String word, String synset) {
        EntityManager em = emf.createEntityManager();
        TypedQuery<Scores> query = em.createQuery("select s from Scores s where s.domain = :domain" +
                " and s.topic = :topic" +
                " and s.pos = :pos" +
                " and s.word = :word" +
                " and s.synset = :synset", Scores.class);
        query.setParameter("domain", domain);
        query.setParameter("pos", pos);
        query.setParameter("topic", topic);
        query.setParameter("word", word);
        query.setParameter("synset", synset);
        boolean result = query.getResultList().size() > 0;
        em.close();
        return result;
    }

    private Scores getScoreById(int id) {
        EntityManager em = emf.createEntityManager();
        TypedQuery<Scores> query = em.createQuery("select s from Scores s where s.id = :id", Scores.class);
        query.setParameter("id", id);
        Scores result = query.getSingleResult();
        em.close();
        return result;
    }

    public void createduplicateNewDomain(ArrayList<Integer> list, String domain) {
        EntityManager em = emf.createEntityManager();
        Scores result = new Scores();
        result.setDomain(domain);
        for (Integer id : list) {
            Scores scoreById = getScoreById(id);
            result.setPositive(scoreById.getPositive());
            result.setNegative(scoreById.getNegative());
            result.setPos(scoreById.getPos());
            result.setSynset(scoreById.getSynset());
            result.setTopic(scoreById.getTopic());
            result.setWord(scoreById.getWord());
            result.setDate(new Date());
            saveOrUpdateScores(result);
        }
        em.close();
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void deleteList(ArrayList<Integer> list) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        for (int id : list) {
            Query query = em.createQuery("delete from Scores s where s.id = :id");
            query.setParameter("id", id);
            query.executeUpdate();
        }
        em.getTransaction().commit();
        em.close();
    }

    public void updateValue(Integer id, String domain, String topic, String word, Float positive, Float negative) {
        Scores old = getScoreById(id);
        old.setDomain(domain);
        old.setTopic(topic);
        old.setWord(word);
        old.setPositive(positive / 100);
        old.setNegative(negative / 100);
        saveOrUpdateScores(old);
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
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        if (scores.getId() != 0) {
            em.merge(scores);
        } else {
            if (doesScoreExist(scores.getDomain(), scores.getPos(), scores.getTopic(), scores.getWord(), scores.getSynset())) {
                Scores aux = getScores(scores.getDomain(), scores.getPos(), scores.getTopic(), scores.getWord(), scores.getSynset());
                aux.setPositive(scores.getPositive());
                aux.setNegative(scores.getNegative());
                em.merge(aux);
            } else {
                em.persist(scores);
            }
        }
        em.getTransaction().commit();
        em.close();
    }

}
