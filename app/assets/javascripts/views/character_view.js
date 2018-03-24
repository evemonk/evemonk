EvemonkApp.Views.CharacterView = Backbone.View.extend({
    events: {
        'click .destroy' : 'destroy'
    },

    template: JST['characters/show'],

    render: function () {
        this.$el.html(this.template(this.model.toJSON()));

        if(this.model.get('race') !== null) {
            var race = new EvemonkApp.Models.Race(this.model.get('race'));

            var raceView = new EvemonkApp.Views.RaceView({ model: race });

            this.$el.find('#race').html(raceView.render().el);
        }

        if(this.model.get('bloodline') !== null) {
            var bloodline = new EvemonkApp.Models.Bloodline(this.model.get('bloodline'));

            var bloodlineView = new EvemonkApp.Views.BloodlineView({ model: bloodline });

            this.$el.find('#bloodline').html(bloodlineView.render().el);
        }

        if(this.model.get('faction') !== null) {
            var faction = new EvemonkApp.Models.Faction(this.model.get('faction'));

            var factionView = new EvemonkApp.Views.FactionView({ model: faction });

            this.$el.find('#faction').html(factionView.render().el);
        }

        if(this.model.get('ancestry') !== null) {
            var ancestry = new EvemonkApp.Models.Ancestry(this.model.get('ancestry'));

            var ancestryView = new EvemonkApp.Views.AncestryView({ model: ancestry });

            this.$el.find('#ancestry').html(ancestryView.render().el);
        }

        if(this.model.get('alliance') !== null) {
            var alliance = new EvemonkApp.Models.Alliance(this.model.get('alliance'));

            var allianceView = new EvemonkApp.Views.AllianceView({ model: alliance });

            this.$el.find('#alliance').html(allianceView.render().el);
        }

        return this;
    },

    destroy: function (event) {
        event.preventDefault();

        if (confirm('Are you sure?') === true) {
            this.model.destroy();

            var flash = new EvemonkApp.Models.FlashSuccess({ message: 'Character successful removed.' });

            var flashView = new EvemonkApp.Views.FlashView({ model: flash });

            $('#flash').append(flashView.render().el);

            Backbone.history.navigate('characters', { trigger: true });
        } else {
            return false;
        }
    }
});
