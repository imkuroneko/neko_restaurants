$(document).ready(function() {
    window.addEventListener('message', function(event) {
        // mensaje
        // backgroundcolor
        // iconbackgroundcolor
        // icon
        // iconcolor

        switch(event.data.type) {
            case 'nekorestaurants_abierto':

                $('.icono')
                    .css('background-color', event.data.iconbackgroundcolor)
                    .html(`<i style="color: ${event.data.iconcolor}" class="${event.data.icon}"></i>`);

                $('#text').append(event.data.mensaje);

                var contenedor = $('#miContenedor');
                contenedor
                    .css('background-color', event.data.backgroundcolor)
                    .css('width', 'auto')
                    .css('width', contenedor.width() + 'px')
                    .fadeIn();

                setTimeout(() => {
                    $('#miContenedor').fadeOut(1500, function() {
                        $('#text, .icono').html(''); 
                    });
                }, 4000);    
            break;
            /////////////////////////////////////////////////////////
            case 'nekorestaurants_cerrado':
                $('.icono')
                    .css('background-color', event.data.iconbackgroundcolor)
                    .html(`<i style="color: ${event.data.iconcolor}" class="${event.data.icon}"></i>`);

                $('#text').append(event.data.mensaje);

                var contenedor = $('#miContenedor');
                contenedor
                    .css('background-color', event.data.backgroundcolor)
                    .css('width', 'auto')
                    .css('width', contenedor.width() + 'px')
                    .fadeIn();
                
                setTimeout(() => {
                    $('#miContenedor').fadeOut(1500, function() {
                        $('#text, .icono').html('');
                    });
                }, 4000);
            break;
        }
    });
});
