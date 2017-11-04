@IsTest
public class AddSpiffinessToCabinLayoutTest {
public static testmethod void testLoadCabinLayout() {
        Metadata.Layout cabinLayout = new AddSpiffinessToCabinLayout().loadCabinLayout();
        System.assert(cabinLayout != null);
    }
    
    public static testmethod void testHasSpiffinessPositive() {
        Metadata.Layout layoutWithSpiffiness = new Metadata.Layout();
        Metadata.LayoutItem spiffinessItem = AddSpiffinessToCabinLayoutTestUtils.populateLayoutAndPrepLastItem(layoutWithSpiffiness);
        spiffinessItem.field = 'Spiffiness__c';
        spiffinessItem.behavior = Metadata.UiBehavior.Edit;
        System.assert(new AddSpiffinessToCabinLayout().hasSpiffiness(layoutWithSpiffiness));
    }
    
    public static testmethod void testHasSpiffinessNegative() {
        Metadata.Layout layoutWithoutSpiffiness = new Metadata.Layout();
        Metadata.LayoutItem nonSpiffinessItem = AddSpiffinessToCabinLayoutTestUtils.populateLayoutAndPrepLastItem(layoutWithoutSpiffiness);
        nonSpiffinessItem.field = 'Something_Else__c';
        nonSpiffinessItem.behavior = Metadata.UiBehavior.Edit;
        System.assert(! new AddSpiffinessToCabinLayout().hasSpiffiness(layoutWithoutSpiffiness));
    }
    
    public static testmethod void testFindInfoSection() {
        Metadata.Layout cabinLayout = new AddSpiffinessToCabinLayout().loadCabinLayout();
        Metadata.LayoutSection infoSection = new AddSpiffinessToCabinLayout().findInfoSection(cabinLayout);
        System.assert(infoSection != null);
    }
    
    public static testmethod void testAddSpiffinessItemToSection() {
        Metadata.LayoutSection section = new Metadata.LayoutSection();
        Metadata.LayoutColumn column = new Metadata.LayoutColumn();
        section.layoutColumns = new Metadata.LayoutColumn[] { column };
        new AddSpiffinessToCabinLayout().addSpiffinessItemToSection(section);
        System.assert(column.layoutItems.size() == 1);
    }
    
    public static testmethod void testCreateDeployContainer() {
        Metadata.Layout cabinLayout = new AddSpiffinessToCabinLayout().loadCabinLayout();
        Metadata.DeployContainer container = new AddSpiffinessToCabinLayout().createDeployContainer(cabinLayout);
        System.assertEquals(cabinLayout, container.getMetadata()[0]);
    }
}