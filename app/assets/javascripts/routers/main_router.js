EvemonkApp.Routers.MainRouter = Backbone.Router.extend({
    routes: {
        '' : 'index',
        'sign_up' : 'sign_up',
        'sign_in' : 'sign_in',
        'sign_out' : 'sign_out',
        'profile' : 'profile',
        'characters?page=:page' : 'characters_page',
        'characters' : 'characters',
        'characters/:id' : 'show_character'
    }
});
