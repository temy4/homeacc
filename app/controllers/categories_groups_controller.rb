class CategoriesGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories_group, only: [:show, :edit, :update, :destroy, :recover]
  before_action :set_categories, only: [:update]
  before_action :delete_empty_categories, only: [:create, :update]
  before_action :find_categories, only: [:show]
  
  # GET /categories_groups
  # GET /categories_groups.json
  def index
    @categories_groups = CategoriesGroup.where('is_active = 1').order('alias')
  end

  # GET /categories_groups/1
  # GET /categories_groups/1.json
  def show
    @action = "show"
    @unit_categories = UnitCategory.where('is_active = 1').order('name')
  end

  # GET /categories_groups/new
  def new
    @action = "new"
    @categories_group = CategoriesGroup.new
    @unit_categories = UnitCategory.where('is_active = 1').order('name')
  end

  # GET /categories_groups/1/edit
  def edit
    @action = "edit"
    @unit_categories = UnitCategory.where('is_active = 1').order('name')
  end

  # POST /categories_groups
  # POST /categories_groups.json
  def create
    @unit_categories = UnitCategory.where('is_active = 1').order('name')
    @categories_group = CategoriesGroup.new(categories_group_params)
    respond_to do |format|
      if @categories_group.save
        params[:categories_group][:unit_categories].each do |uc|
          CategoriesGroupsUnitCategory.new(:unit_category_id => uc, :categories_group_id => @categories_group.id).save
        end
        format.html { redirect_to categories_groups_url, flash: { notice: 'Группа категорий "' + @categories_group.alias + '" была добавлена', type: 'created', state: 'ok' } }
        format.json { render :show, status: :created, location: @categories_group }
      else
        format.html { render :new }
        format.json { render json: @categories_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories_groups/1
  # PATCH/PUT /categories_groups/1.json
  def update
    respond_to do |format|
      params[:categories_group][:unit_categories].each do |uc|
        @cguc = CategoriesGroupsUnitCategory.new(:unit_category_id => uc, :categories_group_id => @categories_group.id).save
      end
      if @categories_group.update(categories_group_params)
        format.html { redirect_to @categories_group, flash: { notice: 'Группа категорий "' + @categories_group.alias + '" была изменена', type: 'updated', state: 'ok' } }
        format.json { render :show, status: :ok, location: @categories_group }
      else
        format.html { render :edit }
        format.json { render json: @categories_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories_groups/1
  # DELETE /categories_groups/1.json
  def destroy
    @categories_group.is_active = 0
    @categories_group.save
    CategoriesGroupsUnitCategory.where('categories_group_id = ' + @categories_group.id.to_s).delete_all
    
    respond_to do |format|
      format.html { redirect_to categories_groups_url, flash: { notice: 'Группа категорий была удалена', type: 'deleted', state: 'ok', rollback_url: "/categories_groups/#{params[:id]}/recover" } }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    CategoriesGroup.where(:id => params[:categories_groups]).update_all('is_active = 0')
    respond_to do |format|
      format.html { redirect_to categories_groups_url, flash: { notice: 'Группы категорий были удалены', type: 'updated', state: 'ok', rollback_url: "" } }
      format.json { head :no_content }
    end
  end
  
  # GET /counterparties/1/recover
  def recover
    @categories_group.is_active = 1
    @categories_group.save
    respond_to do |format|
      format.html { redirect_to categories_groups_url, flash: { notice: 'Группа категорий "' + @categories_group.alias + '" была восстановлена', type: 'updated', state: 'ok' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categories_group
      @categories_group = CategoriesGroup.find(params[:id])
    end
    def find_categories
      # p s
    end
    def set_categories
      
      CategoriesGroupsUnitCategory.where('categories_group_id = ' + @categories_group.id.to_s).delete_all
      
    end
    def delete_empty_categories
      params[:categories_group][:unit_categories].delete("")
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def categories_group_params
      params.require(:categories_group).permit(:alias, :is_active, unit_categories_attributes: [:id])
    end
end
