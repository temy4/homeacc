# encoding: utf-8
class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy, :recover]

  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.where('is_active = 1').order('card_number')
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @action = "show"
    @currencies = Currency.all
  end

  # GET /cards/new
  def new
    @action = "new"
    @card = Card.new
    @currencies = Currency.all
  end

  # GET /cards/1/edit
  def edit
    @action = "edit"
    @currencies = Currency.all
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)
    respond_to do |format|
      if @card.save
        card_name = @card.card_number
        if @card.alias.nil? or @card.alias.empty?
          card_name = @card.card_number
        else
          card_name = @card.alias
        end
        format.html { redirect_to cards_url, flash: { notice: 'Карта "' + card_name + '" была добавлена', type: 'created', state: 'ok' } }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update    
    respond_to do |format|
      if @card.update(card_params)
        card_name = @card.card_number
        if @card.alias.nil? or @card.alias.empty?
          card_name = @card.card_number
        else
          card_name = @card.alias
        end
        format.html { redirect_to cards_url, flash: { notice: 'Карта "' + card_name + '" была изменена', type: 'updated', state: 'ok' } }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    # @card.destroy
    @card.is_active = 0
    @card.save
    respond_to do |format|
      format.html { redirect_to cards_url, flash: { notice: 'Карта была удалена', type: 'deleted', state: 'ok', rollback_url: "/cards/#{params[:id]}/recover" } }
      format.json { head :no_content }
    end
  end
  
  def destroy_multiple
    Card.where(:id => params[:cards]).update_all('is_active = 0')

    respond_to do |format|
      format.html { redirect_to cards_url, flash: { notice: 'Карты были удалены', type: 'updated', state: 'ok', rollback_url: "" } }
      format.json { head :no_content }
    end
  end
  
  # GET /counterparties/1/recover
  def recover
    @card.is_active = 1
    @card.save
    respond_to do |format|
      card_name = @card.card_number
      if @card.alias.nil? or @card.alias.empty?
        card_name = @card.card_number
      else
        card_name = @card.alias
      end
      format.html { redirect_to cards_url, flash: { notice: 'Карта "' + card_name + '" была восстановлена', type: 'updated', state: 'ok' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:cc_type, :currency_id, :card_number, :month_end, :year_end, :owner, :alias, :is_active)
    end
end
