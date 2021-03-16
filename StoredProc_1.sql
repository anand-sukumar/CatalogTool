-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name> Anand Sukumar
-- Create date: <Create Date,,> Mar 16, 2021
-- Description:	<Description,,> Fetch the Course Catalog details based on filters applied
-- =============================================

--exec USP_GetCourseDetails @CourseName='Azure Databricks'
ALter PROCEDURE USP_GetCourseDetails
@CourseName varchar(200) = '',
@SkillName varchar(200) = '',
@ProficiencyLevel int = 0,
@CourseCode varchar(200) = '',
@CourseDescription varchar(200) = '',
@LicenseNeeded varchar(20) = '',
@ActivityType varchar(200) = ''
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET ANSI_NULLS OFF
	SET QUOTED_IDENTIFIER OFF
	
	Declare @DynamicQuery varchar(max) = '';
	Declare @vstrFiltCriteria varchar(max) = '';

	IF(@CourseName not in ('','string'))
	BEGIN
		SET @vstrFiltCriteria = @vstrFiltCriteria + ' AND CC.CourseName IN ('''+@CourseName+''')'
	END

	IF(@SkillName not in ('','string'))
	BEGIN
		SET @vstrFiltCriteria = @vstrFiltCriteria + ' AND CC.SkillName IN ('''+@SkillName+''')'
	END

    IF(@ProficiencyLevel <> 0)
	BEGIN
		SET @vstrFiltCriteria = @vstrFiltCriteria + ' AND CC.ProficiencyLevel = ' + cast(@ProficiencyLevel as varchar)
	END

	IF(@CourseCode not in ('','string'))
	BEGIN
		SET @vstrFiltCriteria = @vstrFiltCriteria + ' AND CC.CourseCode IN ('''+@CourseCode+''')'
	END

	IF(@CourseDescription not in ('','string'))
	BEGIN
		SET @vstrFiltCriteria = @vstrFiltCriteria + ' AND CC.Description LIKE (''%'+@CourseDescription+'%'')'
	END

	IF(@LicenseNeeded not in ('','string'))
	BEGIN
		SET @vstrFiltCriteria = @vstrFiltCriteria + ' AND CC.LicenseNeededYN IN ('''+@LicenseNeeded+''')'
	END

	IF(@ActivityType not in ('','string'))
	BEGIN
		SET @vstrFiltCriteria = @vstrFiltCriteria + ' AND CC.ActivityType IN ('''+@ActivityType+''')'
	END

	SET @DynamicQuery = 'Select CC.CourseCode, CC.CourseName, CC.SkillName, CC.Description, CC.ProficiencyLevel, CC.ActivityType, CC.LicenseNeededYN, CC.CreateDate from CourseCatalog CC
	where CC.IsActiveYN = ''Y'' '
	SET @DynamicQuery = @DynamicQuery + @vstrFiltCriteria
	SET @DynamicQuery = @DynamicQuery + 'order by 8'; 

	Print(@DynamicQuery)
	EXEC(@DynamicQuery)
END
GO

