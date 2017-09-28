Handlebars.registerHelper('pagination', function(currentPage, totalPage, size, options) {
    var startPage, endPage, context;

    if (arguments.length === 3) {
        options = size;
        size = 5;
    }

    startPage = currentPage - Math.floor(size / 2);
    endPage = currentPage + Math.floor(size / 2);

    if (startPage <= 0) {
        endPage -= (startPage - 1);
        startPage = 1;
    }

    if (endPage > totalPage) {
        endPage = totalPage;
        if (endPage - size + 1 > 0) {
            startPage = endPage - size + 1;
        } else {
            startPage = 1;
        }
    }

    context = {
        startFromFirstPage: false,
        pages: [],
        endAtLastPage: false,
    };
    if (startPage === 1) {
        context.startFromFirstPage = true;
    }
    for (var i = startPage; i <= endPage; i++) {
        context.pages.push({
            page: i,
            isCurrent: i === currentPage,
        });
    }
    if (endPage === totalPage) {
        context.endAtLastPage = true;
    }

    return options.fn(context);
});
