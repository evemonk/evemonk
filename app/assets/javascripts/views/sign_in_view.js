EvemonkApp.Views.SignInView = Backbone.View.extend({
    events: {
        'click .sign-in' : 'sign_in'
    },

    render: function () {
        this.$el.html(JST['sign_in/show'](this.model.toJSON()));

        return this;
    },

    sign_in: function (event) {
        event.preventDefault();

        this.model.save({
            email: this.$('#email').val(),
            password: this.$('#password').val()
        }).done(function (response) {
            Cookies.set("auth_token", response.token);

            Backbone.history.navigate('/', { trigger: true });

            var flash = new EvemonkApp.Models.FlashSuccess({ message: 'Successful signed in!' })

            var flashView = new EvemonkApp.Views.FlashView({ model: flash });

            $('#flash').append(flashView.render().el);
        }).fail(function (response) {
            _.each(response.responseJSON, function (error) {
                var flash = new EvemonkApp.Models.FlashError({ message: error })

                var flashView = new EvemonkApp.Views.FlashView({ model: flash });

                $('#flash').append(flashView.render().el);
            });
        });
    }
});
