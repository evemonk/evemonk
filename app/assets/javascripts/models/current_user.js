EvemonkApp.Models.CurrentUser = Backbone.Model.extend({
    initialize: function () {
        this.listenTo(EvemonkApp.Events, 'user:sign_in', this.sign_in);
        this.listenTo(EvemonkApp.Events, 'user:sign_out', this.sign_out);
    },

    sign_in: function () {
        this.set({ loggedIn: true });
    },

    sign_out: function () {
        this.set({ loggedIn: false });
    }
});
