require "data_models/model_rdf"
 
class RDFa 

   def self.model(model)
     
   end

   def self.attribute(model,attributes)
      
   end

   ####################################
   # HTML Tags
   ####################################

   #-----------------------------------------------Links
   def a(model,href,attribute=nil,options=nil)
      _html_code('a',model,attribute,"href='#{href||'#'}' "+options.to_s)
   end

   #-----------------------------------------------End Links
   #-----------------------------------------------List_to_user
   def ul(model,value,attribute=nil,options=nil)
      _html_code_list('ul',model,value,options)
   end
 
   def ol(model,value,attribute=nil,options=nil)
      _html_code_list('ol',model,value,options)
   end
   #-----------------------------------------------End List_to_user
   #------------------------------------------------AUTO-CLOSED   
   def img(model,value,attribute=nil,options=nil)
      _html_code('img',model,nil,attribute,"src='#{value||'#'}' "+options.to_s)
   end

   def input(model,type,attribute=nil,options=nil)
      nil
   end
   #------------------------------------------------END AUTO-CLOSED   

   # This method is called if doesnt exist the method called by class's users
   def method_missing(sym, *args, &block)
     _html_code(sym.to_s,args[0],args[1],args[2],args[3])
   end

   #######################################
   # Generate html code with RDFa info
   #######################################
   private

   def _html_code(tag,model,value,attribute,options = "")
    rdf_info = ModelRdf.new    

    if attribute.nil? #prefix + type_of
      options = (options || "") + rdf_info.get_prefix(model)
      options = options + rdf_info.model(model)
    else  #property
      options = (options||"") + rdf_info.attribute(model,attribute)
    end
    
    unless value.nil?
     "<#{tag} #{options}>#{value}</#{tag}>"
    else
     "<#{tag} #{options}/>"
    end
   end

   def _html_code_list(tag,model,value,options = "")
    rdf_info = ModelRdf.new    

    options = (options || "") + rdf_info.get_prefix(model)
    options = options + rdf_info.model(model)
    
    data_model = rdf_info.get_attributes_model(model)

    html = "<#{tag} #{options}>"
    unless value.nil?
     data_model["attributes"].each do |att,info|
      if info[:namespace] && info[:property]
        html << "<li property='#{info[:namespace]}:#{info[:property]}'>#{value.attributes[att]}</li>"
      end
     end
    
     html << "</#{tag}>"
    end
    html
   end


end