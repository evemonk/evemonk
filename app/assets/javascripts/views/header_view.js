EvemonkApp.Views.HeaderView = Backbone.View.extend({
    render: function () {
        this.el.innerHTML = JST['header/show']();

        return this;
    }
});
