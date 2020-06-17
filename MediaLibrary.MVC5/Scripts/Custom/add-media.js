$(document).ready(function () {
    $("#btn-save-media").on("click", function (event) {
        event.preventDefault();

        var data = new FormData();
        //Form data
        var form_data = $('#media-form').serializeArray();
        $.each(form_data, function (key, input) {
            data.append(input.name, input.value);
        });
        //File data
        var file_data = $('input[name="file"]')[0].files;
        if (file_data.length != 0) {
            data.append("file", file_data[0]);
        }
        sendData(data);
    })
})

function sendData(data) {
    $.ajax({
        url: "Media/Create",
        type: "POST",
        dataType: "json",
        headers: { "RequestVerificationToken": $('input[name="__RequestVerificationToken"]').val() },
        data: data,
        processData: false,
        contentType: false,
        success: function (result) {
            if (result["status"]) {
                $('#media-form').trigger("reset");
                $("#media-modal").modal("hide");
                toastr.success(result["message"]);
            } else {
                toastr.error(result["message"]);
            }            
        },
        error: function (data) {
            toastr.error("Sorry, an error was encountered. Please try again. [ " + data.responseText + " ]");
        }
    })
}

