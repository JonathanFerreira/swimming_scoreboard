class Admin::SwimmingMarkerGroupsController < ApplicationController
  layout 'admin'
  before_action :set_swimming_marker_group, only: %i[ show edit update destroy ]

  # GET /swimming_marker_groups or /swimming_marker_groups.json
  def index
    @swimming_marker_groups = SwimmingMarkerGroup.includes(:proof, :category)
  end

  # GET /swimming_marker_groups/1 or /swimming_marker_groups/1.json
  def show
  end

  # GET /swimming_marker_groups/new
  def new
    @swimming_marker_group = SwimmingMarkerGroup.new
  end

  # GET /swimming_marker_groups/1/edit
  def edit
  end

  # POST /swimming_marker_groups or /swimming_marker_groups.json
  def create
    @swimming_marker_group = SwimmingMarkerGroup.new(swimming_marker_group_params)

    respond_to do |format|
      if @swimming_marker_group.save
        format.html { redirect_to admin_swimming_marker_group_path(@swimming_marker_group), notice: "Swimming marker group was successfully created." }
        format.json { render :show, status: :created, location: @swimming_marker_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @swimming_marker_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /swimming_marker_groups/1 or /swimming_marker_groups/1.json
  def update
    respond_to do |format|
      if @swimming_marker_group.update(swimming_marker_group_params)
        format.html { redirect_to admin_swimming_marker_group_path(@swimming_marker_group), notice: "Swimming marker group was successfully updated." }
        format.json { render :show, status: :ok, location: @swimming_marker_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @swimming_marker_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /swimming_marker_groups/1 or /swimming_marker_groups/1.json
  def destroy
    @swimming_marker_group.destroy!

    respond_to do |format|
      format.html { redirect_to admin_swimming_marker_groups_path, status: :see_other, notice: "Swimming marker group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /swimming_marker_groups/categories_by_proof
  def categories_by_proof
    proof = Proof.find(params[:proof_id])
    categories = proof.categories
    respond_to do |format|
      format.json { render json: categories.map { |category| { id: category.id, name: category.name } } }
    end
  end

  def automatic; end

  def generate_automatic
    if params[:competition_id].present?
      competition = Competition.find(params[:competition_id])
      Admin::SwimmingMarkerGroupGeneratorService.new(competition.id).call
      redirect_to admin_swimming_marker_groups_path, notice: "Geração automática realizada com sucesso."
    else
      render :new_automatic_groups, status: :unprocessable_entity, alert: "Precisa selecionar uma competição."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_swimming_marker_group
      @swimming_marker_group = SwimmingMarkerGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def swimming_marker_group_params
      params.require(:swimming_marker_group).permit(:proof_id, :category_id)
    end
end
