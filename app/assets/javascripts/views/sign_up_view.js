EvemonkApp.Views.SignUpView = Backbone.View.extend({
    events: {
        'click .sign-up' : 'sign_up'
    },

    render: function () {
        this.el.innerHTML = JST['sign_up/show'](this.model.toJSON());
        return this;
    },

    sign_in: function (event) {
        console.log('Hello');
    }
});
