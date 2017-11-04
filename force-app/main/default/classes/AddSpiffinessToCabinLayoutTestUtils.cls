public class AddSpiffinessToCabinLayoutTestUtils {
    public static Metadata.LayoutItem populateLayoutAndPrepLastItem(Metadata.Layout layout) {
        Metadata.LayoutSection section1 = new Metadata.LayoutSection();
        Metadata.LayoutSection section2 = new Metadata.LayoutSection();
        layout.layoutSections = new Metadata.LayoutSection[] {section1, section2};
        Metadata.LayoutColumn column1 = new Metadata.LayoutColumn();
        Metadata.LayoutColumn column2 = new Metadata.LayoutColumn();
        section2.layoutColumns = new Metadata.LayoutColumn[] {column1, column2};
        Metadata.LayoutItem item1 = new Metadata.LayoutItem();
        Metadata.LayoutItem item2 = new Metadata.LayoutItem();
        column1.layoutItems = new Metadata.LayoutItem[] {item1, item2};
        item1.field = 'Name';
        item1.behavior = Metadata.UiBehavior.Edit;
        return item2;
    }
}