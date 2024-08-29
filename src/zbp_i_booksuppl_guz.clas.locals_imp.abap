CLASS lhc_Supplement DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateTotalSupplPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Supplement~calculateTotalSupplPrice.

ENDCLASS.

CLASS lhc_Supplement IMPLEMENTATION.

  METHOD calculateTotalSupplPrice.

    if not keys is initial.

    zcl_aux_travel_det_cg=>calculate_price( it_travel_id = value #( for groups <booking_suppl> of booking_key in keys
                                            group by booking_key-travel_id without members ( <booking_suppl> ) ) ).

    endif.

  ENDMETHOD.

ENDCLASS.

class lsc_supplement DEFINITION INHERITING FROM cl_abap_behavior_saver.

    public section.

        CONSTANTS: create type string value 'C',
                   update type string value 'U',
                   delete type string value 'D'.

    PROTECTED SECTION.

    methods save_modified REDEFINITION.

endclass.

CLASS lsc_supplement IMPLEMENTATION.

  METHOD save_modified.

    data: lt_supplements type STANDARD TABLE OF zbooksuppl_guz,
          lv_op_type     type zde_flag_guz,
          lv_updated     type zde_flag_guz.

    IF NOT create-supplement IS INITIAL.
      lt_supplements = CORRESPONDING #( create-supplement ).
      lv_op_type = lsc_supplement=>create.
    ENDIF.

    IF NOT update-supplement IS INITIAL.
      lt_supplements = CORRESPONDING #( update-supplement ).
      lv_op_type = lsc_supplement=>update.
    ENDIF.

    IF NOT delete-supplement IS INITIAL.
      lt_supplements = CORRESPONDING #( delete-supplement ).
      lv_op_type = lsc_supplement=>delete.
    ENDIF.

    IF NOT lt_supplements IS INITIAL.

      CALL FUNCTION 'Z_SUPPL_GUZ'
        EXPORTING
          it_supplements = lt_supplements
          iv_op_type     = lv_op_type
        IMPORTING
          ev_updated     = lv_updated.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
