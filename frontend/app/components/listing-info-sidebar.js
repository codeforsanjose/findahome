import Ember from 'ember';

export default Ember.Component.extend({
    didInsertElement: function() {
        Ember.run.scheduleOnce('afterRender', this, function() {
            this.$('.ui.range').range({
                min: 0,
                max: 10,
                start: 5,
                step:  1,
                smooth: true
            });
        });
    }
});
