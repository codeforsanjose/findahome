import DS from 'ember-data';

export default DS.Model.extend({
  propertyType: DS.attr('string'),
  bedrooms: DS.attr('number'),
  bathrooms: DS.attr('number'),
  leaseLength: DS.attr('string'),
  yearBuiltApprox: DS.attr('number'),
  squareFeetApprox: DS.attr('number'),
  furnished: DS.attr('string'),
  trashService: DS.attr('boolean'),
  lawnCare: DS.attr('string'),
  basement: DS.attr('string'),
  parkingType: DS.attr('string'),
  allottedParkingSpaces: DS.attr('string'),
  parkingInFrontOfPropertyEntrance: DS.attr('boolean'),
  leaseExtraSpaces: DS.attr('string'),
  unitEntry: DS.attr('string'),
  leverStyleDoorHandles: DS.attr('boolean'),
  doorKnockAndBellSignaller: DS.attr('boolean'),
  standardPeephole: DS.attr('boolean'),
  entryDoorIntercom: DS.attr('boolean'),
  deadboltOnEntryDoor: DS.attr('boolean'),
  securedEntryToBuilding: DS.attr('boolean'),
  automaticEntryDoor: DS.attr('boolean'),
  accessibleElevators: DS.attr('boolean'),
  unitOnFirstFloor: DS.attr('boolean'),
  multiStoryUnit: DS.attr('boolean'),
  busStop: DS.attr('string'),
  playground: DS.attr('boolean'),
  stove: DS.attr('string'),
  refrigeratorAndFreezer: DS.attr('string'),
  airConditioner: DS.attr('boolean'),
  clothesWasher: DS.attr('string'),
  clothesDryer: DS.attr('string'),
  laundryRoomAndFacility: DS.attr('string'),
  smokeDetector: DS.attr('string'),
  carbonMonoxideDetector: DS.attr('string'),
  heatingType: DS.attr('string'),
  waterHeater: DS.attr('string'),
  counterHeight: DS.attr('string'),
  nonDigitalKitchenAppliances: DS.attr('string'),
  frontControlsOnStoveandcookTop: DS.attr('boolean'),
  vanityHeight: DS.attr('string'),
  grabBars: DS.attr('boolean'),
  reinforcedForGrabBar: DS.attr('boolean'),
  rollInShower: DS.attr('boolean'),
  loweredToilet: DS.attr('boolean'),
  raisedToilet: DS.attr('boolean'),
  gatedFacility: DS.attr('boolean'),
  sidewalks: DS.attr('boolean'),
  emergencyExits: DS.attr('boolean'),
  dumpsters: DS.attr('boolean'),
  pool: DS.attr('boolean'),
  workOutRoom: DS.attr('boolean'),
  theater: DS.attr('boolean'),
  communityShuttle: DS.attr('boolean'),
  withinParatransitRoute: DS.attr('boolean'),
  signLanguageFriendly: DS.attr('boolean'),
  recreationalFacilities: DS.attr('boolean'),
  apartmentName: DS.attr('string'),
  address: DS.attr('string'),
  criminalCheck: DS.attr('boolean'),
  creditCheck: DS.attr('boolean'),
  acceptsSection8: DS.attr('boolean'),
  taxCreditProperty: DS.attr('boolean'),
  subsidizedRentOk: DS.attr('boolean'),
  seniorsOnly: DS.attr('boolean'),
  pets: DS.attr('boolean'),
  smoking: DS.attr('boolean'),
  securityDeposit: DS.attr('string'),
  applicationFee: DS.attr('string'),
  dateAvailable: DS.attr('string'),
  flooringMaterials: DS.attr('string'),
  otherAppliancesIncluded: DS.attr('string'),
  additionalPropertyOptions: DS.attr('string'),
  socialUrl: DS.attr('string'),
  latitude: DS.attr('number'),
  longitude: DS.attr('number'),
  shoppingVenues: DS.attr('string'),
  lightRailStation: DS.attr('string'),
  rentAmount: DS.attr('number')
});
