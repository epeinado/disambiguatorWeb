package com.paradigmatecnologico.disambiguatorWeb.dao;

import com.paradigmatecnologico.disambiguatorWeb.domain.Scores;

import javax.persistence.EntityManagerFactory;

/**
 * User: Esther
 * Date: 05/11/13
 * Time: 12:43
 */
public interface ScoresDao {
    public void setEmf(EntityManagerFactory em);

    public Scores getScores(String domain, String topic, String word);

    public void saveOrUpdateScores(Scores scores);

    public boolean doesScoreExist(String domain, String topic, String word, String synset);

//    public List<Usuario> getUsuariosList();
//
//    public void saveUsuario(Usuario prod);
//
//    public List<Usuario> getUsuariosGrupoRonda(int grupo, Ronda ronda);
//
//    public Usuario comprobarUsuario(Usuario usuario);
//
//    public Usuario getUsuario(String correo);
//
//    public boolean comprobarCorreo(String correo);
//
//    public int getGrupoUsuario(Usuario usuario);


}
