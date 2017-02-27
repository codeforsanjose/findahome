import Ember from 'ember';

export default Ember.Route.extend({
    setupController: function(controller) {
        controller.setProperties({
            lat: 32.75494243654723,
            lng: -86.8359375,
            zoom: 4
        });
    },

  model() {
    return this.get('store').findAll('listing');
  }
});
