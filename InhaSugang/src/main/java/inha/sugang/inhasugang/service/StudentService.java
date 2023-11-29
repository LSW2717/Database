package inha.sugang.inhasugang.service;


import inha.sugang.inhasugang.entity.Student;
import inha.sugang.inhasugang.repository.StudentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class StudentService {
    private final StudentRepository studentRepository;

    @Transactional
    public void save(Student student){
        studentRepository.save(student);
    }

    public List<Student> findStudents(){
        return studentRepository.findAll();
    }
    public Optional<Student> findOne(int studentNumber){
        return studentRepository.findByStudentNumber(studentNumber);
    }
    public Integer findIdByStudentNumber(int studentNumber) {
        Optional<Student> studentOpt = studentRepository.findByStudentNumber(studentNumber);

        if (studentOpt.isPresent()) {
            return studentOpt.get().getId();
        } else {
            throw new IllegalArgumentException("No student found with student number: " + studentNumber);
        }
    }
}
