module EasyData
  module RDF
   class EXIF < Namespaces
     @@uri = "http://www.w3.org/2003/12/exif/ns#"
    
     @@properties= {"_unknown" => "",
    "apertureValue" => "",
    "artist" => "",
    "bitsPerSample" => "",
    "brightnessValue" => "",
    "cfaPattern" => "",
    "colorSpace" => "",
    "componentsConfiguration" => "",
    "compressedBitsPerPixel" => "",
    "compression" => "",
    "contrast" => "",
    "copyright" => "",
    "customRendered" => "",
    "datatype" => "",
    "date" => "",
    "dateAndOrTime" => "",
    "dateTime" => "",
    "dateTimeDigitized" => "",
    "dateTimeOriginal" => "",
    "deviceSettingDescription" => "",
    "digitalZoomRatio" => "",
    "exifAttribute" => "",
    "exifVersion" => "",
    "exif_IFD_Pointer" => "",
    "exifdata" => "",
    "exposureBiasValue" => "",
    "exposureIndex" => "",
    "exposureMode" => "",
    "exposureProgram" => "",
    "exposureTime" => "",
    "fNumber" => "",
    "fileSource" => "",
    "flash" => "",
    "flashEnergy" => "",
    "flashpixVersion" => "",
    "focalLength" => "",
    "focalLengthIn35mmFilm" => "",
    "focalPlaneResolutionUnit" => "",
    "focalPlaneXResolution" => "",
    "focalPlaneYResolution" => "",
    "gainControl" => "",
    "geo" => "",
    "gpsAltitude" => "",
    "gpsAltitudeRef" => "",
    "gpsAreaInformation" => "",
    "gpsDOP" => "",
    "gpsDateStamp" => "",
    "gpsDestBearing" => "",
    "gpsDestBearingRef" => "",
    "gpsDestDistance" => "",
    "gpsDestDistanceRef" => "",
    "gpsDestLatitude" => "",
    "gpsDestLatitudeRef" => "",
    "gpsDestLongitude" => "",
    "gpsDestLongitudeRef" => "",
    "gpsDifferential" => "",
    "gpsImgDirection" => "",
    "gpsImgDirectionRef" => "",
    "gpsInfo" => "",
    "gpsInfo_IFD_Pointer" => "",
    "gpsLatitude" => "",
    "gpsLatitudeRef" => "",
    "gpsLongitude" => "",
    "gpsLongitudeRef" => "",
    "gpsMapDatum" => "",
    "gpsMeasureMode" => "",
    "gpsProcessingMethod" => "",
    "gpsSatellites" => "",
    "gpsSpeed" => "",
    "gpsSpeedRef" => "",
    "gpsStatus" => "",
    "gpsTimeStamp" => "",
    "gpsTrack" => "",
    "gpsTrackRef" => "",
    "gpsVersionID" => "",
    "height" => "",
    "ifdPointer" => "",
    "imageConfig" => "",
    "imageDataCharacter" => "",
    "imageDataStruct" => "",
    "imageDescription" => "",
    "imageLength" => "",
    "imageUniqueID" => "",
    "imageWidth" => "",
    "interopInfo" => "",
    "interoperabilityIndex" => "",
    "interoperabilityVersion" => "",
    "interoperability_IFD_Pointer" => "",
    "isoSpeedRatings" => "",
    "jpegInterchangeFormat" => "",
    "jpegInterchangeFormatLength" => "",
    "length" => "",
    "lightSource" => "",
    "make" => "",
    "makerNote" => "",
    "maxApertureValue" => "",
    "meter" => "",
    "meteringMode" => "",
    "mm" => "",
    "model" => "",
    "oecf" => "",
    "orientation" => "",
    "photometricInterpretation" => "",
    "pictTaking" => "",
    "pimBrightness" => "",
    "pimColorBalance" => "",
    "pimContrast" => "",
    "pimInfo" => "",
    "pimSaturation" => "",
    "pimSharpness" => "",
    "pixelXDimension" => "",
    "pixelYDimension" => "",
    "planarConfiguration" => "",
    "primaryChromaticities" => "",
    "printImageMatching_IFD_Pointer" => "",
    "recOffset" => "",
    "referenceBlackWhite" => "",
    "relatedFile" => "",
    "relatedImageFileFormat" => "",
    "relatedImageLength" => "",
    "relatedImageWidth" => "",
    "relatedSoundFile" => "",
    "resolution" => "",
    "resolutionUnit" => "",
    "rowsPerStrip" => "",
    "samplesPerPixel" => "",
    "saturation" => "",
    "sceneCaptureType" => "",
    "sceneType" => "",
    "seconds" => "",
    "sensingMethod" => "",
    "sharpness" => "",
    "shutterSpeedValue" => "",
    "software" => "",
    "spatialFrequencyResponse" => "",
    "spectralSensitivity" => "",
    "stripByteCounts" => "",
    "stripOffsets" => "",
    "subSecTime" => "",
    "subSecTimeDigitized" => "",
    "subSecTimeOriginal" => "",
    "subjectArea" => "",
    "subjectDistance" => "",
    "subjectDistanceRange" => "",
    "subjectLocation" => "",
    "subseconds" => "",
    "tag_number" => "",
    "tagid" => "",
    "transferFunction" => "",
    "userComment" => "",
    "userInfo" => "",
    "versionInfo" => "",
    "whiteBalance" => "",
    "whitePoint" => "",
    "width" => "",
    "xResolution" => "",
    "yCbCrCoefficients" => "",
    "yCbCrPositioning" => "",
    "yCbCrSubSampling" => "",
    "yResolution" => "" 
     }
     @@classes = {"IFD" => ""}
       
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
