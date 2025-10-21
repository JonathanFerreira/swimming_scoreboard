class Admin::SwimmersController < ApplicationController
  layout 'admin'
  before_action :set_swimmer, only: %i[ show edit update destroy ]

  # GET /swimmers or /swimmers.json
  def index
    @swimmers = Swimmer.all
  end

  # GET /swimmers/1 or /swimmers/1.json
  def show
  end

  # GET /swimmers/new
  def new
    @swimmer = Swimmer.new
  end

  # GET /swimmers/1/edit
  def edit
  end

  # POST /swimmers or /swimmers.json
  def create
    @swimmer = Swimmer.new(swimmer_params)

    respond_to do |format|
      if @swimmer.save
        format.html { redirect_to admin_swimmer_path(@swimmer), notice: "Swimmer was successfully created." }
        format.json { render :show, status: :created, location: @swimmer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @swimmer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /swimmers/1 or /swimmers/1.json
  def update
    respond_to do |format|
      if @swimmer.update(swimmer_params)
        format.html { redirect_to admin_swimmer_path(@swimmer), notice: "Swimmer was successfully updated." }
        format.json { render :show, status: :ok, location: @swimmer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @swimmer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /swimmers/1 or /swimmers/1.json
  def destroy
    @swimmer.destroy!

    respond_to do |format|
      format.html { redirect_to admin_swimmers_path, status: :see_other, notice: "Swimmer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_swimmer
    @swimmer = Swimmer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def swimmer_params
    params.require(:swimmer).permit(:name, :phone_number, :birthdate, :gender, :team_id)
  end
end
