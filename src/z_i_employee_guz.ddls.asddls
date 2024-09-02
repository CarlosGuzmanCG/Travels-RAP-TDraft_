@AbapCatalog.sqlViewName: 'ZV_EMPL_GUZ'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HCM - Master'
@Metadata.ignorePropagatedAnnotations: true
define root view Z_I_EMPLOYEE_GUZ
  as select from zemployee_guz as HCMMAster
{
  key e_number       as ENumber,
      e_name         as EName,
      e_departament  as EDepartament,
      status         as Status,
      job_title      as JobTitle,
      start_date     as StartDate,
      end_date       as EndDate,
      email          as Email,
      m_number       as MNumber,
      m_name         as MName,
      m_department   as MDepartment,
      crea_date_time as CreaDateTime,
      crea_uname     as CreaUname,
      lchg_date_time as LchgDateTime,
      lchg_uname     as LchgUname
}
