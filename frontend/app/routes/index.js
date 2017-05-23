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
          content: `

                    <div class="ui list">
                      <div class="item">

                        <div class="content">
                          <h3>${marker.get('propertyName')}</h3>
                        </div>
                      </div>
                      <div class="item">
                        <i class="call icon"></i>
                        <div class="content">
                          ${marker.get('propertyManagementPhone')}
                        </div>
                      </div>
                      <div class="item">
                        <i class="linkify icon"></i>
                        <div class="content">
                          <a href=${marker.get('propertyWebsite')}>Website</a>
                        </div>
                      </div>
                      <div class="item">
                        <i class="users icon"></i>
                        <div class="content">
                          ${marker.get('propertyType')}
                        </div>
                      </div>
                    </div>

                    `,
          visible: false
        }
      };
    });

    controller.setProperties({
      lat: 37.338208,
      lng: -121.886329,
      zoom: 11,
      markers: markers,
      model: model
    });
  }
});
