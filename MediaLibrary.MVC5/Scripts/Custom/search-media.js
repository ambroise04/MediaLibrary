$("#search-input").keyup(function () {
    var key = $(this).val();

    getMedias(key);
})

function getMedias(key) {
    $.ajax({
        url: "Media/Search",
        type: "GET",
        dataType: "json",
        data: { search : key },
        success: function (data) {
            listing(data["data"])
        },
        error: function (data) {
            toastr.error("Sorry, an error was encountered. Please try again. [ " + data.responseText + " ]");
        }
    })
}