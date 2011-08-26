require "action_controller"
require "action_view"
require "builder"

class EasyDatasController < ActionController::Base
  
  layout 'easy_data_layout'
  
  before_filter :authenticated, :only => [:custom_rdf]

  def show
       
      model = eval params[:model].to_s
      
      conditions = parser_params(params)
     
      rdf = ModelRdf.new      
      
      no_valid = lambda{|c| c.nil?||c.empty?}

      unless conditions.empty?
       begin
        @reply = model.find :all, :conditions => conditions || nil
       rescue
        @reply = nil
       end
      end
      
      unless @reply.nil?
        @host="http://"+request.env["HTTP_HOST"]          
      
        @rdf_model = rdf.get_model_rdf(@reply,params[:model],"http://"+request.env["HTTP_HOST"])
      end

      @xml = Builder::XmlMarkup.new
      
      if no_valid.call(@rdf_model[:header]) || @reply.nil?  # If the URI not available or data no publicated
         render :nothing => true, :status => 404
      else  
       respond_to do |format|
         format.html
         format.xml                     # render :template => "/rdf/request.xml.builder"   
       end
      end
      
  end

  def show_all
      model = eval params[:model].to_s
      
      rdf = ModelRdf.new      
      
      no_valid = lambda{|c| c.nil?||c.empty?}

      @reply = model.find :all || nil
      
      @host="http://"+request.env["HTTP_HOST"]          
      
      @rdf_model = rdf.get_model_rdf(@reply,params[:model],"http://"+request.env["HTTP_HOST"])
      
      @xml = Builder::XmlMarkup.new
      
      if no_valid.call(@rdf_model[:header]) || @reply.nil?  # If the URI not available or data no publicated
        render :nothing => true, :status => 404
      else
        respond_to do |format|
          format.html
          format.xml # render :template => "/rdf/request.xml.builder"   
        end
      end
  end

  # Show information about data publications
  # 
  #
  def info_easy_data
      models = DataModels.load_models
      @list = []
      @settings ||= YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))
      
      models.each do |mod|
       @list << "#{mod.gsub("::","_")}"
      end

      respond_to do |format|
        format.html
        format.xml
      end
  end

  # Information about access to publicated data
  def access_to_data 
  end

  # Generate Linked Data Graph
  def linked_data
  end
  
  # FAQ 
  def faq
  end

  def custom_rdf
    @models = DataModels.load_models
    @settings ||= YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))
  end

  def model_attributes
    
    rdf = ModelRdf.new
    
    @model_attributes = rdf.get_attributes_model(params[:model])
    @model = params[:model]
    

    render :partial => "model_attributes",:layout => nil

  end

  def model_attributes_edit

     rdf = ModelRdf.new

     @model_attributes = rdf.get_attributes_model(params[:model])
     @model = params[:model]
     @namespaces = EasyData::RDF::Namespaces.list_form
     
     render :partial => "model_attributes_edit",:layout => nil
  
  end

  def model_attributes_info
    rdf = ModelRdf.new
    
    @model_attributes = rdf.get_attributes_model(params[:model])
    @model = params[:model]

    render :partial => "model_attributes_info",:layout => nil
  end

  def load_properties
  
     unless params[:id] == ""
       namespace = "EasyData::RDF::#{params[:id].upcase}"

       rdf = ModelRdf.new    
 
       @namespace = params[:id]
       @model_attributes = rdf.get_attributes_model(params[:model])
       
       properties = (eval namespace).properties_form
       
       if params[:attribute]!=params[:model]
         render :inline => "<span>Property:</span><%= select type+'_property',attribute,properties,{:prompt => 'Select a property...'} -%><span class='rdf_info'>(Current value: <%= current_value%>)</span>",
                          :locals => {:properties => properties,
                                      :type => params[:type],
                                      :attribute => params[:attribute],
                                      :current_value => @model_attributes[params[:type]][params[:attribute]][:property]}
       else
         render :inline => "<span>Property:</span><%= select 'property',attribute,properties,{:prompt => 'Select a property...'} -%><span class='rdf_info'>(Current value: <%= current_value%>)</span><br />",
                          :locals => {:properties => properties,
                                      :attribute => params[:model],
                                      :current_value => @model_attributes[:property]}

       end
     else
       render :inline => ""
     end
  end
  
  def load_linked_data_graph
     if params[:model]
      @model = params[:model]
      render :partial => "linked_data_model"
     else
      models = DataModels.load_models
      @list = []
      
      models.each do |mod|
       @list << "#{mod.gsub("::","_")}"
      end

      render :partial => "linked_datas",:layout => nil
     end
  end

  def custom_attributes
    
     rdf = ModelRdf.new
     @model = params[:model]
     
     params["rdf_type_attributes"].each do |att,value|
        rdf.update_attributes_model(params[:model],att,'namespace',value) if value != ""
        if params["attributes_property"] && !params["attributes_property"][att].nil?
         rdf.update_attributes_model(params[:model],att,'property',params["attributes_property"][att])  
        end
        rdf.update_attributes_model(params[:model],att,'privacy',params[:privacy][att])
     end
     
     
     params["rdf_type_associations"].each do |assoc,value|
        
        if value != ""
         rdf.update_associations_model(params[:model],assoc,'namespace',value)
        end
        if params["associations_property"] && params["assocciations_property"][assoc]
         rdf.update_associations_model(params[:model],assoc,'property',params["associations_property"][assoc])
        end
         rdf.update_associations_model(params[:model],assoc,'privacy',params[:privacy][assoc])
        
     end
     
     
     rdf.update_model(params[:model],"privacy",params[:privacy][params[:model]]) if params[:privacy][params[:model]]

     if params[:property]
       rdf.update_model(params[:model],"namespace",params[:namespace][params[:model]])
       rdf.update_model(params[:model],"property",params[:property][params[:model]]) 
     end
    
     rdf.save

     @model_attributes = rdf.get_attributes_model(@model)
     
     render :partial => "model_attributes",:layout => nil
  end
  
  def view_settings
    @settings ||= YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))
    render :template => "easy_datas/view_settings", :layout => false
  end

  def settings
     @settings ||= YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))
     @images = Dir["#{RAILS_ROOT}/public/images/*"].map{|img| [img.gsub("#{RAILS_ROOT}/public/images/",""),img.gsub("#{RAILS_ROOT}/public/images/","")]}
     render :partial => "settings",:layout => nil
  end

  def custom_settings
     @settings = YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))
     
     if !params["project"]["project"].empty? && params["project"]["project"]!=@settings["project"]["name"]
       @settings["project"]["name"] = params["project"]["project"]
     end

     if !params["project"]["logo"].empty? && params["project"]["logo"]!=@settings["project"]["logo"]
       @settings["project"]["logo"] = params["project"]["logo"]
     end

     if !params["project"]["description"].empty? && params["project"]["description"]!=@settings["project"]["description"]
       @settings["project"]["description"] = params["project"]["description"]
     end

     if !params["project"]["email"].empty? && params["project"]["email"]!=@settings["project"]["contact_email"]
       @settings["project"]["contact_email"] = params["project"]["email"]
     end
     
     if !params["user_admin"]["user"].empty? && !params["user_admin"]["pass"].empty?
       (@settings["user_admin"]["user"] = params["user_admin"]["user"]) if @settings["user_admin"]["user"]!=params["user_admin"]["user"]
       (@settings["user_admin"]["pass"] = params["user_admin"]["pass"]) if @settings["user_admin"]["pass"]!=params["user_admin"]["pass"]
     end

     if !params["access"]["ip"].empty?
       (@settings["access"]["ip"] = params["access"]["ip"]) if params["access"]["ip"]!=@settings["access"]["ip"]
     end
     
     save_settings(@settings)

     render :template => "easy_datas/view_settings",:layout => false
  end

  def authenticate_user
  end

  def login
    @admin = YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))

    if @admin["user_admin"]["user"] == params[:nick] && @admin["user_admin"]["password"] == params[:pass]
      @current_user = params[:nick]
      session[:easy_data_session] = params[:nick]
      redirect_to :action => "custom_rdf"
    else
      redirect_to :authenticate_user
    end
  end

  def logout
    @current_user = nil
    session[:easy_data_session]=nil if !session[:easy_data_session].nil?
    redirect_to :action => "authenticate_user"
  end

  private 

  # Extract all parameters to build the query.
  # @param [Hash] request's parameters 
  # @return [Hahs] Conditions hash
  def parser_params (parameters = nil)
     
     conditions = {}
    
     if !parameters.empty?
       parameters.each do |key,value| #Delete all elements that aren't need to query
         unless ["controller","action","method","format","model"].include?key
           conditions[key.to_sym] = value
         end   
       end
     end

     return conditions
     
  end

  def authenticated
    admin = YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))
    
    if admin["access"]["ip"].nil? || admin["access"]["ip"].to_s == request.ip.to_s
     if session[:easy_data_session].nil?
       redirect_to :action => "authenticate_user"
     end
    else
      render :nothing => true, :status => 404
    end
  end

  def save_settings(settings)
     file = File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml",'w')
     file.puts YAML::dump(settings)
     file.close
  end

end
