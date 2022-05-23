/ SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract School {
    address public owner;
    uint256 studentId = 1;
    uint256 gradeId = 0;

    struct Student {
        uint studentId;
        string studentName;
        string class;
        uint[] grades;
        uint gradeIndex;
    }

    Student[] allStudents;

    constructor() {
        owner = msg.sender;
    }

    mapping(uint => Student) studentMatch;

    function addStudent(string calldata _studentName, string calldata _class) public {
        require(msg.sender == owner, "Only the class owner can add students!");

        uint[] memory a = new uint[](5);
        allStudents.push(Student(studentId, _studentName, _class, a, 0));
        studentMatch[studentId] = Student(studentId, _studentName, _class, a, 0);
        studentId++;
    }

    function getDetails(uint _id) public view returns(Student memory){
       return studentMatch[_id];
    }

    function addGrade(uint _id, uint _grade) public {
        require(msg.sender == owner, "Only the class owner can add grades to students!");
        Student storage student = studentMatch[_id];
        student.grades[student.gradeIndex] = _grade;
        student.gradeIndex++;
        studentMatch[_id] = student;
    }

    function getStudents() public view returns (Student[] memory) {
        return allStudents;
    }

}
