$(() => {
  // really lazy way to handle "navigation"
  $(".navigation").on("click", (e) => {
    let tgt = $(e.currentTarget).data("target");

    $('.tab').hide();
    $('.navigation').removeClass("bg-white text-cyan-600 rounded");

    $(e.currentTarget).addClass("bg-white text-cyan-600 rounded");
    $(`div[data-value='${tgt}']`).show();
    $(`div[data-value='${tgt}']`).trigger("shown");

    if(tgt == "home")
      $("#inputs").hide();

    if(tgt != "home")
      $("#inputs").show();
  });
});

Shiny.addCustomMessageHandler("init", (values) => {
  let optsSpecies = makeOptions(values.species, "All species");
  let optsIslands = makeOptions(values.islands, "All islands");

  $("#species").html(optsSpecies);
  $("#islands").html(optsIslands);

  // bind select
  bindInputs();

  // send initial values
  sendInputValue("species");
  sendInputValue("islands");
});

const makeOptions = (values, all) => {
  return [all, ...values].map((v, i) => `<option value="${i == 0 ? 'all' : v}">${v}</option>`)
}

const bindInputs = () => {
  $("#species").on("change", (e) => {
    sendInputValue("species");
  });

  $("#islands").on("change", (e) => {
    sendInputValue("islands");
  });
}

const sendInputValue = (id) => {
  Shiny.setInputValue(id, $(`#${id}`).val());
}
