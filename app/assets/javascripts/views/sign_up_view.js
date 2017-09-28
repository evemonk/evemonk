EvemonkApp.Views.SignUpView = Backbone.View.extend({
    events: {
        'click .sign-up' : 'sign_up'
    },

    template: JST['sign_up/show'],

    render: function () {
        this.$el.html(this.template(this.model.toJSON()));

        return this;
    },

    sign_up: function (event) {
        event.preventDefault();

        this.model.save({
            email: this.$('#email').val(),
            password: this.$('#password').val(),
            password_confirmation: this.$('#password_confirmation').val()
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
                $('.invalid-feedback').html('');

                $('.is-invalid').removeClass('is-invalid');

                _.each(response.responseJSON, function (obj) {
                    _.each(obj, function (errors, key) {
                        var form_element = $('#' + key);

                        form_element.addClass('is-invalid');

                        form_element.parent().find('.invalid-feedback').html(errors.join(', '));
                    });
                });
            }
        });
    }
});
