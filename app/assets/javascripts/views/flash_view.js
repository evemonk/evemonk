EvemonkApp.Views.FlashView = Backbone.View.extend({
    render: function () {
        this.$el.html(JST['flash/show'](this.model.toJSON()));

        return this;
    }
});
