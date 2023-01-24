module V1
  class CagesController < ApplicationController
    before_action :set_cage, only: %i[ show update destroy ]

    # GET /v1/cages
    def index
      @cages = Cage.all.search(search_params)

      render json: @cages
    end

    # GET /v1/cages/1
    def show
      render json: @cage
    end

    # POST /v1/cages
    def create
      @cage = Cage.new(cage_params)

      if @cage.save
        render json: @cage, status: :created
      else
        render json: @cage.errors.full_messages, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /v1/cages/1
    def update
      if @cage.update(cage_params)
        render json: @cage
      else
        render json: @cage.errors.full_messages, status: :unprocessable_entity
      end
    end

    # DELETE /v1/cages/1
    def destroy
      @cage.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_cage
      @cage = Cage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cage_params
      params.require(:cage)
            .permit(:name, :max_capacity, :status)
    end

    def search_params
      params.fetch(:search_params, {})
    end
  end
end