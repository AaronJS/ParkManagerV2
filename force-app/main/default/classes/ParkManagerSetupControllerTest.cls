@IsTest
public class ParkManagerSetupControllerTest {
    
    public static testmethod void testCreateContainer() {
        ParkManagerSetupController.ParkConfig config = ParkManagerSetupController.createConfig();
        config.campingAllowed = true;
        config.rvAllowed = true;
        config.hasPower = true;
        config.hasWater = true;
        
        config.hasGrizzlyBears = true;
        config.hasBlackBears = true;
        config.hasBrownBears = true;
        config.hasTrailblazingBear = true;
        config.trailblazingBearName='Codey';
        
        config.openHour = 8;
        config.closeHour = 5;
        
        Metadata.DeployContainer container = ParkManagerSetupController.createContainer(config);
        System.assertEquals(1, container.getMetadata().size());
        Metadata.CustomMetadata parkFeatures = (Metadata.CustomMetadata) container.getMetadata()[0];
        System.assertEquals('New Park Config', parkFeatures.label);
        Metadata.CustomMetadataValue[] customFieldValues = parkFeatures.values;
        System.assertEquals(10, customFieldValues.size());
        for (Metadata.CustomMetadataValue customFieldValue : customFieldValues) {
            //assert things about the custom fields
        }
    }
}