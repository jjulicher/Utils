/**
 * Created by justinj on 22/09/2020.
 */

global virtual class LazyIterator implements Iterator<Object> {
    private final Iterator<Object> iterator;

    public LazyIterator(Iterator<Object> iterator) {
        this.iterator = iterator;
    }

    protected LazyIterator() {
//one of the more fun statements
//made possible by self-implementation ...
        this.iterator = this;
    }

    public virtual Boolean hasNext() {
        return this.iterator.hasNext();
    }

    public virtual Object next() {
        return this.iterator.next();
    }

    public List<Object> toList(List<Object> toList) {
        while(this.hasNext()) {
            toList.add(this.next());
        }
        return toList;
    }
}