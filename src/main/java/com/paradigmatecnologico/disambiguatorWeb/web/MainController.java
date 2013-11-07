package com.paradigmatecnologico.disambiguatorWeb.web;

import com.paradigmatecnologico.disambiguatorWeb.domain.Scores;
import com.paradigmatecnologico.disambiguatorWeb.domain.Synset;
import com.paradigmatecnologico.disambiguatorWeb.domain.WordInformation;
import com.paradigmatecnologico.disambiguatorWeb.service.ScoresService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJacksonHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: epeinado
 * Date: 29/10/13
 * Time: 10:01
 */
@Controller
public class MainController {

    @Autowired
    ScoresService scoresService;

    private static String URL = "http://54.200.220.111:8888/get_word_information?word={word}&language={language}";


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

    @RequestMapping(value="/main.html", method = RequestMethod.GET)
    public ModelAndView main(@RequestParam("word") String word,
    @RequestParam("topic") String topic, @RequestParam("domain") String domain) {
        ModelMap model = new ModelMap();
        model.addAttribute("word", word);
        model.addAttribute("topic", topic);
        model.addAttribute("domain", domain);
        Collection<Synset> synsets = getWordInformation(word, "english").getSynsets().values();
        for(Synset synset:synsets) {
            synset.setTagged(scoresService.doesScoreExist(domain, topic, word, synset.getSynset()));
        }
        model.addAttribute("synsets", synsets);
        return new ModelAndView("main", model);
    }

    @RequestMapping(value="/saveResults.html", method = RequestMethod.GET)
    public ModelAndView saveResults(Scores scores) {
        scoresService.saveScores(scores);
        return new ModelAndView("redirect:/main.html?domain="+scores.getDomain()+"&word="+scores.getWord()+"&topic="+scores.getTopic());
    }
}
