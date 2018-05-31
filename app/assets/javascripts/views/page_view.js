EvemonkApp.Views.PageView = Backbone.View.extend({
    template: JST['page/index'],

    render: function () {
        this.$el.html(this.template());

        return this;
    }
});
