class TaxesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tax, only: [:show, :edit, :update, :destroy, :recover]

  # GET /taxes
  # GET /taxes.json
  def index
    @taxes = Tax.where('is_active = 1')
  end

  # GET /taxes/1
  # GET /taxes/1.json
  def show
    @action = "show"
    @taxes = Tax.where('is_active = 1')
  end

  # GET /taxes/new
  def new
    @action = "new"
    @tax = Tax.new
    @taxes = Tax.where('is_active = 1')
  end

  # GET /taxes/1/edit
  def edit
    @action = "edit"
    @taxes = Tax.where('is_active = 1')
  end

  # POST /taxes
  # POST /taxes.json
  def create
    @tax = Tax.new(tax_params)
    respond_to do |format|
      if @tax.save
        format.html { redirect_to taxes_url, notice: 'Налог "' + @tax.name + '" был успешно добавлен', type: 'created', state: 'ok' }
        format.json { render :show, status: :created, location: @tax }
      else
        format.html { render :new }
        format.json { render json: @tax.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /taxes/1
  # PATCH/PUT /taxes/1.json
  def update
    respond_to do |format|
      if @tax.update(tax_params)
        format.html { redirect_to taxes_url, notice: 'Налог был успешно обновлен', type: 'created', state: 'ok' }
        format.json { render :show, status: :ok, location: @tax }
      else
        format.html { render :edit }
        format.json { render json: @tax.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taxes/1
  # DELETE /taxes/1.json
  def destroy
    @tax.is_active = 0
    @tax.save
    respond_to do |format|
      format.html { redirect_to taxes_url, flash: { notice: 'Налог был удален', type: 'deleted', state: 'ok', rollback_url: "/taxes/#{params[:id]}/recover" } }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    Tax.where(:id => params[:taxes]).update_all('is_active = 0')

    respond_to do |format|
      format.html { redirect_to taxes_url, flash: { notice: 'Выбранные налоги были удалены', type: 'updated', state: 'ok', rollback_url: "" } }
      format.json { head :no_content }
    end
  end

  def recover
    @tax.is_active = 1
    @tax.save
    respond_to do |format|
      tax_name = @tax.name
      format.html { redirect_to taxes_url, flash: { notice: 'Налог "' + tax_name + '" был восстановлен', type: 'updated', state: 'ok' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax
      @tax = Tax.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tax_params
      params.require(:tax).permit(:name, :percent, :desc)
    end
end
