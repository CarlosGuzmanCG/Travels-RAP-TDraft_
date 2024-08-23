CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS acceptTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~acceptTravel RESULT result.

    METHODS createTravelByTemplate FOR MODIFY
      IMPORTING keys FOR ACTION Travel~createTravelByTemplate RESULT result.

    METHODS rejectTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~rejectTravel RESULT result.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateCustomer.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateDates.

    METHODS validateStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateStatus.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD acceptTravel.

    "Modify in local mode - BO - related updates there are not relevant for autorization objects
    MODIFY ENTITIES OF z_i_travel_guz IN LOCAL MODE
            ENTITY travel
            UPDATE FIELDS ( overall_status )
            WITH VALUE #( FOR key_row IN keys ( travel_id = key_row-travel_id
                                                overall_status = 'A' ) ) "Accepted
            FAILED failed
            REPORTED reported.

    READ ENTITIES OF z_i_travel_guz IN LOCAL MODE
        ENTITY travel
          FIELDS  ( agency_id
                    customer_id
                    begin_date
                    end_date
                    booking_fee
                    total_price
                    currency_code
                    overall_status
                    description
                    created_at
                    created_by
                    last_changed_by
                    last_changed_at )
          WITH VALUE #( FOR key_row1 IN keys ( travel_id = key_row1-travel_id ) )
          RESULT DATA(lt_travel).

    result = VALUE #( FOR ls_travel IN lt_travel ( travel_id = ls_travel-travel_id
                                                   %param    = ls_travel ) ).

  ENDMETHOD.

  METHOD createTravelByTemplate.
    "internal table,
    "keys[ 1 ]- "to know what was selected
    "result[ 1 ]-
    "mapped- "mapping eml
    "failed- - error
    "reported-

    READ ENTITIES OF z_i_travel_guz  ENTITY Travel
        FIELDS ( travel_id agency_id customer_id booking_fee total_price currency_code )
            WITH VALUE #( FOR row_key IN keys ( %key = row_key-%key ) )
            RESULT DATA(lt_entity_travel)

            FAILED failed
            REPORTED reported.

*    read ENTITIES OF z_i_travel_guz  ENTITY Travel
*        FIELDS ( travel_id agency_id customer_id booking_fee total_price currency_code )
*            with value #( for row_key in keys ( %key = row_key-%key ) )
*            RESULT lt_read_entity_travel
*
*            failed failed
*            REPORTED reported.

    "check failed is INITIAL.

    DATA lt_create_travel TYPE TABLE FOR CREATE z_i_travel_guz\\Travel.

    SELECT MAX( travel_id ) FROM ztravel_guz
        INTO @DATA(lv_travel_id).

    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    lt_create_travel = VALUE #( FOR create_row IN lt_entity_travel INDEX INTO idx
                                ( travel_id    = lv_travel_id + idx
                                agency_id      = create_row-agency_id
                                customer_id    = create_row-customer_id
                                begin_date     = lv_today
                                end_date       = lv_today + 30
                                booking_fee    = create_row-booking_fee
                                total_price    = create_row-total_price
                                currency_code  = create_row-currency_code
                                description    = 'Add comments'
                                overall_status = 'O' ) ).

    MODIFY ENTITIES OF z_i_travel_guz
                  IN LOCAL MODE ENTITY travel
                      CREATE FIELDS (
                          travel_id
                          agency_id
                          customer_id
                          begin_date
                          end_date
                          booking_fee
                          total_price
                          currency_code
                          description
                          overall_status
                      )
                WITH lt_create_travel
                MAPPED mapped
                FAILED failed
                REPORTED reported.

    "return
    result = VALUE #( FOR result_row IN lt_create_travel INDEX INTO idx
                         ( %cid_ref = keys[ idx ]-%cid_ref
                           %key     = keys[ idx ]-%key
                           %param   = CORRESPONDING #( result_row ) ) ).

  ENDMETHOD.

  METHOD rejectTravel.
      "Modify in local mode - BO - related updates there are not relevant for autorization objects
    MODIFY ENTITIES OF z_i_travel_guz IN LOCAL MODE
            ENTITY travel
            UPDATE FIELDS ( overall_status )
            WITH VALUE #( FOR key_row IN keys ( travel_id = key_row-travel_id
                                                overall_status = 'X' ) ) "Rejected
            FAILED failed
            REPORTED reported.

    READ ENTITIES OF z_i_travel_guz IN LOCAL MODE
        ENTITY travel
          FIELDS  ( agency_id
                    customer_id
                    begin_date
                    end_date
                    booking_fee
                    total_price
                    currency_code
                    overall_status
                    description
                    created_at
                    created_by
                    last_changed_by
                    last_changed_at )
          WITH VALUE #( FOR key_row1 IN keys ( travel_id = key_row1-travel_id ) )
          RESULT DATA(lt_travel).

    result = VALUE #( FOR ls_travel IN lt_travel ( travel_id = ls_travel-travel_id
                                                   %param    = ls_travel ) ).
  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

  METHOD validateDates.
  ENDMETHOD.

  METHOD validateStatus.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_Z_I_TRAVEL_GUZ DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_Z_I_TRAVEL_GUZ IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
