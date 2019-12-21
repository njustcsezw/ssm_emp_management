package com.njustz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.njustz.bean.Employee;
import com.njustz.bean.Msg;
import com.njustz.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public @ResponseBody Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()) {
            List <FieldError> errors=result.getFieldErrors();
            Map<String ,Object> map=new HashMap<String, Object>();
            for(FieldError fieldError:errors) {
                System.out.println("错误的字段名:"+fieldError.getField());
                System.out.println("错误的信息:"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("j", map);	//校验失败
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
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

    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){

        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }


    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee, HttpServletRequest request){
        employeeService.updateEmp(employee);
        return Msg.success();
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
