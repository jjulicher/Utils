/**
 * Created by justinj on 21/09/2020.
 */

global class Objects {

    private interface TypeObject {
    }

    /**
     * @param o the Object to get the runtime type of.
     *
     * @return
     */
    global static Type getType(Object o) {
        Type myType;
        try {
            TypeObject test = (TypeObject) o;
        } catch (Exception e) {
            String message = e.getMessage();
            String typeName = message.substringAfterLast(' type ').substringBefore(' ');
            String nameSpace = '';
            if(typeName.contains('.')){
                nameSpace = typeName.substringBefore('.');
                typeName = typeName.substringAfter('.');
            }
            myType = Type.forName(nameSpace, typeName);
        }
        return myType;
    }

}