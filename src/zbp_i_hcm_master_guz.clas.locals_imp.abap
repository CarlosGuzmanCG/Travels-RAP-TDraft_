CLASS lhc_HCMMaster DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS: create FOR MODIFY
                IMPORTING entities FOR CREATE HCMMaster.

    METHODS: update FOR MODIFY
                IMPORTING entities FOR UPDATE HCMMaster.

    METHODS: delete FOR MODIFY
                IMPORTING keys FOR DELETE HCMMaster.

    METHODS: read FOR READ
                IMPORTING keys FOR READ HCMMaster RESULT result.

ENDCLASS.

CLASS lhc_HCMMaster IMPLEMENTATION.

  METHOD create.



  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_Z_I_HCM_MASTER_GUZ DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION. "polymorphism

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_Z_I_HCM_MASTER_GUZ IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
