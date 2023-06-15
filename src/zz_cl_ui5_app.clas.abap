CLASS zz_cl_ui5_app DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA username TYPE string.
    DATA date     TYPE d.

    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zz_cl_ui5_app IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    DATA(render_view) = ``.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      username = `lars`.
      date = sy-datum.
    ENDIF.


    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->popup_message_toast( |App executed on { date DATE = USER } by { username }| ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-id_prev_app_stack  ) ).

    ENDCASE.

    client->set_next( VALUE #( xml_main = z2ui5_cl_xml_view=>factory(
        )->shell(
        )->page(
                title          = 'SAP Developer Code Challenge'
                )->simple_form(
                    )->content( 'form'
                        )->title( 'Input'
                        )->label( 'User'
                        )->input( value       = client->_bind( username )
                                  placeholder = 'Username'
                        )->label( 'Date'
                        )->date_picker( value = date placeholder = 'date'
                        )->button(
                            text  = 'post'
                            press = client->_event( 'BUTTON_POST' )
         )->get_root( )->xml_get( ) ) ).

  ENDMETHOD.


ENDCLASS.
