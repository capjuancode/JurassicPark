module V1
  class DinosController < ApplicationController
    before_action :set_dino, only: %i[ show update destroy ]

    # GET /v1/dinos
    def index
      @dinos = Dino.all.search(search_params)

      render json: @dinos
    end

    # GET /v1/dinos/1
    def show
      render json: @dino
    end

    # POST /v1/dinos
    def create
      @dino = Dino.new(dino_params)

      if @dino.save
        render json: @dino, status: :created, location: @dino
      else
        render json: @dino.errors.full_messages, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /v1/dinos/1
    def update
      if @dino.update(dino_params)
        render json: @dino
      else
        render json: @dino.errors.full_messages, status: :unprocessable_entity
      end
    end

    # DELETE /v1/dinos/1
    def destroy
      @dino.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
    def set_dino
      @dino = Dino.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dino_params
      params.fetch(:dino, {})
    end

    def search_params
      params.fetch(:search_params, {})
    end
  end
end