import Ember from 'ember';

export default Ember.Route.extend({
  setupController: function(controller) {
    controller.setProperties({
      lat: 37.338208,
      lng: -121.886329,
      zoom: 12,
      markers: Ember.A([
        {
          id: 'unique',
          lat: 37.338208,
          lng: -121.886329,
          infoWindow: {
            content: '<p>Hi there!</p>',
            visible: false
          }
        }
      ])
    });
  },

  model() {
    return this.get('store').findAll('listing');
  }
});
