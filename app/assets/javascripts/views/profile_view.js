EvemonkApp.Views.ProfileView = Backbone.View.extend({
    template: JST['profile/show'],

    render: function () {
        this.$el.html(this.template(this.model.toJSON()));

        return this;
    }
});
