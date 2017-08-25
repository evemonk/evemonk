EvemonkApp.Views.HeaderView = Backbone.View.extend({
    events: {
        'click .sign-in' : 'handleClick',
        'click .sign-up' : 'handleClick'
    },

    render: function () {
        this.el.innerHTML = JST['header/show']();

        return this;
    },

    handleClick: function (event) {
        event.preventDefault();

        Backbone.history.navigate(event.target.getAttribute('href'), { trigger: true });
    }
});
