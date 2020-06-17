function listing(medias) {
    var content = "";
    var $body = $(".media-container")
    $body.html("");
    startLoading($(".media-container"), "Loading...");
    $.each(medias, function (index, media) {
        content += `
            <div class="row card mb-1">
                <div class="col-md-12 card-body">
                    <div class="row d-flex align-items-center">
                        <div class="col-md-2">
                            <p class="text-center"><i class="far fa-copy fa-4x"></i></p>
                        </div>
                        <div class="col-md-8 description">
                            <p class="text-info media-name" style="font-size: 1.5em">${media.Name}</p>
                            <div class="pb-0">
                                <p><i class="fas fa-link mr-2"></i>Location : ${media.Url}</p>
                                <p>File type : ${media.Type}</p>
                                <p>Category : ${media.Category.Name}</p>
                                <p><small style="color:grey">Date : ${new Date(media.DateOfAddition)}</small></p>
                            </div>
                        </div>
                        <div class="col-md-2 d-flex flex-column flex-column align-items-center media-controls">
                            <a class="text-info" onclick="edit(this, event)" data="${media.Id}"><i class="far fa-edit"></i></a>
                            <a class="text-danger" onclick="del(this, event)" data="${media.Id}"><i class="far fa-trash-alt"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        `
    })
    $body.html(content);
    setTimeout(function () {
        stopLoading($(".media-container"));
    }, 2000)
}