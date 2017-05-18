import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    model() {
      return this.get('store').findAll('listing');
    }
  }
});
