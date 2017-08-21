EvemonkApp.Views.SignInView = Backbone.View.extend({
    events: {
        'click .sign-in' : 'sign_in'
    },

    render: function () {
        this.el.innerHTML = JST['sign_in/show'](this.model.toJSON());
        return this;
    },

    sign_in: function (event) {
        this.model.save({
            email: this.$('#email').val(),
            password: this.$('#password').val()
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
