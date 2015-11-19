# encoding: utf-8
class UnitCategoriesController < ApplicationController
  before_action :set_unit_category, only: [:show, :edit, :update, :destroy, :recover]

  # GET /unit_categories
  # GET /unit_categories.json
  def index
    @unit_categories = UnitCategory.where('is_active = 1').order('name')
  end

  # GET /unit_categories/1
  # GET /unit_categories/1.json
  def show
    @action = "show"
  end

  # GET /unit_categories/new
  def new
    @action = "new"
    @unit_category = UnitCategory.new
  end

  # GET /unit_categories/1/edit
  def edit
    @action = "edit"
  end

  # POST /unit_categories
  # POST /unit_categories.json
  def create
    @unit_category = UnitCategory.new(unit_category_params)

    respond_to do |format|
      if @unit_category.save
        format.html { redirect_to unit_categories_url, flash: { notice: 'Категория "' + @unit_category.name + '" была добавлена', type: 'created', state: 'ok' } }
        format.json { render :show, status: :created, location: @unit_category }
      else
        format.html { render :new }
        format.json { render json: @unit_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unit_categories/1
  # PATCH/PUT /unit_categories/1.json
  def update
    respond_to do |format|
      if @unit_category.update(unit_category_params)
        format.html { redirect_to unit_categories_url, flash: { notice: 'Категория "' + @unit_category.name + '" была изменена', type: 'updated', state: 'ok' } }
        format.json { render :show, status: :ok, location: @unit_category }
      else
        format.html { render :edit }
        format.json { render json: @unit_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_categories/1
  # DELETE /unit_categories/1.json
  def destroy
    @unit_category.is_active = 0
    @unit_category.save
    
    respond_to do |format|
      format.html { redirect_to unit_categories_url, flash: { notice: 'Категория была удалена', type: 'deleted', state: 'ok', rollback_url: "/unit_categories/#{params[:id]}/recover" } }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    UnitCategory.where(:id => params[:counterparties]).update_all('is_active = 0')
    respond_to do |format|
      format.html { redirect_to unit_categories_url, flash: { notice: 'Категории были удаленЫ', type: 'updated', state: 'ok', rollback_url: "" } }
      format.json { head :no_content }
    end
  end

  # GET /counterparties/1/recover
  def recover
    @unit_category.is_active = 1
    @unit_category.save
    respond_to do |format|
      format.html { redirect_to unit_categories_url, flash: { notice: 'Категория "' + @unit_category.name + '" была восстановлена', type: 'updated', state: 'ok' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit_category
      @unit_category = UnitCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_category_params
      params.require(:unit_category).permit(:name, :counterparty_id)
    end
end
