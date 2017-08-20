EvemonkApp.Routers.Main = Backbone.Router.extend({
    routes: {
        '' : 'index',
        'sign_up' : 'sign_up'
    },

    index: function () {
        var signIn = new EvemonkApp.Models.SignIn({});

        var signInView = new EvemonkApp.Views.SignInView({ model: signIn });

        $('#content').append(signInView.render().el);
    },

    sign_up: function () {
        var signUp = new EvemonkApp.Models.SignUp({});

        var signUpView = new EvemonkApp.Views.SignUpView({ model: signUp });

        $('#content').append(signUpView.render().el);
    }
});
