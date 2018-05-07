EvemonkApp.Views.UniverseView = Backbone.View.extend({
    template: JST['universe/index'],

    render: function () {
        this.$el.html(this.template());

        return this;
    }
});
