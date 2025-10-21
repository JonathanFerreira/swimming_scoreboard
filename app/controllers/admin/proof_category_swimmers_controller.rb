class Admin::ProofCategorySwimmersController < ApplicationController
  layout 'admin'
  before_action :set_proof_category_swimmer, only: %i[ show edit update destroy ]

  # GET /proof_category_swimmers or /proof_category_swimmers.json
  def index
    @proof_category_swimmers = ProofCategorySwimmer.all
  end

  # GET /proof_category_swimmers/1 or /proof_category_swimmers/1.json
  def show
  end

  # GET /proof_category_swimmers/new
  def new
    @proof_category_swimmer = ProofCategorySwimmer.new
  end

  # GET /proof_category_swimmers/1/edit
  def edit
  end

  # POST /proof_category_swimmers or /proof_category_swimmers.json
  def create
    @proof_category_swimmer = ProofCategorySwimmer.new(proof_category_swimmer_params)
    puts "================================================"
    puts @proof_category_swimmer.inspect
    puts "================================================"
    respond_to do |format|
      if @proof_category_swimmer.save
        format.html { redirect_to admin_proof_category_swimmer_path(@proof_category_swimmer), notice: "Vínculação de prova, categoria e nadador foi criada com sucesso." }
        format.json { render :show, status: :created, location: @proof_category_swimmer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @proof_category_swimmer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proof_category_swimmers/1 or /proof_category_swimmers/1.json
  def update
    respond_to do |format|
      if @proof_category_swimmer.update(proof_category_swimmer_params)
        format.html { redirect_to admin_proof_category_swimmer_path(@proof_category_swimmer), notice: "Vínculação de prova, categoria e nadador foi atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @proof_category_swimmer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proof_category_swimmer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proof_category_swimmers/1 or /proof_category_swimmers/1.json
  def destroy
    @proof_category_swimmer.destroy!

    respond_to do |format|
      format.html { redirect_to admin_proof_category_swimmers_path, status: :see_other, notice: "Vínculação de prova, categoria e nadador foi deletada com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proof_category_swimmer
      @proof_category_swimmer = ProofCategorySwimmer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def proof_category_swimmer_params
      params.require(:proof_category_swimmer).permit(:proof_id, :category_id, :swimmer_id)
    end
end
