function del(obj, event) {
    event = window.event
    event.preventDefault();

    var id = obj.getAttribute("data");
    $("#media-modal-delete").modal("show");

    $("#btn-delete-media").on("click", function (event) {
        event.preventDefault();
        deleteMedia(id);
    })
}

function deleteMedia(id) {
    $.ajax({
        url: "Media/Delete",
        type: "POST",
        dataType: "json",
        data: {id : id},
        success: function (result) {
            if (result["status"]) {
                $("#media-modal-delete").modal("hide");
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