CLASS lcl_buffer DEFINITION.

  PUBLIC SECTION.

    CONSTANTS: created TYPE c LENGTH 1 VALUE 'C',
               updated TYPE c LENGTH 1 VALUE 'U',
               deleted TYPE c LENGTH 1 VALUE 'D'.

    TYPES: BEGIN OF ty_buffer_master,
             data TYPE zhcm_master_guz.
    TYPES: flag TYPE c LENGTH 1,
           END OF ty_buffer_master.

    TYPES: tt_master TYPE SORTED TABLE OF ty_buffer_master WITH UNIQUE KEY data-e_number.

    CLASS-DATA mt_buffer_master_guz TYPE tt_master. "save data

ENDCLASS.

CLASS lcl_buffer IMPLEMENTATION.

ENDCLASS.

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
