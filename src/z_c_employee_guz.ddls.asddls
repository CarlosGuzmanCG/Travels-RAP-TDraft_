@EndUserText.label: 'Employee'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity Z_C_EMPLOYEE_GUZ
  as projection on Z_I_EMPLOYEE_GUZ
{
      //@ObjectModel.text.element: [ 'EmployeeName' ]
  key ENumber      as EmployeeNumber,
      EName        as EmployeeName,
      EDepartament as EmployeeDepartment,
      Status       as EmployeeStatus,
      JobTitle     as JobTitle,
      StartDate    as StartDate,
      EndDate      as EndDate,
      Email        as Email,
      //@ObjectModel.text.element: [ 'ManagerName' ]
      MNumber      as ManagerNumber,
      MName        as ManagerName,
      MDepartment  as ManagerDepartment,
      CreaDateTime as CreatedOn,
      @Semantics.user.createdBy: true
      CreaUname    as CreatedBy,
      LchgDateTime as ChangeOn,
      @Semantics.user.lastChangedBy: true
      LchgUname    as ChangedBy
}
