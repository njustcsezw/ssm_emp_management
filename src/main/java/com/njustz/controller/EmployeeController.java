package com.njustz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.njustz.bean.Employee;
import com.njustz.bean.Msg;
import com.njustz.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author njustz
 * @date 2019/9/27
 */

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("/checkName")
    @ResponseBody
    public Msg checkEmpName(@RequestParam("empName") String name){
        //先判断用户名是否是合法的表达式
        String regName = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!name.matches(regName)){
            return Msg.fail().add("va_name","(back)The user's name must contain 3-16 letters or 2-5 Chinese characters at least~");
        }
        boolean res = employeeService.checkUserName(name);
        if(res){
            return Msg.success();
        }else{
            return Msg.fail().add("va_name", "(back)The user's name is repeated~");
        }
    }

    //保存员工信息到服务器
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    public @ResponseBody Msg saveEmp(Employee employee){
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    //查询员工数据，分页查询
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model){
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


    @RequestMapping("/emp_lists")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn){

        PageHelper.startPage(pn, 10);
        //startPage后面紧跟的查询就是一个分页查询
        List<Employee> employeeList = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行
        //封装了详细的分页信息，包括我们查询出来的结果，传入连续显示的页数
        PageInfo pageInfo = new PageInfo(employeeList, 5);
        return Msg.success().add("pageInfo", pageInfo);

    }

}
