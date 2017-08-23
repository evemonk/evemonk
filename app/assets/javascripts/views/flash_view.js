EvemonkApp.Views.FlashView = Backbone.View.extend({
    render: function () {
        this.el.innerHTML = JST['flash/show'](this.model.toJSON());

        return this;
    }
});
