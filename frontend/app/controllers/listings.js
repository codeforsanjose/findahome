import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    filterByAddress(param) {
      if (param !== '') {
        return this.get('store').query('listing', { address: param });
      } else {
        return this.get('store').findAll('listing');
      }
    }
  }
});
