var EvemonkApp = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    initialize: function () {
        new EvemonkApp.Routers.Main();

        $('#header').append(new EvemonkApp.Views.HeaderView().render().el);

        Backbone.history.start({ pushState: true });
    }
};
