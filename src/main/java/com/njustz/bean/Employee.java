package com.njustz.bean;

public class Employee {
   
    private Integer empId;
    private String empName; 
    private String empGender;
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