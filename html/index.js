$(document).ready(function() {
    window.addEventListener('message', function(event) {
        if([ 'nekorestaurants_abierto', 'nekorestaurants_cerrado' ].includes(event.data.type)) {
            nekoRestaurants.sendAlert(event.data);
        }
    });
});

const nekoRestaurants = {
    init: function() { },
    audioCobro: null,

    playSound: function() {
        if(!nekoRestaurants.audioCobro) {
            nekoRestaurants.audioCobro = new Audio("./ping.mp3");
            nekoRestaurants.audioCobro.play();
            nekoRestaurants.audioCobro.volume = 0.15;
        }
    },

    sendAlert: function(data) {
        $('.icono').css('background-color', data.iconbackgroundcolor).html(`<i style="color: ${data.iconcolor}" class="${data.icon}"></i>`);
        $('#text').append(data.mensaje);
        $('#miContenedor').css('background-color', data.backgroundcolor).css('width', 'auto').css('width', $('#miContenedor').width() + 'px').fadeIn();

        nekoRestaurants.playSound();

        setTimeout(() => {
            $('#miContenedor').fadeOut(1500, function() { $('#text, .icono').html(''); });
        }, 4000);
    }
}