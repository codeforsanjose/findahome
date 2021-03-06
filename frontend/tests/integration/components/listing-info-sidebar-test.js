import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('listing-info-sidebar', 'Integration | Component | listing info sidebar', {
  integration: true
});

test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{listing-info-sidebar}}`);
  assert.equal(this.$('#dummy-image').attr('src'), "https://d37lj287rvypnj.cloudfront.net/161528805/640x480");
});
