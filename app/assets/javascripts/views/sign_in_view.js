EvemonkApp.Views.SignInView = Backbone.View.extend({
    events: {
        'click .sign-in' : 'sign_in'
    },

    render: function () {
        this.el.innerHTML = JST['sign_in/show'](this.model.toJSON());
        return this;
    },

    sign_in: function (event) {
        console.log('Hello');
    }
});
