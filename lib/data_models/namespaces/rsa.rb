module EasyData
  module RDF
   class RSA < Namespaces

     @@uri = "http://www.w3.org/ns/auth/rsa#"
     @@properties= {"modulus" => "",
                    "private_exponent" => "",
                    "public_exponent" => "" 
                   }
    
     @@classes = {"RSAKey" => "",
                  "RSAPrivateKey" => "",
                  "RSAPublicKey" => ""
     }
 
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
