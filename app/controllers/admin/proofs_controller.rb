class Admin::ProofsController < ApplicationController
  layout 'admin'
  before_action :set_proof, only: %i[ show edit update destroy ]

  # GET /proofs or /proofs.json
  def index
    @proofs = Proof.all
  end

  # GET /proofs/1 or /proofs/1.json
  def show
  end

  # GET /proofs/new
  def new
    @proof = Proof.new
  end

  # GET /proofs/1/edit
  def edit
  end

  # POST /proofs or /proofs.json
  def create
    @proof = Proof.new(proof_params)

    respond_to do |format|
      if @proof.save
        format.html { redirect_to admin_proof_path(@proof), notice: "Proof was successfully created." }
        format.json { render :show, status: :created, location: @proof }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @proof.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proofs/1 or /proofs/1.json
  def update
    respond_to do |format|
      if @proof.update(proof_params)
        format.html { redirect_to admin_proof_path(@proof), notice: "Proof was successfully updated." }
        format.json { render :show, status: :ok, location: @proof }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proof.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proofs/1 or /proofs/1.json
  def destroy
    @proof.destroy!

    respond_to do |format|
      format.html { redirect_to proofs_path, status: :see_other, notice: "Proof was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proof
      @proof = Proof.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def proof_params
      params.require(:proof).permit(:name, :slug, :competition_id)
    end
end
