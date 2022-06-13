$(function () {
    var actionContainer = $(".actionmenu");

    window.onload = function () {
        actionContainer.fadeOut();
    };

    window.addEventListener('message', function (event) {
        if (event.action = "showMenu") {
            let root = document.documentElement;
            actionContainer.fadeIn();
        } else {
            actionContainer.fadeOut();
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            if (actionContainer.is(":visible")) {
                sendData("ButtonClick", "fechar");
            }
        }
    };

    function sendData(name, data) {
        $.post("http://dz_nyse/" + name, JSON.stringify(data), function (
            datab
        ) {
            if (datab != "ok") {
                console.log(datab);
            }
        });
    }
})
