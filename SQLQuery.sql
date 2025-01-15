
-------------Database creation-------------

create database Project
Go

use Project
-- Department Table
-- First, let's modify the Users table to have NO ACTION on delete
-- This will serve as our anchor point for referential integrity
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    Password VARCHAR(200) NOT NULL,
    Email VARCHAR(100),
    DepartmentID INT,
    Type VARCHAR(50),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
        ON DELETE SET NULL  
        ON UPDATE CASCADE   
);

CREATE TABLE Student (
    UserID INT PRIMARY KEY,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE CASCADE  -- Changed to NO ACTION
        ON UPDATE NO ACTION,
    Year INT
);

CREATE TABLE Club (
    ClubID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    SupervisorID INT,
    FOREIGN KEY (SupervisorID) REFERENCES Users(UserID)
        ON DELETE SET NULL  
        ON UPDATE CASCADE   
);

-- Modified Club_Membership to prevent multiple cascade paths
CREATE TABLE Club_Membership (
    MembershipID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    ClubID INT,
    JoinDate DATE,
    Mem_Status VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE CASCADE  -- Changed to NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (ClubID) REFERENCES Club(ClubID)
        ON DELETE CASCADE    -- Keep CASCADE for club deletion
        ON UPDATE NO ACTION
);

CREATE TABLE LocationTypes (
    TypeID INT PRIMARY KEY IDENTITY(1,1),
    LocationType TEXT
);

CREATE TABLE Location (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    LocName VARCHAR(100) NOT NULL,
    Capacity INT,
    TypeID INT,
    StartTime TIME,
    EndTime TIME,
    FOREIGN KEY (TypeID) REFERENCES LocationTypes(TypeID)
        ON DELETE SET NULL  
        ON UPDATE CASCADE   
);

CREATE TABLE EventCategories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryType TEXT
);

CREATE TABLE Event (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(100) NOT NULL,
    Description TEXT,
    StartDate DATE,
    EndDate DATE,
    EventCategory INT,
    LocationID INT,
    CreatedBy INT,
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
        ON DELETE SET NULL  
        ON UPDATE CASCADE,
    FOREIGN KEY (EventCategory) REFERENCES EventCategories(CategoryID)
        ON DELETE SET NULL  
        ON UPDATE CASCADE,
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
        ON DELETE SET NULL  
        ON UPDATE CASCADE   
);

CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    LocationID INT,
    StartTime TIME,
    EndTime TIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE CASCADE  -- Changed to NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
);

CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    EventID INT,
    CheckInTime TIME,
    Status VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE CASCADE  -- Changed to NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
);

CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    EventID INT,
    Ratings INT,
    Comments TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE CASCADE  -- Changed to NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
);

CREATE TABLE RegisteredEvents (
    RegistrationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    EventID INT,
    RegistrationDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE CASCADE  -- Changed to NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
);
-- Insert Sample Data

-- Department Data
INSERT INTO Department ( Name) VALUES
( 'Computer Science'), ( 'Electrical Engineering'),
('Mechanical Engineering'), ( 'Civil Engineering'),
('Business Administration'), ( 'Mathematics'),
( 'Physics'), ( 'Chemistry'),
( 'Biology'), ( 'Environmental Science'),('Administration');

-- User Data
INSERT INTO Users (FName, LName, Password, Email, DepartmentID, Type) 
VALUES
-- Students
('John', 'Doe', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'john.doe@student.com', 1, 'Student'),
('Jane', 'Smith', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'jane.smith@student.com', 2, 'Student'),
('Alice', 'Brown', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'alice.brown@student.com', 3, 'Student'),
('Robert', 'Johnson', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'robert.johnson@student.com', 4, 'Student'),
('Emily', 'Davis', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'emily.davis@student.com', 5, 'Student'),
('Michael', 'Wilson', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'michael.wilson@student.com', 6, 'Student'),
('Sarah', 'Miller', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'sarah.miller@student.com', 7, 'Student'),
('David', 'Taylor', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'david.taylor@student.com', 8, 'Student'),
('Laura', 'Moore', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'laura.moore@student.com', 9, 'Student'),
('Sophia', 'Anderson', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'sophia.anderson@student.com', 10, 'Student'),
('Oliver', 'Brown', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'oliver.brown@student.com', 1, 'Student'),
('Liam', 'Clark', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'liam.clark@student.com', 2, 'Student'),
('Noah', 'Davis', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'noah.davis@student.com', 3, 'Student'),
('Emma', 'Evans', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'emma.evans@student.com', 4, 'Student'),
('Ava', 'Garcia', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'ava.garcia@student.com', 5, 'Student'),
('Isabella', 'Harris', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'isabella.harris@student.com', 6, 'Student'),
('Mia', 'Jones', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'mia.jones@student.com', 7, 'Student'),
('Amelia', 'Martin', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'amelia.martin@student.com', 8, 'Student'),
('Ethan', 'Martinez', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'ethan.martinez@student.com', 9, 'Student'),
('James', 'Rodriguez', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'james.rodriguez@student.com', 10, 'Student'),

-- Faculty Members
('Alan', 'White', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'alan.white@faculty.com', 1, 'Faculty Member'),
('Beth', 'Harris', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'beth.harris@faculty.com', 2, 'Faculty Member'),
('Carol', 'Clark', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'carol.clark@faculty.com', 3, 'Faculty Member'),
('David', 'Lewis', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'david.lewis@faculty.com', 4, 'Faculty Member'),
('Emma', 'Walker', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'emma.walker@faculty.com', 5, 'Faculty Member'),
('Fred', 'Hall', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'fred.hall@faculty.com', 6, 'Faculty Member'),
('Gina', 'Young', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'gina.young@faculty.com', 7, 'Faculty Member'),

-- Admins
('Alice', 'Baker', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'alice.baker@system.com', 11, 'Admin'),
('Brian', 'Carter', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'brian.carter@system.com',11, 'Admin'),
('Charlotte', 'Davis', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'charlotte.davis@system.com', 11, 'Admin');


-- Student Data
INSERT INTO Student ( UserID,Year) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 1),
(6, 2), (7, 3), (8, 4), (9, 1), (10, 2),
(11, 3), (12, 4), (13, 1), (14, 2), (15, 3),
(16, 4), (17, 1), (18, 2), (19, 3), (20, 4);

-- Club Data
INSERT INTO Club (Name, Description, SupervisorID)
VALUES
('Robotics Club', 'A club for students interested in robotics and automation.', 22),
('Art Club', 'A place for art enthusiasts to explore and showcase their creativity.', 24),
('Drama Society', 'A society for students passionate about theater and drama.', 28),
('Coding Club', 'For students who love coding and software development.', 23),
('Environment Club', 'Works towards sustainability and environmental awareness.', 25);


-- Club_Membership Data
INSERT INTO Club_Membership (UserID, ClubID, JoinDate, Mem_Status)
VALUES
(1, 3, '2024-01-15', 'Accepted'),
(2, 5, '2024-02-10', 'Pending'),
(3, 1, '2024-03-05', 'Accepted'),
(4, 4, '2024-03-15', 'Pending'),
(5, 2, '2024-04-01', 'Accepted'),
(6, 3, '2024-01-20', 'Pending'),
(7, 5, '2024-02-12', 'Accepted'),
(8, 1, '2024-03-08', 'Pending'),
(9, 4, '2024-03-20', 'Accepted'),
(10, 2, '2024-04-05', 'Pending'),
(11, 3, '2024-01-25', 'Accepted'),
(12, 5, '2024-02-15', 'Pending'),
(13, 1, '2024-03-10', 'Accepted'),
(14, 4, '2024-03-25', 'Pending'),
(15, 2, '2024-04-10', 'Accepted');

INSERT INTO LocationTypes (LocationType) VALUES
('Classroom'), 
('Lecture Hall'), 
('Conference Room'), 
('Studio'), 
('Theater');
INSERT INTO EventCategories(CategoryType) VALUES
('Workshop'),
('Conference'),
('Seminar'),
('Tournment'),
('Club Meeting'),
('Festival'),
('Exhibition');

-- Inserting 10 new locations into the Location table
INSERT INTO Location (LocName, Capacity, TypeID, StartTime, EndTime) VALUES
('Room F', 35, 1, '08:00', '10:00'),
('Room G', 45, 1, '10:00', '12:00'),
('Room H', 25, 5, '12:00', '14:00'),
('Room I', 60, 2, '14:00', '16:00'),
('Room J', 50, 3, '16:00', '18:00'),
('Room K', 30, 5, '08:00', '10:00'),
('Room L', 40, 1, '10:00', '12:00'),
('Room M', 20, 1, '12:00', '14:00'),
('Room N', 55, 3, '14:00', '16:00'),
('Room O', 70, 5, '16:00', '18:00');

-- Event Data
INSERT INTO Event (Title, Description, StartDate, EndDate, EventCategory, LocationID, CreatedBy)
VALUES
('Tech Conference 2024', 'Annual conference showcasing latest technologies.', '2025-03-15', '2024-03-17',1, 1, 21),
('Art Exhibition', 'An exhibition featuring works by local artists.', '2024-04-10', '2024-04-15', 2, 2, 22),
('Drama Fest', 'A two-day festival celebrating theater and drama.', '2024-05-01', '2024-05-02', 3, 3, 23),
('Coding Hackathon', 'A 24-hour hackathon for coding enthusiasts.', '2024-06-20', '2024-06-21', 3, 4, 24),
('Green Earth Initiative', 'A workshop on sustainability and environmental awareness.', '2024-07-15', '2024-07-15', 4, 5, 25);


-- Inserting records into the Reservation table
INSERT INTO Reservation (UserID, LocationID, StartTime, EndTime) VALUES
(1, 1, '10:00:00', '12:00:00'),
(2, 2, '14:00:00', '16:00:00'),
(3, 3, '08:00:00', '10:00:00'),
(4, 4, '11:00:00', '13:00:00'),
(5, 5, '15:00:00', '17:00:00');
-- Inserting records into the Attendance table
INSERT INTO Attendance (UserID, EventID, CheckInTime, Status) VALUES
(1, 1, '09:30:00', 'Checked In'),
(2, 2, '13:45:00', 'Checked In'),
(3, 3, '07:50:00', 'Checked In'),
(4, 4, '10:30:00', 'Checked In'),
(5, 5, '14:15:00', 'Checked In');
-- Inserting records into the Feedback table
INSERT INTO Feedback (UserID, EventID, Ratings, Comments) VALUES
(1, 1, 5, 'Excellent event, highly informative!'),
(2, 2, 4, 'Good event, but the timing could be better.'),
(3, 3, 3, 'It was an okay experience.'),
(4, 4, 2, 'Not what I expected, could use improvements.'),
(5, 5, 5, 'Great event, I will definitely attend again!');
INSERT INTO RegisteredEvents (UserID,EventID,RegistrationDate,Status) VALUES
(1, 2, '2025-12-26', 'Registered'),
(2, 3, '2025-12-20', 'Cancelled'),
(3, 4, '2024-12-22', 'Registered'),
(4, 5, '2025-01-05', 'Registered'),
(5, 1, '2024-12-18', 'Registered');