-- Creating the Patient table with constraints and primary key
CREATE TABLE Patient
    (Patient_ID         INT         NOT NULL,
     Patient_Name       VARCHAR(30) NOT NULL,
     Blood_Group        VARCHAR(4)  NOT NULL,
     Disease            CHAR(2)
                CHECK (Disease IN('A','B','AB','O')),
     Patient_Contact    NUMBER(10,0),
     Patient_Address    VARCHAR(45),
CONSTRAINT Patient_PK PRIMARY KEY (Patient_ID));

-- Creating the Donor table with constraints and primary key
CREATE TABLE Donor
    (Donor_ID           INT         NOT NULL,
     Donor_Name         VARCHAR(30) NOT NULL,
     Medical_Report     VARCHAR(20) NOT NULL
                CHECK (Medical_Report IN('Satisfactory','Not Satisfactory')),
     Donor_Addresss     VARCHAR(45),
     Donor_Contact      NUMBER(10,0),
CONSTRAINT Donor_PK PRIMARY KEY (Donor_ID));

-- Creating the Blood_Bank table with constraints, foreign keys, and primary key
CREATE TABLE Blood_Bank
    (Blood_Bank_ID      INT             NOT NULL,
     Blood_Bank_Name    VARCHAR(50)     NOT NULL,
     Blood_Bank_Address VARCHAR(45),
     Blood_Bank_Contact NUMBER(10,0),
     Donor_ID           INT,
     Patient_ID         INT,
CONSTRAINT Blood_Bank_PK PRIMARY KEY (Blood_Bank_ID),
CONSTRAINT Blood_Bank_FK1 FOREIGN KEY (Donor_ID)  REFERENCES Donor(Donor_ID),
CONSTRAINT Blood_Bank_FK2 FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID));

-- Inserting data into the Patient table
INSERT INTO Patient VALUES (101,'Rahul Patel','AB+','O',7778889999,'101 Mumbai') ;
INSERT INTO Patient VALUES (102,'Amy Smith','B+','AB',8889999777,'102 New York') ;
INSERT INTO Patient VALUES (103,'Suresh Kumar','0-','A',6669999777,'103 Bangalore') ;
INSERT INTO Patient VALUES (104,'Emily Johnson','AO','B',8885559777,'104 Chicago') ;
INSERT INTO Patient VALUES (105,'Priya Sharma','A+','O',1119999777,'105 Delhi') ;

-- Inserting data into the Donor table
INSERT INTO Donor VALUES (201,'Amit Gupta','Satisfactory','201 Jaipur',1112223333);
INSERT INTO Donor VALUES (202,'Brian Miller','Not Satisfactory','202 Los Angeles',2223334444);
INSERT INTO Donor VALUES (203,'Ananya Reddy','Satisfactory','203 Hyderabad',3334445555);
INSERT INTO Donor VALUES (204,'David Brown','Not Satisfactory','204 Houston',4445556666);
INSERT INTO Donor VALUES (205,'Kavya Patel','Satisfactory','205 Ahmedabad',5556667777);

-- Inserting data into the Blood_Bank table
INSERT INTO Blood_Bank Values (301,'Mumbai Blood Bank','301 Mumbai','6667778888',201,101);
INSERT INTO Blood_Bank Values (302,'Los Angeles Blood Bank','302 Los Angeles','7778889999',203,102);
INSERT INTO Blood_Bank Values (303,'Hyderabad Blood Bank','303 Hyderabad','8889991111',205,103);
INSERT INTO Blood_Bank Values (304,'Houston Blood Bank','304 Houston','9991112222',205,104);
INSERT INTO Blood_Bank Values (305,'Ahmedabad Blood Bank','305 Ahmedabad','1112223333',203,105);

-- Selecting patient information based on Patient_ID
SELECT Patient_Name,Blood_Group,Disease
FROM Patient
WHERE Patient_ID = 101;

-- Selecting donor information based on Medical_Report
SELECT Donor_Name,Donor_Addresss,Donor_Contact,Medical_Report
FROM Donor
WHERE Medical_Report = 'Satisfactory';

-- Selecting patient and blood bank information based on patient_id
SELECT Patient_Name,Blood_Group,Blood_Bank_Name,blood_bank.patient_id,patient.patient_id
FROM Patient, Blood_Bank
WHERE blood_bank.patient_id = patient.patient_id;

-- Selecting donor, blood bank, and donor information based on donor_id
SELECT Donor_Name,Medical_Report,Donor_Addresss,donor.donor_id,Blood_Bank_Name
FROM Donor,Blood_Bank
WHERE blood_bank.donor_id = donor.donor_id;

-- Selecting blood bank, patient information based on patient_id
SELECT Blood_Bank_Name, Blood_Bank_Contact,Patient_Name,Patient.Patient_id
FROM Blood_Bank, Patient
WHERE patient.patient_id = blood_bank.patient_id;

-- Selecting patient, donor, blood bank information based on patient_id and donor_id
SELECT Patient_Name, Donor_Name, Blood_Bank_Name, Blood_Group, Medical_Report
FROM Blood_Bank,Patient,Donor
WHERE blood_bank.patient_id = patient.patient_id AND blood_bank.donor_id = donor.donor_id;

-- Selecting donor information with left outer join on Blood_Bank
SELECT Donor_Name, Donor.Donor_ID, Blood_Bank.Donor_ID
FROM Donor LEFT OUTER JOIN  Blood_Bank
ON Blood_Bank.Donor_ID = donor.donor_id
GROUP BY blood_bank.donor_id;

