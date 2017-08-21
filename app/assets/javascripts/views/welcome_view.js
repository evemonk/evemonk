EvemonkApp.Views.WelcomeView = Backbone.View.extend({
    render: function () {
        this.el.innerHTML = JST['welcome/index']();

        return this;
    }
});
