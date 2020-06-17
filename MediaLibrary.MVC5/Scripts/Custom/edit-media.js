function edit(obj, event) {
    event = window.event
    event.preventDefault();
    var id = obj.getAttribute("data");
    getPartial(id);

    $("#btn-edit-media").on("click", function (event) {
        event.preventDefault();
        editMedia();
    })
}

function getPartial(id) {
    $.ajax({
        url: "Media/Edit",
        type: "GET",
        dataType: "html",
        data: { id: id },
        success: function (result) {
            $(".edit-body").html(result);
            $("#media-edit-modal").modal("show");
        },
        error: function (data) {
            toastr.error("Sorry, an error was encountered. Please try again. [ " + data.responseText + " ]");
        }
    })
}

function editMedia() {
    var data = $("#edit-media-form").serialize();
    $.ajax({
        url: "Media/Edit",
        type: "POST",
        dataType: "json",
        data: data,
        success: function (result) {
            if (result["status"]) {
                $("#media-edit-modal").modal("hide");
                toastr.success(result["message"]);
                listing(result["data"]);
            } else {
                toastr.error(result["message"]);
            }
        },
        error: function (data) {
            toastr.error("Sorry, an error was encountered. Please try again. [ " + data.responseText + " ]");
        }
    })
}