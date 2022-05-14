$(function () {
    function display(bool) {
        if (bool) {
            $("#container").css({"display":"block"});  //$("#container").show();
        } else {
            $("#container").css({"display":"none"});  //$("#container").hide();
        }
    }
    display(false)
    window.addEventListener("message", function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    $("#close").click(function(){
        $.post("https://i13-bugreport/exit", JSON.stringify({}));
    })

    $("#submit").click(function(){
        var inputValue = $("#textarea").val()
        if (!inputValue) {
            $.post("https://i13-bugreport/error", JSON.stringify({
                error: "Sa ei ole midagi kirjutanud!"
            }))
        } else {
            $.post("https://i13-bugreport/main", JSON.stringify({
            text: inputValue
        }))
        }
    })

})