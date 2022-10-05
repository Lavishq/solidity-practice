// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Make use of a custom error if wish to
error Student__NotTheOwner();

contract StudentContract {
    // Make owner a state variable with value type address and make it public
    address public s_owner;

    // Have a mapping of address to students, you can give the mapping any name of your choice
    mapping(address => Student) s_addressToStudent;

    // Have a constructor that ensures that owner is equal to the msg.sender
    constructor() {
        s_owner = msg.sender;
    }

    // Have a modifier called onlyOwner and require that msg.sender = owner
    modifier onlyOwner() {
        require(s_owner == msg.sender, "not the owner");
        _;
    }

    // Have a struct to contain details of students
    struct Student {
        address StudentID;
        uint8 percentage; // percentage : 3 digits?
        uint8 Total_Marks; // Total_Marks : How many digits? I guess 2**8 - 1 will be okay
    }

    // Make sure that student cannot register twice
    // Have a function to register students and it should be onlyOwner
    function register(
        address _studentId,
        uint8 _percentage,
        uint8 _total_marks
    ) public onlyOwner {
        require(
            s_addressToStudent[_studentId].StudentID != _studentId,
            "already registered"
        );
        s_addressToStudent[_studentId] = Student(
            _studentId,
            _percentage,
            _total_marks
        );
    }

    // Have a function to get student details and it accepts one argument
    function getStudentDetails(address _studentId)
        public
        view
        returns (Student memory)
    {
        return s_addressToStudent[_studentId];
    }
}
