package com.njustz.controller;

import com.njustz.bean.Department;
import com.njustz.bean.Msg;
import com.njustz.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author njustz
 * @date 2019/10/12
 */

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDeptsWithJson(){
        List<Department> departmentList = departmentService.getDepts();
        return Msg.success().add("depts", departmentList);
    }
}
