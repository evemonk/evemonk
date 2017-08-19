var Profile = Backbone.Model.extend({

});

var CurrentSession = Backbone.Model.extend({});

var Session = Backbone.Model.extend({});

var Sessions = Backbone.Collection.extend({
    model: Session,
    url: '/api/sessions'
});

var EveMonkRouter = Backbone.Router.extend({
    routes: {
        '': 'root',
        'profile': 'profile',
        'character/:id': 'character'
    },
    root: function () {
        console.log('root');
    },
    profile: function () {
        console.log('profile');
    },
    character: function (id) {
        console.log('Character: ', id);
    }
});

var evemonk_router = new EveMonkRouter();

Backbone.history.start({ pushState: true });
