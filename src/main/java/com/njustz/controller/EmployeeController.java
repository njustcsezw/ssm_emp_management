package com.njustz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.njustz.bean.Employee;
import com.njustz.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @author njustz
 * @date 2019/9/27
 */

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    //查询员工数据，分页查询
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                          Model model){

        //引入PageHelper分页插件
        //查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 10);
        //startPage后面紧跟的查询就是一个分页查询
        List<Employee> employeeList = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行
        //封装了详细的分页信息，包括我们查询出来的结果，传入连续显示的页数
        PageInfo pageInfo = new PageInfo(employeeList, 5);
        model.addAttribute("pageInfo", pageInfo);

        return "list";
    }

}
