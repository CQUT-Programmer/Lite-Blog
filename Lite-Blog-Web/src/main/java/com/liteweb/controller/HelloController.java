package com.liteweb.controller;

import com.liteweb.dto.ResultResponse;
import com.liteweb.utils.ResultResponseUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public ResultResponse<String> Hello(){
        return ResultResponseUtils.success("hello,world");
    }
}
