var User = Backbone.Model.extend({
    urlRoot: '/api/backoffice/users'
});

var Users = Backbone.Collection.extend({
    url: '/api/backoffice/users',
    model: User,
    parse: function(data) {
        return data.collection;
    }
});

var EveAgent = Backbone.Model.extend({});

var EveAgents = Backbone.Collection.extend({
    model: EveAgent,
    parse: function (data) {
        return data.collection;
    }
});
