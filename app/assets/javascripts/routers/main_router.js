EvemonkApp.Routers.MainRouter = Backbone.Router.extend({
    routes: {
        '' : 'index',
        'sign_up' : 'sign_up',
        'sign_in' : 'sign_in',
        'sign_out' : 'sign_out',
        'profile' : 'profile',
        'characters?page=:page' : 'characters_page',
        'characters' : 'characters',
        'characters/:id' : 'show_character'
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

        EvemonkApp.currentSession = new EvemonkApp.Models.Session();

        EvemonkApp.Events.trigger('user:sign_out');

        Backbone.history.navigate('sign_in', { trigger: true });
    },

    index: function () {
        var welcomeView = new EvemonkApp.Views.WelcomeView();

        $('#content').html(welcomeView.render().el);
    },

    sign_up: function () {
        var signUp = new EvemonkApp.Models.SignUp();

        var signUpView = new EvemonkApp.Views.SignUpView({ model: signUp });

        $('#content').html(signUpView.render().el);
    },

    sign_in: function () {
        var signIn = new EvemonkApp.Models.SignIn();

        var signInView = new EvemonkApp.Views.SignInView({ model: signIn });

        $('#content').html(signInView.render().el);
    },

    sign_out: function () {
        new EvemonkApp.Models.SignOut({ id: 1 }).destroy();

        Cookies.remove('auth_token');

        EvemonkApp.currentUser = new EvemonkApp.Models.CurrentUser({ loggedIn: false });

        EvemonkApp.currentSession = new EvemonkApp.Models.Session({});

        EvemonkApp.Events.trigger('user:sign_out');

        var flash = new EvemonkApp.Models.FlashSuccess({ message: 'Successful signed out!' });

        var flashView = new EvemonkApp.Views.FlashView({ model: flash });

        $('#flash').append(flashView.render().el);

        $('#content').empty();

        Backbone.history.navigate('/', { trigger: true });
    },

    profile: function () {
        var profile = new EvemonkApp.Models.Profile();

        var self = this;

        profile.fetch({
            success: function () {
                var profileView = new EvemonkApp.Views.ProfileView({ model: profile });

                $('#content').html(profileView.render().el);
            },
            error: function (model, response, options) {
                if (response.status === 401) {
                    self.unauthorized();
                }
            }
        });
    },

    characters: function () {
        var characters = new EvemonkApp.Collections.Characters();

        var self = this;

        characters.fetch({
            success: function () {
                var charactersView = new EvemonkApp.Views.CharactersView({ collection: characters });

                $('#content').html(charactersView.render().el);
            },
            error: function (model, response, options) {
                if (response.status === 401) {
                    self.unauthorized();
                }
            }
        });
    },

    characters_page: function (page) {
        var characters = new EvemonkApp.Collections.Characters();

        var self = this;

        characters.getPage(parseInt(page), {
            fetch: true,
            reset: true,

            success: function () {
                var charactersView = new EvemonkApp.Views.CharactersView({ collection: characters });

                $('#content').html(charactersView.render().el);
            },

            error: function (model, response, options) {
                if (response.status === 401) {
                    self.unauthorized();
                }
            }
        });
    },

    show_character: function (id) {
        var character = new EvemonkApp.Models.Character({ id: id });

        var self = this;

        character.fetch({
            success: function () {
                var characterView = new EvemonkApp.Views.CharacterView({ model: character });

                $('#content').html(characterView.render().el);
            },

            error: function (model, response, options) {
                if (response.status === 401) {
                    self.unauthorized();
                }

                if (response.status === 404) {
                    var flash = new EvemonkApp.Models.FlashWarning({ message: 'Character not found!' });

                    var flashView = new EvemonkApp.Views.FlashView({ model: flash });

                    $('#flash').append(flashView.render().el);

                    Backbone.history.navigate('characters', { trigger: true });
                }
            }
        });
    }
});
