-- Course Catalog Case study Table Create-Insert script

create table CourseCatalog (
CourseID int IDENTITY(1,1) PRIMARY KEY,
CourseCode varchar(20),
CourseName varchar(100),
SkillName varchar(100),
ProficiencyLevel int,
LicenseNeededYN char(3),
ActivityType varchar(50),
Description varchar(200),
CreateDate datetime,
IsActiveYN char(3)
);



insert into CourseCatalog values ('AZ001', 'Azure Cosmos DB', 'Azure Data Engineer', 3, 'Y', 'Elearning', 'Azure Cosmos DB architecture and concepts', getdate(), 'Y')
insert into CourseCatalog values ('AZ002', 'Azure Databricks', 'Azure Data Engineer', 4, 'Y', 'Elearning', 'Azure Databricks flow and concepts', getdate(), 'Y')
insert into CourseCatalog values ('AZ003', 'Azure HDInsight', 'Azure Data Engineer', 2, 'Y', 'Elearning', 'Azure HDInsight architecture and concepts', getdate(), 'N')
insert into CourseCatalog values ('AZ004', 'Azure Stream Analytics', 'Azure Data Engineer', 5, 'Y', 'Elearning', 'Azure Stream analytics steps and connectivity features', getdate(), 'Y')
insert into CourseCatalog values ('AZ005', 'Azure DataFactory', 'Azure Data Engineer', 2, 'Y', 'Classroom', 'Azure Data factory creation and tempalte formation', getdate(), 'Y')
insert into CourseCatalog values ('AZ006', 'Azure Devops', 'Azure Data Engineer', 2, 'N', 'Classroom', 'Azure Devops configuration and maintenance', getdate(), 'Y')
insert into CourseCatalog values ('AZ007', 'Azure MachineLearning', 'Azure Data Engineer', 3, 'N', 'Elearning', 'Azure Machine learning algorithms and statistics definition', getdate(), 'Y')

select * from CourseCatalog