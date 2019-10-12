package com.njustz.service;

import com.njustz.bean.Department;
import com.njustz.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author njustz
 * @date 2019/10/12
 */

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts(){
        return departmentMapper.selectByExample(null);
    }

}
