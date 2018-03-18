EvemonkApp.Views.BloodlineView = Backbone.View.extend({
    tagName: 'td',
    attributes: { colspan: '2' },

    template: JST['bloodlines/show'],

    render: function () {
        this.$el.html(this.template(this.model.toJSON()));

        return this;
    }
});
