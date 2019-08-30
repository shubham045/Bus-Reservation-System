
  $( document ).on('turbolinks:load', function() {

    $(".close").click(function(){
      $(".alert-danger").hide();
    });

    $(".close").click(function(){
      $(".alert-success").hide();
    });

    $("#reservation_date").on("change", function(){
         var date = this.value;
         var bus_id = $("input:last").val();
         var params = {
             bus_id: bus_id,
             date: date
           };
         $.ajax({
           method: "GET",
           url: " /buses/"+bus_id+"/reservations/:id/new_seat",
           type: "script",
           data: params,
           success: function(){

           },
           error: function(){

           },
           complete: function(){

           }
      });
    })
  })



//  function startTimer(duration, display) {
//    var timer = duration, minutes, seconds;
//    setInterval(function () {
//        minutes = parseInt(timer / 60, 10);
//        seconds = parseInt(timer % 60, 10);

//        minutes = minutes < 10 ? "0" + minutes : minutes;
//        seconds = seconds < 10 ? "0" + seconds : seconds;

//        display.textContent = minutes + ":" + seconds;
// //
//        if (--timer < 0) {
//            timer = duration;
//        }
//    }, 1000);

//   window.onmouseover = setTimeout(
//      function() {
//      window.location.href = "http://localhost:3000";
//    }, 60000*5);
// }

// window.onmouseover = function () {
//    var fiveMinutes = 60*5,
//        display = document.querySelector('#time');
//    startTimer(fiveMinutes, display);
// };


