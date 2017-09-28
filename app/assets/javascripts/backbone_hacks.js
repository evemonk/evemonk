Backbone.ajax = function() {
    arguments[0].headers = {
        'Authorization': 'Bearer ' + Cookies.get('auth_token')
    };

    return Backbone.$.ajax.apply(Backbone.$, arguments);
};
