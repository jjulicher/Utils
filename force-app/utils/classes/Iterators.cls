/**
 * Created by justinj on 22/09/2020.
 */

global with sharing class Iterators {

    global virtual class LazyFilterIterator extends LazyIterator {
        private Object next;
        private final qic.Filter filter;
        global LazyFilterIterator(LazyIterator iterator, qic.Filter filter) {
            super(iterator);
            this.filter = filter;
        }
        public override Boolean hasNext() {
            if(super.hasNext()) {
                this.next = super.next();
                return this.filter.apply(this.next) ? true : this.hasNext();
            }

            return false;
        }


        public override Object next() {
            return this.next;
        }
    }

}