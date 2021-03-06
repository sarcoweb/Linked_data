module EasyData
  module RDF
   class DC < Namespaces
     @@uri = "http://purl.org/dc/elements/1.1/"    
 
     @@properties = {"abstract" => "",
                     "accessRights" => "",
                     "accrualMethod" => "",
                     "accrualPeriodicity" => "",
                     "accrualPolicy" => "",
                     "alternative" => "",
                     "audience" => "",
                     "available" => "",
                     "bibliographicCitation" => "",
                     "conformsTo" => "",
                     "contributor" => "",
                     "coverage" => "",
                     "created" => "",
                     "creator" => "",
                     "date" => "",
                     "dateAccepted" => "",
                     "dateCopyrighted" => "",
                     "dateSubmitted" => "",
                     "description" => "",
                     "educationLevel" => "",
                     "extent" => "",
                     "format" => "",
                     "hasFormat" => "",
                     "hasPart" => "",
                     "hasVersion" => "",
                     "identifier" => "",
                     "instructionalMethod" => "",
                     "isFormatOf" => "",
                     "isPartOf" => "",
                     "isReferencedBy" => "",
                     "isReplacedBy" => "",
                     "isRequiredBy" => "",
                     "isVersionOf" => "",
                     "issued" => "",
                     "language" => "",
                     "license" => "",
                     "mediator" => "",
                     "medium" => "",
                     "modified" => "",
                     "provenance" => "",
                     "publisher" => "",
                     "references" => "",
                     "relation" => "",
                     "replaces" => "",
                     "requires" => "",
                     "rights" => "",
                     "rightsHolder" => "",
                     "source" => "",
                     "spatial" => "",
                     "subject" => "",
                     "tableOfContents" => "",
                     "temporal" => "",
                     "title" => "",
                     "type" => "",
                     "valid" => ""
                    }
     @@classes = {}
       
     # Return Namespace URI
     def self.get_uri
       @@uri
     end

      # Return tag to rdf doc
     def self.to_s(property,uri,value)
        @@properties[property].gsub("%uri%",uri).gsub('%value%',value)
     end
     
     #Return a list of Namespace's properties
     def self.properties
        @@properties.keys
     end

     def self.properties_form 
       list = {}
       @@properties.keys.each do |property|
         list[property] = property
       end
       list
     end 

     #Return a list of Namespace's classes
     def self.classes
        @@classes.keys
     end

     def self.classes_form 
       list = {}
       @@classes.keys.each do |c|
         list[c] = c
       end
       list
     end

   end
  end
end
