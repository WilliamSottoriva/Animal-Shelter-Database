/* (Database Fundamentals, Assignment Part D, Autumn  2020 */
/* First author's name: William Sottoriva (24505063)*/
/* First author's email: William.Sottoriva@student.uts.edu.au*/
/* Second author's name: Dylan Huynh (24504870)*/
/* Second author's email: Dylan.L.Huynh@student.uts.edu.au*/
/* Third author's name: Justin Ngo (24506622)*/
/* Third author's email: justin.ngo@student.uts.edu.au*/
/* script name: PartD.SQL */
/* purpose:     Builds PostgreSQL tables for RSPCA adoption management database */
/* date:        15 10 2022 */
/* The URL for the website related to this database is https://www.rspca.org.au/adopt-pet */

--=================================================================================================
-- Drop the tables below
drop table if exists Booking_T;
drop table if exists Previous_Surrender_T;
drop table if exists Birds_And_Reptiles_T;
drop table if exists Children_T;
drop table if exists Existing_Animal_T;
drop table if exists Renting_T;
drop table if exists Application_Approval_T;
drop table if exists Application_T;
drop table if exists Animal_T;
drop table if exists Specialises_T;
drop table if exists Animal_Type_T;
drop table if exists Applicant_T;
drop table if exists Employee_T;
drop table if exists Available_T;
drop table if exists Animal_Location_T;
drop table if exists Availabilities_T;

--=================================================================================================
-- Create and insert into the tables below

create table Animal_Location_T
(
    locationId                                      int             not null,
    locationUnitNumber                              varchar(5),
    locationStreet                                  varchar(100),
    locationSuburb                                  varchar(100),
    locationState                                   varchar(100),
    locationPostCode                                int,
    locationPhoneNumber                             varchar(10),
    locationType                                    varchar(1),

    Constraint Animal_Location_PK PRIMARY KEY (locationId)
);

INSERT INTO Animal_Location_T VALUES
(1, 6, 'Milperra Rd', 'Bankstown', 'NSW', 2200, 0417253837, 'S'),
(2, 7, 'Warrigal Rd', 'Chadstone', 'VIC', 3148, 0457727544, 'F'),
(3, 8, 'John St', 'Cabramatta West', 'NSW', 2166, 0418089831, 'S'),
(4, 9, 'Dalrymple Rd', 'Garbutt', 'QLD', 4814, 0447297028, 'F'),
(5, 10, 'Breakfast Creek Rd', 'Newstead', 'QLD', 4006, 0477808713, 'S');

create table Animal_Type_T
(
    animalTypeId                                    int            not null,
    parentId                                        int,
    animalType                                      varchar(100),                                      

    Constraint Animal_Type_PK PRIMARY KEY (animalTypeId),
    Constraint Animal_Type_FK1 FOREIGN KEY (parentId) References Animal_Type_T (animalTypeId)

);

INSERT INTO Animal_Type_T VALUES
(1, null, 'Dog'),
(2, null, 'Cat'),
(3, null, 'Bird'),
(4, null, 'Rabbit'),
(5, null, 'Reptile'),
(6, 5, 'Snake'),
(7, 5, 'Lizard'),
(8, 5, 'Turtle');

create table Animal_T
(
    animalId                                        int             not null, 
    locationId                                      int,
    animalTypeId                                    int,                                    
    animalName                                      varchar(30),
    animalBreed                                     varchar(30),
    animalDateOfBirth                               date,
    animalSex                                       varchar(6),
    animalWeight                                    decimal(30, 10),
    animalSize                                      varchar(6),
    animalColour                                    varchar(30), 
    animalImage                                     varchar(100), 
    animalVaccinated                                char(1), 
    animalMicrochipped                              char(1), 
    animalWorming                                   char(1),
    animalDesexed                                   char(1), 
    animalDescription                               varchar(500),  
    animalRehomingOrganisationNumber                int, 
    
    Constraint Animal_PK PRIMARY KEY (animalId),
    Constraint Animal_FK1 FOREIGN KEY (locationId) References Animal_Location_T (locationId),
    Constraint Animal_FK2 FOREIGN KEY (animalTypeId) References Animal_Type_T (animalTypeId)
);

INSERT INTO Animal_T VALUES
(1, 1, 1, 'Killer', 'Bulldog', '6/2/2019', 'Male', 23.1, 'Large', 'White', 'killer.png', 'y', 'y', 'y', 'y', 'Killer is a very nice and friendly dog who loves to play. He is social and likes going on walks.', 213678),
(2, 2, 2, 'Kane', 'Domestic Short Hair', '12/5/2020', 'Male', 4.5, 'Small', 'Grey Tabby', 'kane.png', 'y', 'y', 'y', 'y', 'Kane enjoys pats when accompanied with food and often sits at the front of his cage to ask for treats.', 795684),
(3, 3, 3, 'Poppy', 'Alexandrine Parrot', '7/22/2001', 'Female', 0.12, 'Small', 'Green/Red', 'poppy.png', 'y', 'n', 'y', 'n', 'Poppy requires a large free flight aviary, she would feel more comfortable having her own space and to be in a aviary that gives her enough space to fly.', null),
(4, 4, 4, 'Winter', 'Netherland Dwarf', '3/8/2014', 'Female', 2.5, 'Small', 'White', 'winter.png', 'y', 'n', 'y', 'y', 'Winter can be a little proactive of her food, so she is best going to a home with children under the age of 12.', 283674),
(5, 5, 5, 'Medusa', 'Albino Carpet Python', '9/19/2011', 'Female', 10, 'Large', 'White', 'medusa.png', 'y', 'n', 'y', 'n', 'Medusa is hook trained, and can be handled. She is currently being fed in a seperate tube with no issues.', 567890);


create table Applicant_T
(
    applicantEmailAddress                           varchar(100)   not null,
    applicantFirstName                              varchar(30),
    applicantLastName                               varchar(30),
    applicantTitle                                  char(10),
    applicantUnitNumber                             varchar(100),
    applicantStreet                                 varchar(100),
    applicantSuburb                                 varchar(80), 
    applicantState                                  varchar(100), 
    applicantPostCode                               varchar(4),
    applicantPhoneNumber                            varchar(10), 
    applicantDateOfBirth                            date, 
    applicantDocumentationNumber                    int, 
    applicantDriversLicenceImg                      varchar(20), 
    applicantSecondaryContactFirstName              varchar(30),
    applicantSecondaryContactLastName               varchar(30),

    Constraint Applicant_PK PRIMARY KEY (applicantEmailAddress)
);

INSERT INTO Applicant_T VALUES
('maverick.giffard193@gmail.com', 'Maverick', 'Giffard', 'Mr', 24, 'Roslyn St', 'Liverpool', 'NSW', 2170, 0427852547, '05/22/1984', 524873, '1.png', 'Olivia', 'McAlister'),
('great_gatsby82@outlook.com', 'Helena', 'Gatsby', 'Ms', 38, 'Leopold St', 'Mittagong', 'NSW', 2575, 0468157398, '2/10/1972', 123908, '2.png', 'Donnchadh', 'Abbatantuono'),
('randal.pierson345@gmail.com', 'Randal', 'Pierson', 'Mr', 7, 'Newman St', 'Cooktown', 'QLD', 4895, 0415777456, '8/30/2000', 438903, '3.png', 'Yeong-Hui', 'Olsen'),
('irini.mccoy555@gmail.com', 'Irini', 'McCoy', 'Ms', 13, 'Jacqueline Pl', 'Pakenham', 'VIC', 3810, 0416899111, '11/11/2002', 324987, '4.png', 'Ogechukwu', 'Filipowski'),
('tygo.cunningham@gmail.com', 'Tygo', 'Cunningham', 'Mr', 1, 'Deacon St', 'Eromanga', 'QLD', 4480, 0499752223, '3/19/1992', 988674, '5.png', 'Johann', 'Krauss'),
('oyku.cuijpers88@gmail.com', 'Öykü', 'Cuijpers', 'Mr', 12, 'Peter St', 'Blacktown', 'NSW', 2148, 0496552823, '3/19/1993', 124672, '6.png', 'Bob', 'Steve'),
('my.vo595@gmail.com', 'Mỹ', 'Võ', 'Ms', 22, 'Old Castle Hill Rd', 'Castle Hill', 'NSW', 2154, 0493762923, '4/18/1992', 345789, '7.png', 'John', 'Pete'),
('cleopatre.zuraw@gmail.com', 'Cléopâtre', 'Żuraw', 'Ms', 40, 'Macquarie St', 'Russell', 'ACT', 2600, 0491822673, '9/22/1994', 243980, '8.png', 'Gertrude', 'Nancy');

create table Application_T
(   
    applicationId                                   int             not null,
    animalId                                        int             not null, 
    applicantEmailAddress                           varchar(100)    not null,
    applicationFastPickUp                           char(1)      not null,
    applicationReasonForAdoption                    varchar(100)    not null,
    applicationPeriodToSettle                       varchar(500)    not null,
    applicationHoursAlone                           int             not null,
    applicationEnvironmentInformation               varchar(1000)   not null,
    applicationOpenToSuggestions                    char(1)         not null,
    applicationDesiresDescription                   varchar(500)    not null,
    applicationDwellingOwnership                    char(1)         not null,
    applicationDwellingType                         varchar(500)    not null,
    applicationAnimalHouseingLocation               varchar(500)    not null,
    applicationFenceDescription                     varchar(1000)   not null,
    applicationYardImage                            varchar(20)     not null,
    applicationPreviousOwnershipDetails             varchar(1000)   not null,
    applicationType                                 varchar(5),
    
    Constraint Application_PK PRIMARY KEY (applicationId),
    Constraint Application_FK1 FOREIGN KEY (animalId) References Animal_T (animalId),
    Constraint Application_FK2 FOREIGN KEY (applicantEmailAddress) References Applicant_T (applicantEmailAddress)
);

INSERT INTO Application_T VALUES
(1, 1, 'randal.pierson345@gmail.com', 'y', 'adoption description', 'settle description', 5, 'environment description', 'y', 'desires description', 'y', 'dwelling type description', 
'housing location', 'fence description', 'yard.png', 'previous ownership', 'CPRE'),
(2, 2, 'maverick.giffard193@gmail.com', 'y', 'adoption description', 'settle description', 9, 'environment description', 'n', 'desires description', 'n', 'dwelling type description', 
'housing location', 'fence description', 'yard.png', 'previous ownership', 'CPRE'),
(3, 3, 'great_gatsby82@outlook.com','y', 'adoption description', 'settle description', 2, 'environment description', 'y', 'desires description', 'n', 'dwelling type description', 
'housing location', 'fence description', 'yard.png', 'previous ownership', 'CPREB'),
(4, 4, 'irini.mccoy555@gmail.com', 'n', 'adoption description', 'settle description', 4, 'environment description', 'y', 'desires description', 'y', 'dwelling type description', 
'housing location', 'fence description', 'yard.png', 'previous ownership', 'CPRE'),
(5, 5, 'tygo.cunningham@gmail.com', 'n', 'adoption description', 'settle description', 0, 'environment description', 'n', 'desires description', 'y', 'dwelling type description', 
'housing location', 'fence description', 'yard.png', 'previous ownership', 'CPREB'),
(6, 5, 'oyku.cuijpers88@gmail.com', 'n', 'adoption description', 'settle description', 1, 'environment description', 'n', 'desires description', 'y', 'dwelling type description', 
'housing location', 'fence description', 'yard.png', 'previous ownership', 'B'),
(7, 5, 'my.vo595@gmail.com', 'y', 'adoption description', 'settle description', 5, 'environment description', 'y', 'desires description', 'y', 'dwelling type description', 
'housing location', 'fence description', 'yard.png', 'previous ownership', 'B'),
(8, 5, 'cleopatre.zuraw@gmail.com', 'n', 'adoption description', 'settle description', 9, 'environment description', 'y', 'desires description', 'y', 'dwelling type description', 
'housing location', 'fence description', 'yard.png', 'previous ownership', 'B');



create table Previous_Surrender_T
(
    applicationId                                   int             not null,
    applicationPreviousSurrenderDetails             varchar(1000),

    Constraint Previous_Surrender_PK PRIMARY KEY (applicationId),
    Constraint Previous_Surrender_FK1 FOREIGN KEY (applicationId) References Application_T (applicationId)
);

INSERT INTO Previous_Surrender_T VALUES
(1, 'Previous surrender details'),
(2, 'Previous surrender details'),
(3, 'Previous surrender details'),
(4, 'Previous surrender details'),
(5, 'Previous surrender details');

create table Renting_T
(
    applicationId                                   int             not null,
    applicationAnimalApproval                       varchar(100),

    Constraint Renting_PK PRIMARY KEY (applicationId),
    Constraint Renting_FK1 FOREIGN KEY (applicationId) References Application_T (applicationId)
);

INSERT INTO Renting_T VALUES
(1, 'animal_approval.png'),
(2, 'animal_approval.png'),
(3, 'animal_approval.png'),
(4, 'animal_approval.png'),
(5, 'animal_approval.png');

create table Birds_And_Reptiles_T
(
    applicationId                                   int             not null,
    applicationEnclosureImage                       varchar(100),

    Constraint Birds_And_Reptiles_PK PRIMARY KEY (applicationId),
    Constraint Birds_And_Reptiles_FK1 FOREIGN KEY (applicationId) References Application_T (applicationId)
);

INSERT INTO Birds_And_Reptiles_T VALUES
(5, 'enclosure1.png'),
(3, 'enclosure2.png'),
(6, 'enclosure3.png'),
(7, 'enclosure4.png'),
(8, 'enclosure5.png');

create table Children_T
(
    applicationId                                   int             not null,
    applicationChildrenAges                         varchar(100),

    Constraint Children_PK PRIMARY KEY (applicationId),
    Constraint Children_FK1 FOREIGN KEY (applicationId) References Application_T (applicationId)
);

INSERT INTO Children_T VALUES
(1, '12, 16'),
(2, '6, 17'),
(3, '14, 20'),
(4, '5, 22'),
(5, '6, 16');

create table Existing_Animal_T
(
    applicationId                                   int             not null,
    applicationExistingAnimals                      int,
    applicationExistingAnimalsDetails               varchar(1000),

    Constraint Existing_Animal_PK PRIMARY KEY (applicationId),
    Constraint Existing_Animal_FK1 FOREIGN KEY (applicationId) References Application_T (applicationId)
);

INSERT INTO Existing_Animal_T VALUES
(1, 1, 'Existing animals'),
(2, 2, 'Existing animals'),
(3, 0, 'Existing animals'),
(4, 2, 'Existing animals'),
(5, 4, 'Existing animals');

create table Employee_T
(
    employeeId                                      int            not null,
    locationId                                      int,
    employeeFirstName                               varchar(30),
    employeeLastName                                varchar(30),
    employeeContactNumber                           varchar(11),
    employeeEmail                                   varchar(100),

    Constraint Employee_PK PRIMARY KEY (employeeId),
    Constraint Employee_FK1 FOREIGN KEY (locationId) References Animal_Location_T (locationId) 
);

INSERT INTO Employee_T VALUES
(1, 1, 'Omar', 'Dirksen', 0476502865, 'omar.dirksen31@gmail.com'),
(2, 4, 'Tyson', 'Grossi', 0447363183, 'tyson.grossi0384@gmail.com'),
(3, 3, 'Artemidoros', 'Triggs', 0436221535, 'artemidoros.triggs94@gmail.com'),
(4, 2, 'Cunobelinos', 'Kato', 0482988131, 'cunobelinos.kato38@gmail.com'),
(5, 5, 'Lenart', 'Forsberg', 0413923064, 'lenart.forsberg778@gmail.com');

create table Availabilities_T
(
    availabilityId                                  int            not null,
    availabilityTime                                time           not null,
    availabilityDate                                date           not null,

    Constraint Availabilities_PK PRIMARY KEY (availabilityId)
);

INSERT INTO Availabilities_T VALUES
(1,'10:29', '4/7/2022'),
(2,'9:21', '8/12/2022'),
(3,'8:30', '4/9/2022'),
(4,'12:29', '11/11/2022'),
(5,'16:29', '2/3/2022');

create table Booking_T
(
    bookingDate                                     date            not null,
    bookingTime                                     time            not null,
    applicantEmailAddress                           varchar(100)    not null,
    animalId                                        int             not null,
    employeeId                                      int,
    locationId                                      int,

    Constraint Booking_PK PRIMARY KEY (bookingDate,bookingTime,applicantEmailAddress,animalId),
    Constraint Booking_FK1 FOREIGN KEY (applicantEmailAddress) References Applicant_T (applicantEmailAddress),
    Constraint Booking_FK2 FOREIGN KEY (animalId) References Animal_T (animalId),
    Constraint Booking_FK3 FOREIGN KEY (employeeId) References Employee_T (employeeId),
    Constraint Booking_FK4 FOREIGN KEY (locationId) References Animal_Location_T (locationId)
);

INSERT INTO Booking_T VALUES
('6/1/2022', '9:30', 'maverick.giffard193@gmail.com', 4, 2, 4),
('7/1/2022', '10:00', 'randal.pierson345@gmail.com', 1, 1, 1),
('8/1/2022', '11:30', 'irini.mccoy555@gmail.com', 1, 1, 1),
('9/1/2022', '18:00', 'great_gatsby82@outlook.com', 4, 2, 4),
('10/1/2022', '8:30', 'tygo.cunningham@gmail.com', 4, 2, 4);


create table Available_T
(
    availabilityId                                  int             not null,
    locationId                                      int             not null,
    
    Constraint Available_PK PRIMARY KEY (availabilityId, locationId),
    Constraint Available_FK1 FOREIGN KEY (availabilityId) References Availabilities_T (availabilityId),
    Constraint Available_FK2 FOREIGN KEY (locationId) References Animal_Location_T (locationId)
);

INSERT INTO Available_T VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 1),
(5, 5);


create table Specialises_T
(
    animalTypeId                                    int             not null,
    employeeId                                      int             not null,

    Constraint Specialises_PK PRIMARY KEY (animalTypeId,employeeId),
    Constraint Specialises_FK1 FOREIGN KEY (animalTypeId) References Animal_Type_T (animalTypeId),
    Constraint Specialises_FK2 FOREIGN KEY (employeeId) References Employee_T (employeeId)
);

INSERT INTO Specialises_T VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

create table Application_Approval_T
(
    applicationId                                   int              not null           unique,
    applicationDateReviewed                         date             not null,
    applicationApproved                             char(1),

    Constraint Application_Approval_PK PRIMARY KEY (applicationId,applicationDateReviewed),
    Constraint Application_Approval_FK2 FOREIGN KEY (applicationId) References Application_T (applicationId)
);

INSERT INTO Application_Approval_T VALUES
(1, '3/8/2022', 'n'),
(2, '3/9/2022', 'y'),
(3, '9/23/2022', 'y'),
(4, '2/10/2022', 'n'),
(5, '10/15/2022', 'y');

--=================================================================================================
-- Select * from TableName Statements
-- Note: Please write the “select * from TableName” statements in one line.

-- 2.b.1: Question: Get all information of all applicants 
-- 2.b.1: SELECT statement: 
SELECT * FROM Applicant_T;

-- 2.b.2: Question: Get all information of all animals at shelters
-- 2.b.2: SELECT statement:
SELECT * FROM Animal_T;

-- 2.b.3: Question: Get all information of all employees
-- 2.b.3: SELECT statement:
SELECT * FROM Employee_T;

--=================================================================================================
-- 3.a: Question: How many applicants live in what state?
-- 3.a: SELECT statement using Group by:
SELECT applicantState, count(*) from Applicant_T group by applicantState;

-- 3.b: Question: Find out where each employee works.
-- 3.b: SELECT statement using Inner Join:
SELECT * FROM Employee_T INNER JOIN Animal_Location_T ON Employee_T.locationId = Animal_Location_T.locationId;

-- 3.c: Question: Display the animalName, animalBreed, 
-- 3.c: SELECT statement using Sub Query:
SELECT animalName, animalBreed, animalSex, animalDescription from Animal_T where animalId = ANY(SELECT animalId from Application_T where applicationFastPickUp = 'y');


