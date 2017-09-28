Handlebars.registerHelper('select', function(value, options) {
    // Create a select element
    var select = document.createElement('select');


    // Populate it with the option HTML
    $(select).html(options.fn(this));

    //below statement doesn't work in IE9 so used the above one
    //select.innerHTML = options.fn(this);

    // Set the value
    select.value = value;

    // Find the selected node, if it exists, add the selected attribute to it
    if (select.children[select.selectedIndex]) {
        select.children[select.selectedIndex].setAttribute('selected', 'selected');
    } else { //select first option if that exists
        if (select.children[0]) {
            select.children[0].setAttribute('selected', 'selected');
        }
    }
    return select.innerHTML;
});
