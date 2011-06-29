require "easy_data/version"
require "data_models/data_models"
require "action_controller"
require "controllers/easy_datas_controller"
require "routes"
require 'ftools'


module EasyData

  def show_linked_data
    models = LinkedData.find :all
  end
  
  # Changes model's attributes with ajax call
  def update_linked_data_model
     
     model = LinkedData.find_by_model params[:model]  
     
     attributes = model["attributes"].to_hash
     attributes[params[:attribute]] = !attributes[params[:attribute]]

     model["query"] = generate_query(params[:model],attributes)
     model["attributes"] = attributes.to_set

     if model.valid?
       model.save
     else 
       false
     end
  end
 
  def self.yaml_description_model(model_data)

    attributes = {}
   
    model_data.columns.each do |att|
  
     if att.primary
       attributes[att.name] = {:privacy => 'private',:rdf_type => 'property'}
     elsif att.name =~ /_id$/
       attributes[att.name] = "no publication"
     else
       attributes[att.name] = {:privacy => 'public',:rdf_type => "property"}
     end

    end  
  
    attributes
  end

 
  private
 
  def generate_query(model,params)
     query = "Select #{params.key.join(", ")}
              FROM #{model};"
  end

    
end

