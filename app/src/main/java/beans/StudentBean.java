package beans;

import entities.Student;
import services.StudentService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.enterprise.context.RequestScoped;
import javax.enterprise.context.SessionScoped;
import java.io.Serial;
import java.io.Serializable;
import java.util.List;
import javax.inject.Named;

@Named
@SessionScoped
public class StudentBean implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private static final Logger logger = LogManager.getLogger(StudentBean.class);
    private final StudentService studentService = new StudentService();
    private Student student = new Student();
    private Student editStudent = new Student();
    private List<Student> students;

    private Long studentId;

    public Long getStudentId() {
        return studentId;
    }

    public void setStudentId(Long studentId) {
        this.studentId = studentId;
    }

    private void loadStudents(){
        this.students = this.studentService.getAllStudents();
    }

    public String addStudent() {
        logger.error(student);
        studentService.addStudent(student);
        student = new Student();
        loadStudents();
        return "/views/students.xhtml";
    }

    public String editStudent() {
        student.setId(studentId);
        studentService.updateStudent(student);
        student = new Student();
        loadStudents();
        return "/views/students.xhtml";
    }

    public String deleteStudent() {
        studentService.deleteStudent(studentId);
        loadStudents();
        return "/views/students.xhtml";
    }

    // Getters et setters
    public Student getEditStudent() {
        return student;
    }
    public void setEditStudent(Student student) {
        this.student = student;
    }
    public Student getStudent() {
        return student;
    }
    public void setStudent(Student student) {
        this.student = student;
    }
    public List<Student> getStudents() {
        loadStudents();
        return students;
    }
}