// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag
// :defaults

function update_event(estado){

  switch(estado){
  case 0:
    $("#pregunta-actual").hide();
    $('#candidato-actual').hide();
    $('#estadistica').hide();
    $('#evento-no-iniciado').show();
    $('#evento-finalizado').hide();
    break;
  case 1:
    $("#pregunta-actual").show();
    $('#candidato-actual').show();
    $('#estadistica').show();
    $('#evento-no-iniciado').hide();
    $('#evento-finalizado').hide();
    break;
  case 2:
    $("#pregunta-actual").hide();
    $('#candidato-actual').hide();
    $('#estadistica').hide();
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
  }

  $("#candidato_actual").val(candidato);
  $("#voto_candidato").val(candidato);

  reset_puntaje();
 
};

function update_promedio(promedio) {
  var puntos;

  puntos = parseFloat(promedio);
  puntos = (puntos * 100.00)/4.00;

  $("h3#promedio").text(puntos.toFixed(3).toString());
}

function reset_puntaje(){
  $("#candidato_puntaje").val("");
  $("#candidato_puntaje").focus();
  $("#candidato_puntaje").effect("highlight", {}, 3000);
};

$(document).ready(function(){
  update_event(parseInt($("#estado_evento").val()));
  update_question($("#pregunta_actual").val());
  update_candidato($("#candidato_actual").val());
  update_promedio($("#promedio_actual").val());
});


Socky.prototype.respond_to_message = function(msg) {
  data = JSON.parse(msg);

  if (data[0] == 'evento') {
    update_event(parseInt(data[1]));
  };

  if (data[0] == 'pregunta') {
    update_question(data[1])
  };

  if (data[0] == 'candidato') {
    update_candidato(data[1])
  };

  if (data[0] == 'promedio') {
    update_promedio(data[1])
  };

}
