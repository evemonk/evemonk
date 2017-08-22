EvemonkApp.Routers.Main = Backbone.Router.extend({
    routes: {
        '' : 'index',
        'sign_up' : 'sign_up',
        'sign_in' : 'sign_in'
    },

    index: function () {
        var welcomeView = new EvemonkApp.Views.WelcomeView();

        $('#content').append(welcomeView.render().el);
    },

    sign_up: function () {
        var signUp = new EvemonkApp.Models.SignUp({});

        var signUpView = new EvemonkApp.Views.SignUpView({ model: signUp });

        $('#content').empty().append(signUpView.render().el);
    },

    sign_in: function () {
        var signIn = new EvemonkApp.Models.SignIn({});

        var signInView = new EvemonkApp.Views.SignInView({ model: signIn });

        $('#content').empty().append(signInView.render().el);
    }
});
