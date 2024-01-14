package services;

import beans.StudentBean;
import entities.Student;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.persistence.*;
import java.util.List;

public class StudentService {
    private static final Logger logger = LogManager.getLogger(StudentBean.class);
    private EntityManager em = JPAUtil.getEntityManager();;

    public void addStudent(Student student) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(student);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            logger.error(e);
        }
    }

    public Student findStudent(Long id) {
        return em.find(Student.class, id);
    }

    public List<Student> getAllStudents() {
        return em.createQuery("SELECT s FROM Student s", Student.class).getResultList();
    }

    public void updateStudent(Student student) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.merge(student);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            logger.error(e);
        }
    }

    public void deleteStudent(Long id) {
        Student student = em.find(Student.class, id);
        if (student != null) {
            EntityTransaction transaction = em.getTransaction();
            try {
                transaction.begin();
                em.remove(student);
                transaction.commit();
            } catch (Exception e) {
                if (transaction.isActive()) {
                    transaction.rollback();
                }
                logger.error(e);
            }
        }
    }
}
