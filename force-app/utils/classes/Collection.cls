/**
 * Created by justinj on 17/09/2020.
 *
 * A fluent style collection library to help in filtering and conversion of
 */

global class Collection {

    global class CollectionException extends Exception {
    }

    private LazyIterator lazyIterator;
    private Type originalType;

    private Collection(List<Object> myCollection) {
        this.lazyIterator = new LazyIterator(myCollection.iterator());
        //originalType = Objects.getType(myCollection.iterator().next());
        //if (originalType == null) {
         //   throw new CollectionException('Unable to find type for object');
        //}
    }

    global static Collection of(List<Object> sobjects) {
        return new Collection(sobjects);
    }

    /**
     * @return A pre cast version of the asList() method call.
     * If the original type of the List or Set object was an Account then the type will
     * be List<Account> and no further casting will be required for assignment to a List<Account variable.
     */
    global List<SObject> asSObjectList(List<SObject> toList) {
        return (List<SObject>) asList(toList);
    }


    /**
     * Returns the collection with the functions applied to the list.
     * @return A List<Object> with the original type applied. So if the original list was
     * a List<Integer> it will be return as a List<Integer> and a cast can be made.
     */
    global List<Object> asList(List<Object> toList) {
        //if (originalType == null) return new List<SObject>();

        //List<Object> newCollection = new List<Object>();
        while (lazyIterator.hasNext()) toList.add(lazyIterator.next());
        return toList;
    }

    /**
     * @param leftField
     * @param value
     *
     * @return
     */
    global Collection equals(SObjectField leftField, Object value) {
        lazyIterator = new Iterators.LazyFilterIterator(lazyIterator, new qic.Filters.FieldEqualsValue(leftField, value));
        return this;
    }

    /**
     *  The
     * @param leftField The field to pull from the SObject - The
     * @param startsWith The value to check
     *
     * @return The collection.
     */
    global Collection startsWith(SObjectField leftField, String startsWith) {
        lazyIterator = new Iterators.LazyFilterIterator(lazyIterator, new qic.Filters.FieldStartsWith(leftField, startsWith));
        return this;
    }

    /**
     * @param leftField The field to pull from the SObject - The 'left' side of the equation.
     * @param rightField The field to pull from the SObject - The 'right' side of the equation.
     *
     * @return
     */
    global Collection equalsField(SObjectField leftField, SObjectField rightField) {
        lazyIterator = new Iterators.LazyFilterIterator(lazyIterator, new qic.Filters.FieldEqualsField(leftField, rightField));
        return this;
    }


    /**
     * @param leftField The field to pull from the SObject - The 'left' side of the equation.
     * @param fieldToCompare The value to compare with - The 'right' side of the equation.
     *
     * @return The collection object.
     */
    global Collection equalsField(SObjectField leftField, String fieldToCompare) {
        lazyIterator = new Iterators.LazyFilterIterator(lazyIterator, new qic.Filters.FieldEqualsField(leftField, fieldToCompare));
        return this;
    }


    private Type getListType() {
        return Type.forName('List<' + originalType.getName() + '>');
    }
}