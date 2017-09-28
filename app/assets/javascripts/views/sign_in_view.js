EvemonkApp.Views.SignInView = Backbone.View.extend({
    events: {
        'click .sign-in' : 'sign_in'
    },

    template: JST['sign_in/show'],

    render: function () {
        this.$el.html(this.template(this.model.toJSON()));

        return this;
    },

    sign_in: function (event) {
        event.preventDefault();

        this.model.save({
            email: this.$('#email').val(),
            password: this.$('#password').val()
        }, {
            success: function (model, response, options) {
                Cookies.set('auth_token', response.token);

                EvemonkApp.currentUser = new EvemonkApp.Models.CurrentUser({ loggedIn: true });

                EvemonkApp.currentSession = new EvemonkApp.Models.Session(response);

                EvemonkApp.Events.trigger('user:sign_in');

                var flash = new EvemonkApp.Models.FlashSuccess({ message: 'Successful signed in!' });

                var flashView = new EvemonkApp.Views.FlashView({ model: flash });

                $('#flash').append(flashView.render().el);

                Backbone.history.navigate('/', { trigger: true });
            },

            error: function (model, response, options) {
                _.each(response.responseJSON.errors.base, function (error) {
                    var flash = new EvemonkApp.Models.FlashError({ message: error });

                    var flashView = new EvemonkApp.Views.FlashView({ model: flash });

                    $('#flash').append(flashView.render().el);
                });
            }
        })
    }
});
