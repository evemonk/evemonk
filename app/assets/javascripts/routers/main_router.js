EvemonkApp.Routers.MainRouter = Backbone.Router.extend({
    routes: {
        '' : 'index',
        'sign_up' : 'sign_up',
        'sign_in' : 'sign_in',
        'sign_out' : 'sign_out'
    },

    initialize: function () {
        if (Cookies.get('auth_token')) {
            EvemonkApp.currentUser = new EvemonkApp.Models.CurrentUser({ loggedIn: true });
        } else {
            EvemonkApp.currentUser = new EvemonkApp.Models.CurrentUser({ loggedIn: false });
        }

        this.header = new EvemonkApp.Views.HeaderView();

        $('#header').html(this.header.render().el);
    },

    unauthorized: function () {
        Cookies.remove('auth_token');

        EvemonkApp.currentUser = new EvemonkApp.Models.CurrentUser({ loggedIn: false });

        EvemonkApp.Events.trigger('user:sign_out');

        Backbone.history.navigate('sign_in', { trigger: true });
    },

    index: function () {
        var welcomeView = new EvemonkApp.Views.WelcomeView();

        $('#content').html(welcomeView.render().el);
    },

    sign_up: function () {
        var signUp = new EvemonkApp.Models.SignUp({});

        var signUpView = new EvemonkApp.Views.SignUpView({ model: signUp });

        $('#content').html(signUpView.render().el);
    },

    sign_in: function () {
        var signIn = new EvemonkApp.Models.SignIn({});

        var signInView = new EvemonkApp.Views.SignInView({ model: signIn });

        $('#content').html(signInView.render().el);
    },

    sign_out: function () {
        Cookies.remove('auth_token');

        EvemonkApp.currentUser = new EvemonkApp.Models.CurrentUser({ loggedIn: false });

        EvemonkApp.Events.trigger('user:sign_out');

        var flash = new EvemonkApp.Models.FlashSuccess({ message: 'Successful signed out!' });

        var flashView = new EvemonkApp.Views.FlashView({ model: flash });

        $('#flash').append(flashView.render().el);

        $('#content').empty();

        Backbone.history.navigate('/', { trigger: true });
    }
});
