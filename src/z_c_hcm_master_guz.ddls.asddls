@EndUserText.label: 'HCM - Master'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity z_c_hcm_master_guz
  as projection on z_i_hcm_master_guz
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
