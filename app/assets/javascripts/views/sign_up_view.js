EvemonkApp.Views.SignUpView = Backbone.View.extend({
    events: {
        'click .sign-up' : 'sign_up'
    },

    render: function () {
        this.$el.html(JST['sign_up/show'](this.model.toJSON()));

        return this;
    },

    sign_up: function (event) {
        event.preventDefault();

        this.model.save({
            email: this.$('#email').val(),
            password: this.$('#password').val(),
            password_confirmation: this.$('#password_confirmation').val()
        }, {
            success: function (model, response) {
                console.log('success');
                console.log(model);
                console.log(response);
            },
            error: function (model, response) {
                console.log('error');
                console.log(model);
                console.log(response);
            }
        });
    }
});
