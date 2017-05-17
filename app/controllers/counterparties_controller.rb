# encoding: utf-8
class CounterpartiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_counterparty, only: [:show, :edit, :update, :destroy, :recover]

  # GET /counterparties
  # GET /counterparties.json
  def index
    @counterparties = Counterparty.where('is_active = 1').order('counterparty_name')
  end

  # GET /counterparties/1
  # GET /counterparties/1.json
  def show
    @action = "show"
  end

  # GET /counterparties/new
  def new
    @action = "new"
    @counterparty = Counterparty.new
  end

  # GET /counterparties/1/edit
  def edit
    @action = "edit"
  end

  # POST /counterparties
  # POST /counterparties.json
  def create
    @counterparty = Counterparty.new(counterparty_params)

    respond_to do |format|
      if @counterparty.save
        format.html { redirect_to counterparties_url, flash: { notice: 'Контрагент "' + @counterparty.counterparty_name + '" был добавлен', type: 'created', state: 'ok' } }
        format.json { render :show, status: :created, location: @counterparty }
      else
        format.html { render :new }
        format.json { render json: @counterparty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /counterparties/1
  # PATCH/PUT /counterparties/1.json
  def update
    respond_to do |format|
      if @counterparty.update(counterparty_params)
        format.html { redirect_to counterparties_url, flash: { notice: 'Контрагент "' + @counterparty.counterparty_name + '" был изменен', type: 'updated', state: 'ok' } }
        format.json { render :show, status: :ok, location: @counterparty }
      else
        format.html { render :edit }
        format.json { render json: @counterparty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counterparties/1
  # DELETE /counterparties/1.json
  def destroy
    # @counterparty.destroy
    @counterparty.is_active = 0
    @counterparty.save
    respond_to do |format|
      format.html { redirect_to counterparties_url, flash: { notice: 'Контрагент был удален', type: 'deleted', state: 'ok', rollback_url: "/counterparties/#{params[:id]}/recover" } }
      format.json { head :no_content }
    end
  end
  
  def destroy_multiple
    Counterparty.where(:id => params[:counterparties]).update_all('is_active = 0')
    respond_to do |format|
      format.html { redirect_to counterparties_url, flash: { notice: 'Контрагенты были удалены', type: 'updated', state: 'ok', rollback_url: "" } }
      format.json { head :no_content }
    end
  end

  # GET /counterparties/1/recover
  def recover
    @counterparty.is_active = 1
    @counterparty.save
    respond_to do |format|
      format.html { redirect_to counterparties_url, flash: { notice: 'Контрагент "' + @counterparty.counterparty_name + '" был восстановлен', type: 'updated', state: 'ok' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_counterparty
      @counterparty = Counterparty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def counterparty_params
      params.require(:counterparty).permit(:counterparty_name)
    end
end
