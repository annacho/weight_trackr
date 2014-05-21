$ ->

  $(document).on "click", "#edit_button", ->
    run_id = $(this).attr('data-run-id');
    $.ajax '/runs/' + run_id + "/edit",
      type: 'GET'
    
  $(document).on "click", "#fade", ->
    $("#fade").hide();
    $(".modal_custom").hide();
    return

  $(document).on "click", ".close", ->
    $("#fade").hide();
    $(".modal_custom").hide();
    return

  $(document).on "click", "#last_seven", (e) ->
    e.preventDefault();
    value = $(this).attr('id')
    $.ajax '/runs/filter',
      type: 'GET',
      data: { "filter": {"type": value} }
    return

  $(document).on "click", "#last_thirty", (e)  ->
    e.preventDefault();
    value = $(this).attr('id')
    $.ajax '/runs/filter',
      type: 'GET',
      data: { "filter": {"type": value} }
    return

  $(document).on "click", "#last_ninety", (e)  ->
    e.preventDefault();
    value = $(this).attr('id')
    $.ajax '/runs/filter',
      type: 'GET',
      data: { "filter": {"type": value} }
    return

  $(document).on "click", "#year",  (e) ->
    e.preventDefault();
    value = $(this).attr('id')
    $.ajax '/runs/filter',
      type: 'GET',
      data: { "filter": {"type": value} }
    return

  $(document).on "submit", "#new_weight", (e) ->
    $('#new_run').on 'ajax:complete', (event, data, status, xhr) ->
      my_data = $.parseJSON(data.responseText);
      weight_date = my_data.data.weight_date;
      weight_time = my_data.data.weight_time;
      weight = my_data.data.weight;
      
      $('#create_modal').fadeOut();
      $('#fade').fadeOut();
    
      $('#run_table_body').prepend(
        '<tr>' + '<td class="stat_data weight_cell">' + weight_date + '</td>'+ 
          '<td class="stat_data weight_cell">' + weight_time + '</td>'+ 
            '<td class="stat_data weight_cell">' + weight + '</td>' +
            '<td><form action="/weights/' + my_data.data.id.toString() + 'class="button_to" data-remote="true" method="get"><div><input class="btn btn-default" type="submit" value="View Details"></div></form></td>' +
          "<td><button class='btn btn-default' data-run-id='" + my_data.data.id.toString() +
             "' id='edit_button'>Edit</button></td>" +
             '<td><button class="btn btn-default delete_button" data-run-id="' + my_data.data.id.toString() + '">Delete</button></td>' +
             '</tr>')

  $(document).on "submit", ".edit_weight", (e) ->
    $('.edit_weight').on 'ajax:complete', (event, data, status, xhr) ->
      
      my_data = $.parseJSON(data.responseText);
      weight_date = my_data.data.weight_date;
      weight_time = my_data.data.weight_time;
      weight = my_data.data.weight;
      element_id = 'tr#' + my_data.data.id.toString();
      element_id_1 = element_id + " td:first"
      element_id_2 = element_id + " td:eq(1)"
      element_id_3 = element_id + " td:eq(2)"
      element_id_4 = element_id + " td:eq(3)"
      element_id_5 = element_id + " td:eq(5)"

      weight_date_string = '<td class="stat_data weight_cell">' + weight_date + '</td>';
      weight_time_string = '<td class="stat_data weight_cell">' + weight_time + '</td>';
      weight_weight_string = '<td class="stat_data weight_cell">' + weight_weight + '</td>';
      pace_string = '<td class="stat_data weight_cell">' + pace + '</td>';

      $('#edit_modal').fadeOut();
      $('#fade').fadeOut();
      $(element_id_1).replaceWith(weight_date_string);
      $(element_id_2).replaceWith(weight_time_string);
      $(element_id_3).replaceWith(weight_float);
  
  $(document).on "click", ".delete_button", (e) ->
    item_row = $(this).parents('tr');
    weight_id = $(this).attr('data-run-id');
    url = "/weights/" + weight_id;
    $.ajax url,
      type: 'POST',
      data: {"_method":"delete"},
      success: ->
        $(item_row).remove();
    return false