CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateTotalFlighPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~calculateTotalFlighPrice.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Booking~validateCustomer.

      METHODS get_features for features
        IMPORTING keys REQUEST requested_features for booking result result.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD calculateTotalFlighPrice.

    IF NOT keys[] IS INITIAL.
      zcl_aux_travel_det_cg=>calculate_price(
      it_travel_id = VALUE #( FOR GROUPS <booking> OF booking_key IN keys
                                GROUP BY booking_key-travel_id WITHOUT MEMBERS ( <booking> ) ) ).
    ENDIF.

  ENDMETHOD.

  METHOD validateCustomer.
        READ ENTITY z_i_travel_guz\\Booking
        FIELDS ( booking_status )
            WITH VALUE #( FOR <row_key> IN keys ( %key = <row_key>-%key ) )
            RESULT DATA(lt_booking_result).

    LOOP AT lt_booking_result INTO DATA(ls_booking_result).

      CASE ls_booking_result-booking_status.
        WHEN 'N'. "New
        when 'X'. "Cancelled
        WHEN 'B'. "Booked

        WHEN OTHERS.

          APPEND VALUE #( %key = ls_booking_result-%key ) TO failed-booking.

          APPEND VALUE #( %key = ls_booking_result-%key
                          %msg = new_message( id     = 'Z_MC_TRAVEL_GUZ'
                                              number = '008'
                                              v1 = ls_booking_result-booking_id
                                              severity = if_abap_behv_message=>severity-error )
                                              %element-booking_status = if_abap_behv=>mk-on ) TO reported-booking.

      ENDCASE.

    ENDLOOP.
  ENDMETHOD.

  METHOD get_features.

    read ENTITIES OF z_i_travel_guz
        entity booking
        fields ( booking_id booking_date customer_id booking_status )
            with value #( for keyval in keys ( %key = keyval-%key ) )
        RESULT data(lt_booking_result).

    result = value #( for ls_travel in lt_booking_result
                        ( %key = ls_travel-%key
                          %assoc-_BookingSupplement = if_abap_behv=>fc-o-enabled ) ).

  ENDMETHOD.

ENDCLASS.
