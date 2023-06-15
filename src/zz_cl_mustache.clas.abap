CLASS zlk_cl_test_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.

types:
  begin of ty_shop_item,
    name type string,
    price type string,
  end of ty_shop_item,

  ty_shop_item_tt type standard table of ty_shop_item with empty key,

  begin of ty_shop,
    shop_name type string,
    items type ty_shop_item_tt,
  end of ty_shop.


  PRIVATE SECTION.
ENDCLASS.



CLASS zlk_cl_test_03 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lo_mustache TYPE REF TO zcl_mustache.
    DATA lv_text TYPE string.
    CONSTANTS: c_nl TYPE c VALUE cl_abap_char_utilities=>newline.

    lo_mustache = zcl_mustache=>create(
  'Welcome to <b>{{shop_name}}</b>!' && c_nl &&
  '<table>' && c_nl &&
  ' {{#items}}' && c_nl &&
  ' <tr><td>{{name}}</td><td>${{price}}</td>' && c_nl &&
  ' {{/items}}' && c_nl &&
  '</table>' ).

    DATA(ls_my_data) = VALUE ty_shop(  shop_name = `My Shop`
      items = VALUE #(
      ( name = `tiger` price = `300` )
      ( name = `elefant` price = `4000` )
      ( name = `mouse` price = `10` )
      ( name = `horse` price = `500` )
      )  ).

    lv_text = lo_mustache->render( ls_my_data ).
     out->write( lv_text ).
  ENDMETHOD.


ENDCLASS.
