package com.ron.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by ron on 16-9-20.
 */
@Controller
public class IndexController {

    @RequestMapping("/")
    public String index(){
        return "admin/index";
    }
}
