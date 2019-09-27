package com.njustz.dao;

import com.njustz.bean.Department;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class EmployeeMapperTest {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Test
    public void testCRUD(){

       /*
        //创建IOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext();
        //从容器中获取mapper
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
        */

        //System.out.println(departmentMapper);
        //插入几个部门
        departmentMapper.insertSelective(new Department(null, "测试部"));


    }
    
}