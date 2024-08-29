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

    GET TIME STAMP FIELD DATA(lv_time_stamp). "
    DATA(lv_uname) = cl_abap_context_info=>get_user_technical_name( ).

    SELECT MAX( e_number ) FROM zhcm_master_guz INTO @DATA(lv_max_employee_number).

    LOOP AT entities INTO DATA(ls_entities).

      ls_entities-%data-CreaDateTime = lv_time_stamp.
      ls_entities-%data-CreaUname = lv_uname.
      ls_entities-%data-ENumber = lv_max_employee_number + 1.

      INSERT VALUE #( flag = lcl_buffer=>created
                      data = CORRESPONDING #( ls_entities-%data ) )
        INTO TABLE lcl_buffer=>mt_buffer_master_guz.

      "mapped-hcmmaster
      IF NOT ls_entities-%cid IS INITIAL.
         INSERT VALUE #( %cid = ls_entities-%cid
                         ENumber = ls_entities-ENumber )
           INTO TABLE mapped-hcmmaster.
      ENDIF.

    ENDLOOP.

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

  DATA:
   lt_data_created type standard table of zhcm_master_guz.

   lt_data_created = VALUE #( FOR <row> IN lcl_buffer=>mt_buffer_master_guz
                              WHERE ( flag = lcl_buffer=>created ) ( <row>-data ) ).

   IF NOT lt_data_created IS INITIAL.
        INSERT zhcm_master_guz FROM TABLE @lt_data_created.
   ENDIF.

   CLEAR lcl_buffer=>mt_buffer_master_guz.

  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
