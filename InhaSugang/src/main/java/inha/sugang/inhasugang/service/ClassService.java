package inha.sugang.inhasugang.service;


import inha.sugang.inhasugang.entity.Class;
import inha.sugang.inhasugang.entity.Student;
import inha.sugang.inhasugang.repository.ClassRepository;
import inha.sugang.inhasugang.repository.StudentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class ClassService {
    private final ClassRepository classRepository;
    private final StudentRepository studentRepository;

    @Transactional
    public void save(Class lecture){
        classRepository.save(lecture);
    }

    public List<Class> findClassesByStudentId(int studentNumber) {
        Optional<Student> student = studentRepository.findByStudentNumber(studentNumber);
        return student.map(Student::getClasses).orElse(Collections.emptyList());
    }

    public List<Class> findClasses(){
        return classRepository.findAll();
    }

    public Optional<Class> findOne(int classId){
        return classRepository.findById(classId);
    }

    @Transactional
    public void enrollStudentInClass(int studentId, int classId) {
        Optional<Student> studentOptional = studentRepository.findById(studentId);
        Optional<Class> classOptional = classRepository.findById(classId);

        if (studentOptional.isEmpty() || classOptional.isEmpty()) {
            throw new IllegalArgumentException("학생 또는 클래스를 찾을 수 없습니다.");
        }

        Student student = studentOptional.get();
        Class classEntity = classOptional.get();

        // 학생이 이미 클래스에 등록되어 있는지 확인
        if (classEntity.getStudents().contains(student)) {
            throw new IllegalStateException("학생은 이미 이 클래스에 등록되어 있습니다.");
        }
        // 클래스의 여석 확인
        if (classEntity.getRemainingParticipant() == 0) {
            throw new IllegalStateException("이미 여석이 만료되었습니다.");
        }

        // 수강 신청 처리
        classEntity.setRemainingParticipant(classEntity.getRemainingParticipant() - 1);
        student.addClass(classEntity);
        classEntity.addStudent(student);

        classRepository.save(classEntity);
        studentRepository.save(student);
    }

}
