class Api::ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :update, :destroy]

  # GET /listings
  def index
    @listings = Listing.all

    render json: @listings
  end

  # GET /listings/1
  def show
    render json: @listing
  end

  # POST /listings
  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      render json: @listing, status: :created, location: @listing
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /listings/1
  def update
    if @listing.update(listing_params)
      render json: @listing
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /listings/1
  def destroy
    @listing.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def listing_params
      params.require(:listing).permit(:property_type, :bedrooms, :bathrooms, :lease_length, :year_built_approx, :square_feet_approx, :furnished, :trash_service, :lawn_care, :basement, :parking_type, :allotted_parking_spaces, :parking_in_front_of_property_entrance, :lease_extra_spaces, :unit_entry, :lever_style_door_handles, :door_knock_and_bell_signaller, :standard_peephole, :entry_door_intercom, :deadbolt_on_entry_door, :secured_entry_to_building, :automatic_entry_door, :accessible_elevators, :unit_on_first_floor, :multi_story_unit, :bus_stop, :playground, :stove, :refrigerator_and_freezer, :air_conditioner, :clothes_washer, :clothes_dryer, :laundry_room_and_facility, :smoke_detector, :carbon_monoxide_detector, :heating_type, :water_heater, :counter_height, :non_digital_kitchen_appliances, :front_controls_on_stoveandcook_top, :vanity_height, :grab_bars, :reinforced_for_grab_bar, :roll_in_shower, :lowered_toilet, :raised_toilet, :gated_facility, :sidewalks, :emergency_exits, :dumpsters, :pool, :work_out_room, :theater, :community_shuttle, :within_paratransit_route, :sign_language_friendly, :recreational_facilities, :name, :address, :criminal_check, :credit_check, :accepts_section_8, :tax_credit_property, :subsidized_rent_ok, :seniors_only, :pets, :smoking, :security_deposit, :application_fee, :date_available, :flooring_materials, :other_appliances_included)
    end
end
