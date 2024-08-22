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
  ENDMETHOD.

  METHOD createTravelByTemplate.
    "internal table,
    "keys[ 1 ]- "to know what was selected
    "result[ 1 ]-
    "mapped- "mapping eml
    "failed- - error
    "reported-

    read ENTITIES OF z_i_travel_guz  ENTITY Travel
        FIELDS ( travel_id agency_id customer_id booking_fee total_price currency_code )
            with value #( for row_key in keys ( %key = row_key-%key ) )
            RESULT data(lt_read_entity_travel)

            failed failed
            REPORTED reported.

*    read ENTITIES OF z_i_travel_guz  ENTITY Travel
*        FIELDS ( travel_id agency_id customer_id booking_fee total_price currency_code )
*            with value #( for row_key in keys ( %key = row_key-%key ) )
*            RESULT lt_read_entity_travel
*
*            failed failed
*            REPORTED reported.

    check failed is INITIAL.

  ENDMETHOD.

  METHOD rejectTravel.
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
