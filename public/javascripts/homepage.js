// // Place your application-specific JavaScript functions and classes here
// // This file is automatically included by javascript_include_tag
// // :defaults

function update_event(estado){

  switch(estado){
  case 0:
    $("#pregunta-actual").hide();
    $('#candidato-actual').hide();
    $('#evento-no-iniciado').show();
    $('#evento-finalizado').hide();
    break;
  case 1:
    $("#pregunta-actual").show();
    $('#candidato-actual').show();
    $('#evento-no-iniciado').hide();
    $('#evento-finalizado').hide();
    break;
  case 2:
    $("#pregunta-actual").hide();
    $('#candidato-actual').hide();
    $('#evento-no-iniciado').hide();
    $('#evento-finalizado').show();
    break;
  }
};

function update_question(pregunta){
  if (pregunta == '0' || pregunta == '') {
    $("#preguntas").hide();
    $("#no-hay-pregunta").fadeIn('slow');
  } else {
    $(".pregunta").hide();
    $("#no-hay-pregunta").hide();
    $("#"+pregunta).fadeIn('slow');
    $("#preguntas").show();

    // actualizar form para envio de opinion
    $("#voto_pregunta").val(pregunta);
    $("#pregunta_actual").val(pregunta);

    reset_puntaje();

    update_voto('show');
  }
};

function update_candidato(candidato) {
  if (candidato == '0' || candidato == '') {
    $("#candidato").hide();
    $("#no-hay-candidato").show();
  } else {
    $("#no-hay-candidato").hide();
    $(".candidato").hide();
    $("#"+candidato).fadeIn('slow');
    $("#candidato").show();

    $("#candidato_actual").val(candidato);
    $("#voto_candidato").val(candidato);

    reset_puntaje();

    update_voto('show');
  }
};

function update_promedio(promedio) {
  var puntos;

  puntos = parseFloat(promedio);
  puntos = (puntos * 100.00)/4.00;

  $("h3#promedio").text(puntos.toFixed(3).toString());

  $("#promedio_actual").val(promedio);
}

function reset_puntaje(){
  $("#candidato_puntaje").val("");
  $("#candidato_puntaje").focus();
  $("#candidato_puntaje").effect("highlight", {}, 3000);
};

function update_voto(action){
  if (action == 'show') {
    $("#voto").show();
    $("#gracias").hide();
  } else {
    $("#voto").hide();
    $("#gracias").show();
  }
};

function set_estado_evento(data){


  if ($("#usuario_actual").val() == '') {
    $("#usuario_actual").val(data.usuario);
  }

  if (data.estado == 0 || data.estado == 2) {

    $("#estado_evento").val(data.estado);
    update_event(data.estado);

  } else {

    if ( $("#estado_evento").val() == '' ){
      $("#estado_evento").val(data.estado);
      update_event(data.estado);
    } else {
      if (parseInt($("#estado_evento").val()) != data.estado ) {
        $("#estado_evento").val(data.estado);
        update_event(data.estado);
      }
    }

    

    if ( $("#pregunta_actual").val() != data.pregunta ||  $("#pregunta_actual").val() == '') {
      update_question(data.pregunta);
    }

    if ( $("#candidato_actual").val() != data.candidato || $("#candidato_actual").val() == '') {
      update_candidato(data.candidato);
    }

    if ( $("#promedio_actual").val() != data.promedio ) {
      update_promedio(data.promedio);
    }
  }
    

};


function get_estado_evento(){
  $.ajax({url: 'home/estado.json',
          success: function(data) {
            $("#evento-cargando").hide();
            set_estado_evento(data);
          },
          datatype: 'json'
         });
};

function setup(){

  $("form#new_voto").live("ajax:beforeSend", function(evt, xhr, settings){
    update_voto('hide');
  })
    .live("ajax:success", function(evt, data, status, xhr){
      var response = $.parseJSON(xhr.responseText);
      update_promedio(response.promedio);
      $("#voto_puntaje").val("");
    });

};


$(document).ready(function(){
  setup();
  get_estado_evento();
  setInterval( "get_estado_evento()", 5000 );
});
