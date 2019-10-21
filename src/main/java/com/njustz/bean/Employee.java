package com.njustz.bean;

import javax.validation.constraints.Pattern;

public class Employee {
   
    private Integer empId;

    @Pattern(regexp = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})"
            , message = "(back)The user's name must contain 3-16 letters or 2-5 Chinese characters at least~")
    private String empName; 
    private String empGender;

    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            , message = "The user's email is illegal ~")
    private String email;  
    private Integer deptId;
    private Department department;

    public Employee() {
		super();
		
	}

	public Employee(Integer empId, String empName, String empGender, String email, Integer deptId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.empGender = empGender;
		this.email = email;
		this.deptId = deptId;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }
  
    public String getEmpGender() {
        return empGender;
    }
   
    public void setEmpGender(String empGender) {
        this.empGender = empGender == null ? null : empGender.trim();
    }
   
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }
   
    public Integer getDeptId() {
        return deptId;
    }
    
    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

}