class ZMEZ_CL_UI5_HTTP_HANDLER definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZMEZ_CL_UI5_HTTP_HANDLER IMPLEMENTATION.


METHOD IF_HTTP_EXTENSION~HANDLE_REQUEST.

  DATA lt_header TYPE tihttpnvp.
  server->request->get_header_fields( CHANGING fields = lt_header ).

  DATA lt_param TYPE tihttpnvp.
  server->request->get_form_fields( CHANGING fields = lt_param ).

  z2ui5_cl_http_handler=>client = VALUE #(
     t_header = lt_header
     t_param  = lt_param
     body     = server->request->get_cdata( ) ).

  DATA(lv_resp) = SWITCH #( server->request->get_method( )
     WHEN 'GET'  THEN z2ui5_cl_http_handler=>http_get(
                               title = `abap2UI5` )
     WHEN 'POST' THEN z2ui5_cl_http_handler=>http_post( ) ).

  server->response->set_cdata( lv_resp ).
  server->response->set_status( code = 200 reason = 'success' ).

ENDMETHOD.
ENDCLASS.
