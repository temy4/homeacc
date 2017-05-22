class DataImportController < ApplicationController
  skip_before_filter :verify_authenticity_token
  require 'csv'
  def upload
   file = params[:file]
   name = file.original_filename
   # permit index
   perms = ['.csv', '.xml']
   if !file.nil?
     if !perms.include?(File.extname(name).downcase)
       result = {state: 403, message: 'You can upload only CSV or XML'}
     elsif file.size > 10.megabyte
       result = {state: 403, message: 'File size should be up to 10MB'}
     else
       csv_text = File.read(file.path)
       csv = CSV.parse(csv_text, :headers => false)
       result = {state: 200, data: csv}
     end
   else
     result = 'File is nil'
   end
   render json: result
  end

  def import_csv
    @data_import = ""
    unless params['file'].nil?
      respond_to do |format|
        # if @sample.save
        #   format.js
        # end
      end
    end
  end
end
