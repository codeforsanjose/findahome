import DS from 'ember-data';

export default DS.Model.extend({
  propertyName: DS.attr('string'),
  address: DS.attr('string'),
  latitude: DS.attr('number'),
  longitude: DS.attr('number'),
  propertyManager: DS.attr('string'),
  propertyManagementPhone: DS.attr('string'),
  propertyWebsite: DS.attr('string'),
  type: DS.attr('string'),
  population: DS.attr('string'),
  extremelyLowIncomeUnits: DS.attr('number'),
  veryLowIncomeUnits: DS.attr('number'),
  ModerateIncomeUnits: DS.attr('number'),
  hudUnits: DS.attr('number'),
  totalAffordableUnits: DS.attr('number')
});
