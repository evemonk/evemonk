EvemonkApp.Views.HeaderView = Backbone.View.extend({
    events: {
        'click .dashboard' : 'handle_click',
        'click .characters' : 'handle_click',
        'click .sign-in' : 'handle_click',
        'click .sign-up' : 'handle_click',
        'click .sign-out' : 'handle_click',
        'click .profile' : 'handle_click',
        'click .universe' : 'handle_click'
    },

    template: JST['header/show'],

    initialize: function () {
        this.listenTo(EvemonkApp.Events, 'user:sign_in', this.render);
        this.listenTo(EvemonkApp.Events, 'user:sign_out', this.render);
    },

    render: function () {
        this.$el.html(this.template(EvemonkApp.currentUser.toJSON()));

        return this;
    },

    handle_click: function (event) {
        event.preventDefault();

        Backbone.history.navigate(event.target.getAttribute('href'), { trigger: true });
    }
});
