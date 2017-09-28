EvemonkApp.Views.FlashView = Backbone.View.extend({
    template: JST['flash/show'],

    render: function () {
        this.$el.html(this.template(this.model.toJSON()));

        return this;
    }
});
