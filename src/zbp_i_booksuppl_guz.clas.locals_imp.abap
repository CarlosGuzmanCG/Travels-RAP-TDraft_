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
