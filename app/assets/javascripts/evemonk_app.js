window.EvemonkApp = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    Events: _.clone(Backbone.Events),

    initialize: function () {
        new EvemonkApp.Routers.MainRouter();

        Backbone.history.start({ pushState: true });
    }
};
