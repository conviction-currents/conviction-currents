var map     = Snap('#mapping');

var years_div = document.getElementById('years_div');

function animate_ship(ship)
{

  years_div.innerHTML = "<p class='date'>" + ship.date + "</p><p class='ship' style='color: " + ship.c + ";'>" +  ship.vessel + "</p><p class='convicts'>" + ship.convicts + " convicts</p>" + years_div.innerHTML;

    var whitePath = map.path(ship.p).attr({
      id: "whitePath",
      fill: "none",
      strokeWidth: "17",
      stroke: "#FFF",
      strokeMiterLimit: "10",
      strokeDasharray: "10",
      strokeDashOffset: "1000"
    });
    var WhiteLen = whitePath.getTotalLength();
    ship.hide_delay = 20;
    ship.journey = whitePath.attr({
      stroke: ship.c,
      strokeLinecap: "round",
      strokeWidth: ship.t,
      fill: 'none',
      "stroke-dasharray": WhiteLen + " " + WhiteLen,
      "stroke-dashoffset": WhiteLen
  }).animate({"stroke-dashoffset": 10}, 2000, mina.easeinout);
}

var ticker = 0

  var start_at_journey = 500
  var start_offset = ships[start_at_journey].d

setInterval(function() {



  //document.getElementById("ticker").innerHTML = ticker
  //ticker += 1

  for (var i = start_at_journey; i < ships.length; i++)
  {
    if ((ships[i].d) > start_offset) {
      ships[i].d--;
    }else if ((ships[i].d) == start_offset) {
      animate_ship(ships[i]);
      ships[i].d = -1;
    }

    if (ships[i].hide_delay > 0) {
      ships[i].hide_delay--;
      ships[i].journey.attr({'opacity':  ships[i].hide_delay / 20.0 });
    }else if (ships[i].hide_delay == 0) {
      ships[i].journey.remove();
      ships[i].hide_delay = 1;
    }
  }
}, 500);
