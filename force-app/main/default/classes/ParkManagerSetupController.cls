public class ParkManagerSetupController {
    
    static final string namespacePrefix = NamespaceUtils.getPrefixOrNothing();
    
    public class ParkConfig {
        public Boolean campingAllowed {get; set;}
        public Boolean rvAllowed {get; set;}
        public Boolean hasPower {get; set;}
        public Boolean hasWater {get; set;}
        public Boolean hasGrizzlyBears {get; set;}
        public Boolean hasBlackBears {get; set;}
        public Boolean hasBrownBears {get; set;}
        public Boolean hasTrailblazingBear {get; set;}
        public String trailblazingBearName {get; set;}
        public Integer openHour {get; set;}
        public Integer closeHour {get; set;}
    }  
    
    
    @RemoteAction  
    public static ParkManagerSetupController.ParkConfig createConfig() {
        ParkManagerSetupController.ParkConfig config = new ParkManagerSetupController.ParkConfig();
        config.campingAllowed = false;
        config.rvAllowed = false;
        config.hasPower = false;
        config.hasWater = false;
        
        config.hasGrizzlyBears = false;
        config.hasBlackBears = false;
        config.hasBrownBears = false;
        config.hasTrailblazingBear = false;
        config.trailblazingBearName=null;
        
        config.openHour = null;
        config.closeHour = null;
        
        
        return config;
    }
    
    private static Metadata.CustomMetadataValue createCustomFieldValue(String field, Object value) {
        Metadata.CustomMetadataValue cmv = new Metadata.CustomMetadataValue();
        cmv.field = field;
        cmv.value = value;
        return cmv;
    }
    
    @RemoteAction  
    public static Id configureParkManager(ParkManagerSetupController.ParkConfig config) {
        SendMailGlobalDeployCallback callback = new SendMailGlobalDeployCallback('Park config');
        Metadata.DeployContainer container = createContainer(config);
        if (Test.isRunningTest()) {
            return null;
        } else {  
            return Metadata.Operations.enqueueDeployment(container, callback); 
        }
        
    }
    
    public static Metadata.DeployContainer createContainer(ParkManagerSetupController.ParkConfig config) {
        Metadata.CustomMetadata parkFeatures =  new Metadata.CustomMetadata();
        parkFeatures.fullName = namespacePrefix + 'Park_Config.New_Park_Config';
        parkFeatures.label = 'New Park Config';
        
        if(config.campingAllowed) {
            if(config.rvAllowed) {
                parkFeatures.values.add(ParkManagerSetupController.createCustomFieldValue(namespacePrefix + 'Allows_Recreational_Vehicles__c',true)); 
                
                if(config.hasPower) { 
                    parkFeatures.values.add(createCustomFieldValue(namespacePrefix + 'Has_Power__c',true)); 
                }
                
                if(config.hasWater) { 
                    parkFeatures.values.add(createCustomFieldValue(namespacePrefix + 'Has_Water__c',true)); 
                }       
            }    
        } 
        
        
        if(config.hasGrizzlyBears) { 
            parkFeatures.values.add(createCustomFieldValue(namespacePrefix + 'Grizzly_Bears_Present__c',true)); 
        }
        
        if(config.hasBlackBears) { 
            parkFeatures.values.add(createCustomFieldValue(namespacePrefix + 'Black_Bears_Present__c',true));           
        }
        
        if(config.hasBrownBears) { 
            parkFeatures.values.add(createCustomFieldValue(namespacePrefix + 'Brown_Bears_Present__c',true));           
        }
        
        if(config.hasTrailblazingBear) {
            parkFeatures.values.add(createCustomFieldValue(namespacePrefix + 'Trailblazing_Bear_Present__c', true));
        }
        
        if(config.trailblazingBearName != null) {
            parkFeatures.values.add(createCustomFieldValue(namespacePrefix + 'Trailblazing_Bear_Name__c', config.trailblazingBearName));
        }
        
        if(config.openHour != null) {
            parkFeatures.values.add(createCustomFieldValue(namespacePrefix + 'Opens_At__c',config.openHour));    
        }
        
        if(config.closeHour != null) {
            parkFeatures.values.add(createCustomFieldValue(namespacePrefix + 'Closes_At__c',config.closeHour));    
        }
        
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(parkFeatures);
        return mdContainer;
    }
    
    
}