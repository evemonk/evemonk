EvemonkApp.Views.WelcomeView = Backbone.View.extend({
    render: function () {
        this.$el.html(JST['welcome/index']());

        return this;
    }
});
