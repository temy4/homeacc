class MoneyUnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_money_unit, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /money_units
  # GET /money_units.json
  def index
    @money_units = MoneyUnit.where('is_active = 1')
  end

  # GET /money_units/1
  # GET /money_units/1.json
  def show
    @action = "show"
    @money_units = MoneyUnit.where('is_active = 1')
  end

  # GET /money_units/new
  def new
    @action = "new"
    @money_unit = MoneyUnit.new
    @money_units = MoneyUnit.where('is_active = 1')
  end

  # GET /money_units/1/edit
  def edit
    @action = "edit"
    @money_units = MoneyUnit.where('is_active = 1')
  end

  # POST /money_units
  # POST /money_units.json
  def create
    @money_unit = MoneyUnit.new(money_unit_params)

    respond_to do |format|
      if @money_unit.save
        format.html { redirect_to @money_unit, notice: 'Money unit was successfully created.' }
        format.json { render :show, status: :created, location: @money_unit }
      else
        format.html { render :new }
        format.json { render json: @money_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /money_units/1
  # PATCH/PUT /money_units/1.json
  def update
    respond_to do |format|
      if @money_unit.update(money_unit_params)
        format.html { redirect_to @money_unit, notice: 'Money unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @money_unit }
      else
        format.html { render :edit }
        format.json { render json: @money_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /money_units/1
  # DELETE /money_units/1.json
  def destroy
    # @money_unit.destroy
    @money_unit.is_active = 0
    @money_unit.save
    respond_to do |format|
      format.html { redirect_to money_units_url, flash: { notice: 'Операция была удалена', type: 'deleted', state: 'ok', rollback_url: "" } }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    MoneyUnit.where(:id => params[:money_units]).update_all('is_active = 0')

    respond_to do |format|
      format.html { redirect_to cards_url, flash: { notice: 'Операции были удалены', type: 'updated', state: 'ok', rollback_url: "" } }
      format.json { head :no_content }
    end
  end


  def money_in
    @action = "new"
    @money_unit = MoneyUnit.new
    @operation = "in"
    @heading = "Внести прибыль"
    respond_to do |format|
      format.html { render :new }
    end
  end

  def money_out
    @action = "new"
    @money_unit = MoneyUnit.new
    @heading = "Внести расход"
    @operation = "out"
    respond_to do |format|
      format.html { render :new }
    end
  end

  def get_cf_data
    # client_id = params[:client_id]
    # @projects = Project.where(client_id: client_id)
    money_units = []
    MoneyUnit.where('is_active = 1 AND transaction_date BETWEEN ? AND ?', params[:date_from], params[:date_to]).each do |mu|
      money_units.push([mu, mu.counterparty, mu.unit_category, mu.currency])
    end

    chart_out_data = VMoneyUnitsOut.group(:alias).order(:transaction_date).where('transaction_type="out" AND transaction_date BETWEEN ? AND ?', params[:date_from], params[:date_to]).sum(:total).to_a
    chart_in_data = VMoneyUnitsOut.group(:alias).order(:transaction_date).where('transaction_type="in" AND transaction_date BETWEEN ? AND ?', params[:date_from], params[:date_to]).sum(:total).to_a

    respond_to do |format|
      format.json { render json: [money_units, chart_out_data, chart_in_data] }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_money_unit
      @money_unit = MoneyUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def money_unit_params
      params.require(:money_unit).permit(:counterparty_id, :transaction_date, :unit_category_id, :currency_id, :tax_id, :transaction_type, :name, :job_description, :starting_amount, :planned_amount, :next_period_price, :current_period, :next_period, :is_active)
    end
end
