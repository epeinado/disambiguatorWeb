package com.paradigmatecnologico.disambiguatorWeb.web;

import com.paradigmatecnologico.disambiguatorWeb.domain.Scores;
import com.paradigmatecnologico.disambiguatorWeb.domain.Sentiment;
import com.paradigmatecnologico.disambiguatorWeb.domain.Synset;
import com.paradigmatecnologico.disambiguatorWeb.domain.WordInformation;
import com.paradigmatecnologico.disambiguatorWeb.service.ScoresService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJacksonHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

/**
 * User: epeinado
 * Date: 29/10/13
 * Time: 10:01
 */
@Controller
public class MainController {

    @Autowired
    ScoresService scoresService;

    @Value("#{jdbcProperties['url.sentiment.address']}")
    private String URL;

//    private String URL = urlSentiment +"get_word_information?word={word}&language={language}";


    private WordInformation getWordInformation(String word, String language) {
        // Create the RestTemplate
        RestTemplate rest = new RestTemplate();
        // Set the parameters
        Map<String, String> params = new HashMap<String, String>();
        params.put("word", word);
        params.put("language", language);

        List<HttpMessageConverter<?>> converters = rest.getMessageConverters();
        converters.add(new MappingJacksonHttpMessageConverter());
        rest.setMessageConverters(converters);
        // perform search and convert JSON results to POJOs (Map JSON result to POJO)
        return rest.getForObject(URL, WordInformation.class, params);
    }

    @RequestMapping(value = "main.html", method = RequestMethod.GET)
    public ModelAndView main(@RequestParam("word") String word,
                             @RequestParam("topic") String topic, @RequestParam("domain") String domain) {
        ModelMap model = new ModelMap();
        model.addAttribute("word", word);
        model.addAttribute("topic", topic);
        model.addAttribute("domain", domain);
        Collection<Synset> synsets = getWordInformation(word, "english").getSynsets().values();
        for (Synset synset : synsets) {
            synset.setTagged(scoresService.doesScoreExist(domain, synset.getPos(), topic, word, synset.getSynset()));
            if (synset.isTagged()) {
                Scores aux = scoresService.getScores(domain, synset.getPos(), topic, word, synset.getSynset());
                Sentiment sentiment = new Sentiment(aux.getPositive(), aux.getNegative());
                synset.setSentiment(sentiment);
            }
            if (Float.valueOf(synset.getSentiment().getPositive()) < 1) {
                synset.getSentiment().setPositive(String.valueOf(Float.valueOf(synset.getSentiment().getPositive()) * 100));
            }
            if (Float.valueOf(synset.getSentiment().getNegative()) < 1) {
                synset.getSentiment().setNegative(String.valueOf(Float.valueOf(synset.getSentiment().getNegative()) * 100));
            }
        }
        model.addAttribute("synsets", synsets);
        return new ModelAndView("main", model);
    }

    @RequestMapping(value = "saveResults.html", method = RequestMethod.GET)
    public String saveResults(Scores scores) {
        scores.setDate(new Date());
        if (scores.getPositive() > 1) {
            scores.setPositive((scores.getPositive() / 100));
        }
        if (scores.getNegative() > 1) {
            scores.setNegative((scores.getNegative() / 100));
        }
        scoresService.saveScores(scores);
        return "redirect:main.html?domain=" + scores.getDomain() + "&topic=" + scores.getTopic() + "&word=" + scores.getWord();
    }

    @RequestMapping(value = "duplicate.html", method = RequestMethod.GET)
    public String duplicate(@RequestParam(value="list") ArrayList<Integer> list, String domain) {
        scoresService.createDuplicateNewDomain(list, domain);
        return "redirect:show.html";
    }

    @RequestMapping(value = "delete.html", method = RequestMethod.GET)
    public String delete(@RequestParam(value="list") ArrayList<Integer> list) {
        scoresService.deleteList(list);
        return "redirect:show.html";
    }

    @RequestMapping(value = "edit.html", method = RequestMethod.POST)
        public String edit(@RequestParam("modalid") Integer id, @RequestParam("modalword") String word,
                                 @RequestParam("modaltopic") String topic, @RequestParam("modaldomain") String domain,
                                 @RequestParam("positive") Float positive, @RequestParam("negative") Float negative) {
        scoresService.updateValue(id, domain, topic, word, positive, negative);
        return "redirect:show.html";
    }

    @RequestMapping(value = "show.html", method = RequestMethod.GET)
    public ModelAndView show() {
        List<Scores> scores = scoresService.getAllScores();
        ModelMap model = new ModelMap();
        model.addAttribute("scores", scores);
        return new ModelAndView("show", model);
    }

    @RequestMapping(value = "index.html", method = RequestMethod.GET)
    public String index() {
        return "index";
    }


    public ScoresService getScoresService() {
        return scoresService;
    }

    public void setScoresService(ScoresService scoresService) {
        this.scoresService = scoresService;
    }

    public String getURL() {
        return URL;
    }

    public void setURL(String URL) {
        this.URL = URL;
    }
}
