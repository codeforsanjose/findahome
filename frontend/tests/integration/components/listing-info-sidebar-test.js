import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';
import Ember from 'ember';

moduleForComponent('listing-info-sidebar', 'Integration | Component | listing info sidebar', {
  integration: true
});

test('it renders', function(assert) {
  assert.expect(5);
  let stubRental = Ember.Object.create({
    title: 'test-title',
    address: 'test-address',
    rent: 'test-rent',
    bedrooms: 'test-bedrooms',
    bathrooms: 'test-bathrooms'
  });
  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });
  this.set('listing', stubRental);
  this.render(hbs`{{listing-info-sidebar}}`);
  assert.equal(this.$('#dummy-image').attr('src'), "https://d37lj287rvypnj.cloudfront.net/161528805/640x480");
});
