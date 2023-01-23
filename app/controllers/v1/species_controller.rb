module V1
  class SpeciesController < ApplicationController
    before_action :set_specy, only: %i[ show update destroy ]

    # GET /v1/species
    def index
      @species = Species.all

      render json: @species
    end

    # GET /v1/species/1
    def show
      render json: @specy
    end

    # POST /v1/species
    def create
      @specy = Species.new(specy_params)

      if @specy.save
        render json: @specy, status: :created, location: @specy
      else
        render json: @specy.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /v1/species/1
    def update
      if @specy.update(specy_params)
        render json: @specy
      else
        render json: @specy.errors, status: :unprocessable_entity
      end
    end

    # DELETE /v1/species/1
    def destroy
      @specy.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_specy
        @specy = Species.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def specy_params
        params.fetch(:specy, {})
      end
  end
end