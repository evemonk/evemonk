EvemonkApp.Views.WelcomeView = Backbone.View.extend({
    template: JST['welcome/index'],

    render: function () {
        this.$el.html(this.template());

        return this;
    }
});
