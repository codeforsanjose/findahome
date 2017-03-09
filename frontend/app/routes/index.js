import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return this.get('store').findAll('listing');
  },

  setupController: function(controller, model) {
    let markers = model.map(function(marker) {
      return {
        id: marker.get('listing-id'),
        lat: marker.get('latitude'),
        lng: marker.get('longitude'),
        infoWindow: {
          content: `<a href=${marker.get('socialUrl')}>Listing URL<a>`,
          visible: false
        }
      };
    });

    controller.setProperties({
      lat: 37.338208,
      lng: -121.886329,
      zoom: 12,
      markers: markers,
      model: model
    });
  }
});
