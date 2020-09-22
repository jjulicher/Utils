/**
 * Created by justinj on 22/09/2020.
 */

global class Filters {


    global abstract class FieldFilter implements Filter {
        protected SObjectField field;

        global FieldFilter(SObjectField field) {
            this.field = field;
        }

        global abstract Boolean apply(Object functionSObject);
    }

    global class FieldEqualsField extends FieldFilter {
        private String fieldToCompare;

        global FieldEqualsField(SObjectField field, SObjectField fieldToCompareWith) {
            super(field);
            this.fieldToCompare = fieldToCompareWith.getDescribe().getName();
        }

        global FieldEqualsField(SObjectField field, String fieldNameToCompareWith) {
            super(field);
            this.fieldToCompare = fieldNameToCompareWith;
        }

        global override Boolean apply(Object filterObject) {
            SObject functionSObject = (SObject) filterObject;
            return functionSObject.get(field) == functionSObject.get(this.fieldToCompare);
        }
    }

    global class FieldEqualsValue extends FieldFilter {
        private Object value;

        global FieldEqualsValue(SObjectField field, Object value) {
            super(field);
            this.value = value;
        }

        global override Boolean apply(Object filterObject) {
            SObject functionSObject = (SObject) filterObject;
            return functionSObject.get(field) == value;
        }
    }

    global class FieldStartsWith extends FieldFilter {
        private String startsWith;

        global FieldStartsWith(SObjectField field, String startsWith) {
            super(field);
            this.startsWith = startsWith;
        }

        global override Boolean apply(Object functionObject) {
            SObject functionSObject = (SObject) functionObject;
            Object leftValue = functionSObject.get(field);
            return String.valueOf(leftValue).startsWith(startsWith);
        }
    }


    global class FieldHasChanged extends FieldFilter {
        global FieldHasChanged(SObjectField field) {
            super(field);
        }

        global override Boolean apply(Object functionObject) {
            if (!(functionObject instanceof SObject)) {
                throw new qic.InvalidContextException('Function object is not a SObject Type');
            }
            if (!Trigger.isExecuting) {
                throw new qic.InvalidContextException('Field has changed needs to be running in a trigger context');
            }

            if (Trigger.isUpdate) {
                SObject mySObject = (SObject) functionObject;
                SObject oldSObject = Trigger.oldMap.get(mySObject.Id);
                Object newValue = mySObject.get(field);
                Object oldValue = oldSObject.get(field);
                return newValue != oldValue;
            } else {
                return true;
            }
        }
    }
}