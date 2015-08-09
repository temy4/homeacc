class MoneyUnitsController < ApplicationController
  before_action :set_money_unit, only: [:show, :edit, :update, :destroy]

  # GET /money_units
  # GET /money_units.json
  def index
    @money_units = MoneyUnit.all
  end

  # GET /money_units/1
  # GET /money_units/1.json
  def show
  end

  # GET /money_units/new
  def new
    @money_unit = MoneyUnit.new
  end

  # GET /money_units/1/edit
  def edit
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
    @money_unit.destroy
    respond_to do |format|
      format.html { redirect_to money_units_url, notice: 'Money unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_money_unit
      @money_unit = MoneyUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def money_unit_params
      params.require(:money_unit).permit(:counterparty_id, :currency_id, :tax_id, :type, :name, :period, :current_period_price, :next_period_price, :current_period, :next_period, :is_active)
    end
end
