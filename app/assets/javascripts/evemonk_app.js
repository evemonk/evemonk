var EvemonkApp = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    initialize: function () {
        new EvemonkApp.Routers.Main();
        Backbone.history.start({ pushState: true });
    }
};
