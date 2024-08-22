CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateTotalFlighPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~calculateTotalFlighPrice.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Booking~validateCustomer.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD calculateTotalFlighPrice.
  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

ENDCLASS.
