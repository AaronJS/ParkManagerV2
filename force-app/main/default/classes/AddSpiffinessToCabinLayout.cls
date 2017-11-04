public class AddSpiffinessToCabinLayout implements InstallHandler {
    static final string namespacePrefix = NamespaceUtils.getPrefixOrNothing();
    
    public void onInstall(InstallContext ctx) {
        Metadata.Layout cabinLayout = loadCabinLayout();
        if (!hasSpiffiness(cabinLayout)) {
          Metadata.LayoutSection infoSection = findInfoSection(cabinLayout);
            addSpiffinessItemToSection(infoSection);
            Metadata.Operations.enqueueDeployment(createDeployContainer(cabinLayout), new SendMailGlobalDeployCallback('Cabin Layout Update'));
        }
    }
    
    public Metadata.Layout loadCabinLayout() {
        return (Metadata.Layout) Metadata.Operations.retrieve(
            Metadata.MetadataType.Layout,
            new String[] {namespacePrefix + 'Cabin__c-' + namespacePrefix + 'Cabin Layout'}
        )[0];
    }
    
    public boolean hasSpiffiness(Metadata.Layout layout) {
        for (Metadata.LayoutSection section : layout.layoutSections) {
            for (Metadata.LayoutColumn column : section.layoutColumns) {
                if (column.layoutItems != null) {
                    for (Metadata.LayoutItem item : column.layoutItems) {
                        if (item.field != null && item.field.endsWith('Spiffiness__c')) {
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }
    
    public Metadata.LayoutSection findInfoSection(Metadata.Layout layout) {
        for (Metadata.LayoutSection section : layout.layoutSections) {
            if ('Information'.equals(section.label) && !section.customLabel) {
                return section;
            }
        }
        return null;
    }
    
    public void addSpiffinessItemToSection(Metadata.LayoutSection section) {
        Metadata.LayoutItem spiffinessItem = new Metadata.LayoutItem();
        section.layoutColumns[0].layoutItems.add(spiffinessItem);
        spiffinessItem.field = namespacePrefix + 'Spiffiness__c';
        spiffinessItem.behavior = Metadata.UiBehavior.Edit;
    }
    
    public Metadata.DeployContainer createDeployContainer(Metadata.Layout layoutToDeploy) {
        Metadata.DeployContainer container = new Metadata.DeployContainer();
        container.addMetadata(layoutToDeploy);
        return container;
    }
}