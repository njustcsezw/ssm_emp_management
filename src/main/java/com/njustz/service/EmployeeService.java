package com.njustz.service;

import com.njustz.bean.Employee;
import com.njustz.bean.EmployeeExample;
import com.njustz.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author njustz
 * @date 2019/9/27
 */

@Service
public class EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
    * true表示用户名可用
    * */
    public boolean checkUserName(String name) {
        EmployeeExample employee = new EmployeeExample();
        EmployeeExample.Criteria employeeCriteria = employee.createCriteria();
        employeeCriteria.andEmpNameEqualTo(name);
        long count = employeeMapper.countByExample(employee);
        return count == 0;
    }
}
