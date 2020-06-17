$(document).ready(function () {
    $(".remove").on("click", function (event) {
        event.preventDefault();
        var id = this.getAttribute("data");
        $("#media-modal-delete").modal("show");

        $("#btn-delete-media").on("click", function (event) {
            event.preventDefault();
            deleteMedia(id);
        })
    })
    
})

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
            } else {
                toastr.error(result["message"]);
            }            
        },
        error: function (data) {
            toastr.error("Sorry, an error was encountered. Please try again. [ " + data.responseText + " ]");
        }
    })
}