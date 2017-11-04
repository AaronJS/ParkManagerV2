public class NamespaceUtils {
    public static string getPrefixOrNothing() {
        String[] classNameParts = String.valueOf(NamespaceUtils.class).split('\\.', 2);
        if (classNameParts.size() == 1) {
            return '';
        } else {
            return classNameParts[0] + '__';
        }
    }
}