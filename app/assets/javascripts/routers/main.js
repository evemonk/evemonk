EvemonkApp.Routers.Main = Backbone.Router.extend({
    routes: {
        '' : 'index'
    },

    index: function () {
        var signIn = new EvemonkApp.Models.SignIn({});

        var signInView = new EvemonkApp.Views.SignInView({ model: signIn });

        $('#content').append(signInView.render().el);
    }
});
